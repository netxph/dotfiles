#!/usr/bin/env python3
"""Start Herdr workspace from a TOML-like layout file.
Port of PowerShell Start-Herdr for POSIX shells (callable from fish).
Usage: start-herdr.py [layout-file]
"""
import sys, os, re, json, subprocess, time

REPO_HERDR = '/home/netxph/Projects/dotfiles/herdr'


def convert_value(val):
    v = val.strip()
    if v.startswith('"') and v.endswith('"'):
        # use JSON to unescape
        return json.loads(v)
    if v.startswith("'") and v.endswith("'"):
        return v[1:-1]
    if v == 'true':
        return True
    if v == 'false':
        return False
    if re.match(r'^-?\d+(\.\d+)?$', v):
        try:
            if '.' in v:
                return float(v)
            return int(v)
        except:
            return float(v)
    return v


def import_herdr_layout(path):
    tabs = {}
    layout = {}
    section = ''
    pane = None
    with open(path, 'r', encoding='utf-8') as f:
        for raw in f:
            line = re.sub(r'\s+#.*$', '', raw).strip()
            if not line:
                continue
            m = re.match(r'^\[\[tabs\.([^\.\]]+)\.panes\]\]$', line)
            if m:
                tabName = m.group(1)
                if tabName not in tabs:
                    tabs[tabName] = {'panes': []}
                pane = {}
                tabs[tabName]['panes'].append(pane)
                section = f'tabs.{tabName}.panes'
                continue
            m = re.match(r'^\[tabs\.([^\.\]]+)\]$', line)
            if m:
                tabName = m.group(1)
                if tabName not in tabs:
                    tabs[tabName] = {'panes': []}
                section = f'tabs.{tabName}'
                pane = None
                continue
            m = re.match(r'^\[([^\]]+)\]$', line)
            if m:
                section = m.group(1)
                pane = None
                continue
            m = re.match(r'^([^=]+)=(.*)$', line)
            if not m:
                raise ValueError(f"Invalid TOML in '{path}': {line}")
            key = m.group(1).strip()
            value = convert_value(m.group(2).strip())
            if section == 'layout':
                layout[key] = value
            else:
                mtab = re.match(r'^tabs\.([^\.]+)$', section)
                if mtab:
                    tabs[mtab.group(1)][key] = value
                else:
                    mtab2 = re.match(r'^tabs\.([^\.]+)\.panes$', section)
                    if mtab2:
                        pane[key] = value
    return {'layout': layout, 'tabs': tabs}


def run(cmd, capture=True, check=False):
    if capture:
        p = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    else:
        p = subprocess.run(cmd)
    if check and p.returncode != 0:
        raise RuntimeError(f"Command failed: {' '.join(cmd)}\nstdout:{p.stdout}\nstderr:{p.stderr}")
    return p


def ensure_server_running():
    p = run(['herdr', 'status', 'server'])
    if 'status: running' in (p.stdout or ''):
        return
    # start server
    devnull = open(os.devnull, 'w')
    subprocess.Popen(['herdr', 'server'], stdout=devnull, stderr=devnull)
    for _ in range(50):
        time.sleep(0.1)
        p = run(['herdr', 'status', 'server'])
        if 'status: running' in (p.stdout or ''):
            return
    raise RuntimeError('Herdr server failed to start.')


def main(argv):
    layout = argv[1] if len(argv) > 1 else 'dev.toml'
    layout_path = layout
    if not os.path.exists(layout_path):
        candidate = os.path.join(REPO_HERDR, layout)
        if os.path.exists(candidate):
            layout_path = candidate
        else:
            print(f"Layout file not found: {layout}")
            sys.exit(2)
    layout_path = os.path.realpath(layout_path)
    config = import_herdr_layout(layout_path)
    if len(config['tabs'].keys()) == 0:
        raise RuntimeError(f"Layout '{layout_path}' contains no tabs.")

    cwd = os.getcwd()
    workspaceName = os.path.basename(cwd) or cwd

    ensure_server_running()

    tabName = list(config['tabs'].keys())[0]
    tabConfig = config['tabs'][tabName]
    label = tabConfig.get('label') or workspaceName
    label = label.replace('{workspace}', workspaceName)

    p = run(['herdr', 'workspace', 'create', '--cwd', cwd, '--label', label, '--focus'])
    if p.returncode != 0:
        raise RuntimeError('Herdr failed to create the workspace. Is the Herdr server running?\n' + (p.stderr or ''))
    workspace = json.loads(p.stdout)
    root_pane = workspace['result']['root_pane']
    if not root_pane.get('pane_id'):
        raise RuntimeError('Herdr failed to create root pane')

    panes = {}
    rootPane = None
    for pane in tabConfig.get('panes', []):
        if 'from' not in pane or pane.get('from') in (None, False, ''):
            rootPane = pane
            break
    if rootPane is None:
        raise RuntimeError(f"Tab '{tabName}' has no root pane.")
    panes[rootPane['id']] = root_pane['pane_id']

    for paneConfig in [p for p in tabConfig.get('panes', []) if p.get('from')]:
        if paneConfig['from'] not in panes:
            raise RuntimeError(f"Pane '{paneConfig['from']}' must be created before '{paneConfig['id']}'.")
        splitArgs = [ 'herdr', 'pane', 'split', panes[paneConfig['from']], '--direction', paneConfig['split'], '--cwd', cwd, '--no-focus' ]
        if paneConfig.get('ratio') is not None:
            splitArgs += ['--ratio', str(paneConfig['ratio'])]
        p = run(splitArgs)
        if p.returncode != 0:
            raise RuntimeError(f"Herdr failed to create pane '{paneConfig['id']}'.\n{p.stderr}")
        res = json.loads(p.stdout)
        panes[paneConfig['id']] = res['result']['pane']['pane_id']

    for paneConfig in tabConfig.get('panes', []):
        if paneConfig.get('command'):
            pane_id = panes[paneConfig['id']]
            # pass command as a single argument
            rc = subprocess.run(['herdr', 'pane', 'run', pane_id, paneConfig['command']])
            if rc.returncode != 0:
                raise RuntimeError(f"Herdr failed to start '{paneConfig['command']}'.")

    p = run(['herdr', 'tab', 'list'])
    tabs = json.loads(p.stdout)['result']['tabs']
    the_tab = None
    for t in tabs:
        if t.get('workspace_id') == workspace['result']['root_pane'].get('workspace_id'):
            the_tab = t
            break
    if the_tab is None:
        raise RuntimeError('Herdr failed to find the new tab.')
    rc = subprocess.run(['herdr', 'tab', 'rename', the_tab['tab_id'], label])
    if rc.returncode != 0:
        raise RuntimeError('Herdr failed to name the tab.')


if __name__ == '__main__':
    try:
        main(sys.argv)
    except Exception as e:
        print('Error:', e, file=sys.stderr)
        sys.exit(1)
