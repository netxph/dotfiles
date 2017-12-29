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

function VS12()
{
    $vs120comntools = (Get-ChildItem env:VS120COMNTOOLS).Value
    $batchFile = [System.IO.Path]::Combine($vs120comntools, "VsDevCmd.bat")
    Get-Batchfile $BatchFile

    [System.Console]::Title = "Visual Studio 2013 Windows PowerShell"
}

function VS15()
{
    $vs140comntools = (Get-ChildItem env:VS140COMNTOOLS).Value
    $batchFile = [System.IO.Path]::Combine($vs140comntools, "VsDevCmd.bat")
    Get-Batchfile $BatchFile

    [System.Console]::Title = "Visual Studio 2015 Windows PowerShell"
}

function VS17()
{
    $vs140comntools = "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\Common7\Tools\"
    $batchFile = [System.IO.Path]::Combine($vs140comntools, "VsDevCmd.bat")
    Get-Batchfile $BatchFile

    [System.Console]::Title = "Visual Studio 2017 Windows PowerShell"
}


function Invoke-SqlLocalDbCmd([string]$Database, [string]$Query)
{
    Push-Location
    Invoke-Sqlcmd -ServerInstance '(localdb)\v11.0' -Database $Database -Query $Query
    Pop-Location
}

function Invoke-SqlLocalCmd([string]$Database, [string]$Query)
{
    Push-Location
    Invoke-Sqlcmd -Database $Database -Query $Query
    Pop-Location
}
	
function Test-Port($hostname, $port)
{
    # This works no matter in which form we get $host - hostname or ip address
    try {
        $ip = [System.Net.Dns]::GetHostAddresses($hostname) | 
            select-object IPAddressToString -expandproperty  IPAddressToString
        if($ip.GetType().Name -eq "Object[]")
        {
            #If we have several ip's for that address, let's take first one
            $ip = $ip[0]
        }
    } catch {
        Write-Host "Possibly $hostname is wrong hostname or IP"
        return
    }
    $t = New-Object Net.Sockets.TcpClient
    # We use Try\Catch to remove exception info from console if we can't connect
    try
    {
        $t.Connect($ip,$port)
    } catch {}

    if($t.Connected)
    {
        $t.Close()
        $msg = "Port $port is operational"
    }
    else
    {
        $msg = "Port $port on $ip is closed, "
        $msg += "You may need to contact your IT team to open it. "                                 
    }
    Write-Host $msg
}

$nca = "http://tfs-prod-pc:8080/tfs/primarycollection"

#
# Add redshells
#
# Import-Module pscx -arg D:\Users\vitalim\Documents\WindowsPowerShell\Pscx.UserPreferences.ps1
# import-module RedShells

# set-alias go Set-Workspace
# set-alias addw Add-Workspace
# set-alias getw Get-Workspaces
# set-alias delw Remove-Workspace
# set-alias auto Invoke-Script
# set-alias adds Add-Script
# set-alias gets Get-Scripts
# set-alias dels Remove-Script
# set-alias sqllocaldb Invoke-SqlLocalDbCmd
# set-alias sqllocal Invoke-SqlLocalCmd
# set-alias copy-f Write-Clipboard
# set-alias paste-f Read-Clipboard

# import-module sqlps -disablenamechecking

"Visual Studio 2017 Windows PowerShell"
"Powershell Environment by Marc Vitalis"
""

VS17
set-location "c:\users\vitalism"

