# This file contains sensitive information and machine-specific paths.
# Copy this to 'secrets.ps1' in your PowerShell profile directory and fill in the values.

$env:NUGET_ACCESSTOKEN = "YOUR_TOKEN_HERE"
$env:ACR_TOKEN = "YOUR_TOKEN_HERE"
$env:KAFKA_CLUSTER_ID = "YOUR_ID_HERE"

# Machine specific paths
$env:PATH = "C:/Users/netxph/.local/bin;$env:PATH"
$env:PATH = "C:/Program Files/AMD/ROCm/7.1/bin;$env:PATH"

# Variables
$DOTFILES_PATH = "C:/Users/netxph/Projects/dotfiles"
