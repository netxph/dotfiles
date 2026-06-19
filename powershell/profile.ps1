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

function Ask-Pi ($request) {
    # 1. Embed the context directly into the prompt payload
    $contextPayload = @"
System Instructions:
You are an instant PowerShell command translator.
Rules:
- Output ONLY the executable PowerShell or Git command string.
- DO NOT wrap the output in markdown code blocks (no ``` or 
```powershell).
- DO NOT provide explanations, introductory text, or conversational fluff.
- If placeholders are required, format them strictly as <placeholder>.

User Request: $request
"@

    # 2. Fetch the command instantly from Pi
    $command = pi --print $contextPayload
    $command = $command.Trim()

    if ([string]::IsNullOrWhiteSpace($command)) {
        Write-Host "Pi didn't return a command." -ForegroundColor Red
        return
    }

    # 3. Display it safely for your review
    Write-Host "`nProposed Command:" -ForegroundColor Cyan
    Write-Host "----------------" -ForegroundColor Cyan
    Write-Host "  $command" -ForegroundColor Yellow
    Write-Host "----------------" -ForegroundColor Cyan

    # 4. Prompt for execution confirmation
    $choices = [System.Management.Automation.Host.ChoiceDescription[]] @(
        New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Execute the command"
        New-Object System.Management.Automation.Host.ChoiceDescription "&No", "Cancel execution"
    )
    
    $decision = $Host.UI.PromptForChoice("Execution Confirmation", "Do you want to run this command?", $choices, 1)

    # 5. Execute or abort safely
    if ($decision -eq 0) {
        Write-Host "Running command...`n" -ForegroundColor Green
        Invoke-Expression $command
    } else {
        Write-Host "Operation cancelled." -ForegroundColor DarkGray
    }
}
