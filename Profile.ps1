(Get-Host).UI.RawUI.ForegroundColor = "gray"
(Get-Host).UI.RawUI.BackgroundColor = "black"

function prompt
{
   Write-host("[" + $(get-location) + "]") -foregroundcolor Green
   return "$ "
}


function Get-Batchfile ($file) {
    $cmd = "`"$file`" & set"
    cmd /c $cmd | Foreach-Object {
        $p, $v = $_.split('=')
        Set-Item -path env:$p -value $v
    }
}

function VS9()
{
    $vs90comntools = (Get-ChildItem env:VS90COMNTOOLS).Value
    $batchFile = [System.IO.Path]::Combine($vs90comntools, "vsvars32.bat")
    Get-Batchfile $BatchFile

    [System.Console]::Title = "Visual Studio 2008 Windows PowerShell"
}

function VS10()
{
    $vs100comntools = (Get-ChildItem env:VS100COMNTOOLS).Value
    $batchFile = [System.IO.Path]::Combine($vs100comntools, "vsvars32.bat")
    Get-Batchfile $BatchFile

    [System.Console]::Title = "Visual Studio 2010 Windows PowerShell"
}

function VS11()
{
    $vs110comntools = (Get-ChildItem env:VS110COMNTOOLS).Value
    $batchFile = [System.IO.Path]::Combine($vs110comntools, "VsDevCmd.bat")
    Get-Batchfile $BatchFile

    [System.Console]::Title = "Visual Studio 2012 Windows PowerShell"
}

#
# Add redshells
#

import-module RedShells

set-alias go Set-Workspace
set-alias addw Add-Workspace
set-alias getw Get-Workspaces
set-alias delw Remove-Workspace
set-alias auto Invoke-Script
set-alias adds Add-Script
set-alias gets Get-Scripts
set-alias dels Remove-Script
# set-alias copy-f Write-Clipboard
# set-alias paste-f Read-Clipboard

# import-module sqlps -disablenamechecking

# set home
$env:HOMEDRIVE = 'D:'
$env:HOMEPATH = '\users\vitalim\'

# set path
$env:Path += ';D:\users\vitalim\shell'

"Visual Studio 2008 Windows PowerShell"
"Powershell Environment by Marc Vitalis"
""

VS11
set-location "d:\users\vitalim"
(get-psprovider 'FileSystem').Home = "d:\users\vitalim"
