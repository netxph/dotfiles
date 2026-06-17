# Dot-source secrets if they exist
$secretsPath = Join-Path (Split-Path $profile -Parent) "secrets.ps1"
if (Test-Path $secretsPath) {
    . $secretsPath
}

Import-Module gsudoModule
Import-Module Terminal-Icons
Import-Module Pester

oh-my-posh init pwsh --config https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/amro.omp.json | Invoke-Expression

Set-Alias -Name k -Value kubectl
Set-Alias -name kc -Value kubecolor

$env:KIND_EXPERIMENTAL_PROVIDER="podman"
$env:ENVIRONMENT_CONFIG = "production"
$env:KUBE_EDITOR="nvim"

Set-Alias -Name py -Value python3

Invoke-Expression (& { (zoxide init powershell | Out-String) })
$env:ZELLIJ_CONFIG_DIR="$HOME/.config/zellij/config"
$env:ZELLIJ_NOTES_CWD="$HOME/Notes"

function Start-Zellij {
    param(
        [Parameter(Position = 0)]
        [string]$Path = "."
    )
    $absPath = (Resolve-Path $Path).Path
    $env:ZELLIJ_CWD = $absPath
    
    # Use variable from secrets or fallback to default
    $layoutBase = if ($null -ne $DOTFILES_PATH) { $DOTFILES_PATH } else { "$HOME/Projects/dotfiles" }
    zellij --layout "$layoutBase/zellij/base-layout.windows.kdl"
}
