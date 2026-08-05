$ErrorActionPreference = 'Stop'

function Link-Config {
    param(
        [Parameter(Mandatory)] [string]$Source,
        [Parameter(Mandatory)] [string]$Destination
    )

    $parent = Split-Path -Parent $Destination
    New-Item -ItemType Directory -Path $parent -Force | Out-Null

    if (Test-Path -LiteralPath $Destination) {
        $existing = Get-Item -LiteralPath $Destination -Force
        if ($existing.LinkType -eq 'SymbolicLink' -and
            (Resolve-Path -LiteralPath $Destination).Path -eq (Resolve-Path -LiteralPath $Source).Path) {
            Write-Host "Already linked: $Destination"
            return
        }

        $backup = "$Destination.backup-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
        $answer = Read-Host "WARNING: existing path found: $Destination`nMove it to $backup and replace it with a symlink? [y/N]"
        if ($answer -notmatch '^(y|yes)$') {
            throw "Refusing to replace existing path: $Destination"
        }

        Rename-Item -LiteralPath $Destination -NewName (Split-Path -Leaf $backup)
        Write-Host "Backed up: $Destination -> $backup"
    }

    New-Item -ItemType SymbolicLink -Path $Destination -Target $Source | Out-Null
    Write-Host "Linked: $Destination -> $Source"
}

$repo = $PSScriptRoot

Link-Config `
    (Join-Path $repo 'powershell') `
    (Join-Path ([Environment]::GetFolderPath('MyDocuments')) 'PowerShell')

Link-Config `
    (Join-Path $repo 'terminal/settings.json') `
    (Join-Path $env:LOCALAPPDATA 'Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json')

Link-Config `
    (Join-Path $repo 'alacritty') `
    (Join-Path $env:APPDATA 'alacritty')

Link-Config `
    (Join-Path $repo 'herdr') `
    (Join-Path $env:APPDATA 'herdr')
