function ConvertFrom-HerdrTomlValue {
    param([string]$Value)

    $Value = $Value.Trim()
    if ($Value -match '^"(.*)"$') {
        return ($Value | ConvertFrom-Json)
    }
    if ($Value -match "^'(.*)'$") {
        return $Matches[1]
    }
    if ($Value -eq 'true') { return $true }
    if ($Value -eq 'false') { return $false }
    if ($Value -match '^-?\d+(\.\d+)?$') { return [double]$Value }
    return $Value
}

function Import-HerdrLayout {
    param([Parameter(Mandatory)][string]$Path)

    $tabs = @{}
    $layout = @{}
    $section = ''
    $pane = $null

    foreach ($line in Get-Content -LiteralPath $Path) {
        $line = ($line -replace '\s+#.*$', '').Trim()
        if (-not $line) { continue }

        if ($line -match '^\[\[tabs\.([^\.\]]+)\.panes\]\]$') {
            $tabName = $Matches[1]
            if (-not $tabs.ContainsKey($tabName)) { $tabs[$tabName] = @{ panes = @() } }
            $pane = @{}
            $tabs[$tabName].panes += $pane
            $section = "tabs.$tabName.panes"
            continue
        }
        if ($line -match '^\[tabs\.([^\.\]]+)\]$') {
            $tabName = $Matches[1]
            if (-not $tabs.ContainsKey($tabName)) { $tabs[$tabName] = @{ panes = @() } }
            $section = "tabs.$tabName"
            $pane = $null
            continue
        }
        if ($line -match '^\[([^\]]+)\]$') {
            $section = $Matches[1]
            $pane = $null
            continue
        }
        if ($line -notmatch '^([^=]+)=(.*)$') { throw "Invalid TOML in '$Path': $line" }

        $key = $Matches[1].Trim()
        $value = ConvertFrom-HerdrTomlValue $Matches[2]
        if ($section -eq 'layout') {
            $layout[$key] = $value
        } elseif ($section -match '^tabs\.([^\.]+)$') {
            $tabs[$Matches[1]][$key] = $value
        } elseif ($section -match '^tabs\.([^\.]+)\.panes$') {
            $pane[$key] = $value
        }
    }

    return @{ layout = $layout; tabs = $tabs }
}

function Start-Herdr {
    param(
        [Parameter(Mandatory)]
        [string]$Layout
    )

    $layoutPath = $Layout
    if (-not (Test-Path -LiteralPath $layoutPath -PathType Leaf)) {
        $layoutPath = Join-Path $PSScriptRoot $Layout
    }
    $layoutPath = (Resolve-Path -LiteralPath $layoutPath -ErrorAction Stop).Path
    $config = Import-HerdrLayout $layoutPath
    if ($config.tabs.Count -eq 0) { throw "Layout '$layoutPath' contains no tabs." }

    $cwd = (Get-Location).Path
    $workspaceName = (Get-Item -LiteralPath $cwd).Name
    if ([string]::IsNullOrWhiteSpace($workspaceName)) { $workspaceName = $cwd }

    $serverStatus = herdr status server 2>$null
    if (-not ($serverStatus -match 'status: running')) {
        $herdrExe = (Get-Command herdr -CommandType Application -ErrorAction Stop).Source
        Start-Process -FilePath $herdrExe -ArgumentList 'server' -WindowStyle Hidden | Out-Null
        for ($attempt = 0; $attempt -lt 50; $attempt++) {
            Start-Sleep -Milliseconds 100
            $serverStatus = herdr status server 2>$null
            if ($serverStatus -match 'status: running') { break }
        }
    }
    if (-not ($serverStatus -match 'status: running')) { throw 'Herdr server failed to start.' }

    $tabName = @($config.tabs.Keys)[0]
    $tabConfig = $config.tabs[$tabName]
    $label = if ($tabConfig.label) { $tabConfig.label } else { $workspaceName }
    $label = $label -replace '\{workspace\}', $workspaceName
    $workspace = (& herdr workspace create --cwd $cwd --label $label --focus | ConvertFrom-Json)
    if ($LASTEXITCODE -ne 0 -or $null -eq $workspace.result.root_pane.pane_id) {
        throw 'Herdr failed to create the workspace. Is the Herdr server running?'
    }

    $panes = @{}
    $rootPane = @($tabConfig.panes | Where-Object { -not $_.from })[0]
    if ($null -eq $rootPane) { throw "Tab '$tabName' has no root pane." }
    $panes[$rootPane.id] = $workspace.result.root_pane.pane_id

    foreach ($paneConfig in @($tabConfig.panes | Where-Object { $_.from })) {
        if (-not $panes.ContainsKey($paneConfig.from)) { throw "Pane '$($paneConfig.from)' must be created before '$($paneConfig.id)'." }
        $splitArgs = @($panes[$paneConfig.from], '--direction', $paneConfig.split, '--cwd', $cwd, '--no-focus')
        if ($null -ne $paneConfig.ratio) { $splitArgs += @('--ratio', $paneConfig.ratio) }
        $result = (& herdr pane split @splitArgs | ConvertFrom-Json)
        if ($LASTEXITCODE -ne 0 -or $null -eq $result.result.pane.pane_id) { throw "Herdr failed to create pane '$($paneConfig.id)'." }
        $panes[$paneConfig.id] = $result.result.pane.pane_id
    }

    foreach ($paneConfig in @($tabConfig.panes)) {
        if ($paneConfig.command) {
            & herdr pane run $panes[$paneConfig.id] $paneConfig.command | Out-Null
            if ($LASTEXITCODE -ne 0) { throw "Herdr failed to start '$($paneConfig.command)'." }
        }
    }

    $tabs = (& herdr tab list | ConvertFrom-Json).result.tabs
    $tab = $tabs | Where-Object workspace_id -eq $workspace.result.root_pane.workspace_id | Select-Object -First 1
    if ($null -eq $tab) { throw 'Herdr failed to find the new tab.' }
    & herdr tab rename $tab.tab_id $label | Out-Null
    if ($LASTEXITCODE -ne 0) { throw 'Herdr failed to name the tab.' }

}

function Start-HerdrDev {
    Start-Herdr -Layout 'dev.toml'
}
