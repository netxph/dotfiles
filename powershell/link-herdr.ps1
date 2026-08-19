Param(
  [Parameter(Mandatory=$false)]
  [ValidateSet('windows','linux')]
  [string]$Mode = "windows"
)
$Repo = "C:\\Users\\netxph\\Projects\\dotfiles\\herdr"
if ($Mode -eq 'windows') {
  $Src = Join-Path $Repo 'config.windows.toml'
  $TargetDir = Join-Path $env:APPDATA 'herdr'
} else {
  $Src = Join-Path $Repo 'config.linux.toml'
  $TargetDir = Join-Path $env:USERPROFILE '.config\herdr'
}
if (-not (Test-Path $TargetDir)) { New-Item -ItemType Directory -Path $TargetDir | Out-Null }
$Target = Join-Path $TargetDir 'config.toml'
if (Test-Path $Target -PathType Any) { Move-Item -Path $Target -Destination "${Target}.bak" -Force }
New-Item -ItemType SymbolicLink -Path $Target -Target $Src -Force | Out-Null
Write-Host "Linked $Src -> $Target"
