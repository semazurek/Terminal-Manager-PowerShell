<#
Script by Rikey 2020.05.29
LAUNCH SCRIPT VIA POWERSHELL
#>

#CREDENTIALS USED BY YOU:
$credent = $env:USERNAME+'@'+$env:USERDOMAIN

<#PART RESPONSIBLE FOR ANNOUNCEMENT IN NOTIFICATION#>
Add-Type -AssemblyName System.Windows.Forms
$global:balloon = New-Object System.Windows.Forms.NotifyIcon

#VOID {} Doesn't work
[void](Register-ObjectEvenT -InputObject $balloon -EventName MouseDoubleClick -SourceIdentifier IconClicked -Action {
$global:balloon.dispose()
Unregister-Event -SourceIdentifier IconClicked
Remove-Job -Name IconClicked
Remove-Variable
 -Name  balloon -Scope Global
})
$path = (Get-Process -id $pid).Path
    $balloon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path)

[System.Windows.Forms.ToolTipIcon] | Get-Member -Static -Type Property

$balloon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Info

$balloon.BalloonTipText = "Remember to use the script from the Administrator level ☺"
$balloon.BalloonTipTitle = "Hi $Env:USERNAME"
$balloon.Visible = $true

$balloon.ShowBalloonTip(30000)
<#PART RESPONSIBLE FOR ANNOUNCEMENT IN NOTIFICATION#>


$localip=((ipconfig | findstr [0-9].\.)[0]).Split()[-1]
$localday=Get-Date -Format "dddd"

function Menu
{ 
     param ( 
           [string]$Title = 'Terminal Manager')
     mode.com con: lines=18 cols=65
     $HOST.UI.RAWUI.WINDOWTITLE = $Title + " v2.0.5.29"
     $localdatetime=Get-Date -Format "MM/dd/yyyy HH:mm"
     cls
     Write-Host ""
     Write-Host " ┌──────────── $Title ────────────┬────── Info ──────┐" 
     Write-Host " │                                          │"
     Write-Host " │ [1] Active Directory as an Administrator │ $env:COMPUTERNAME"
     Write-Host " │ [2] Remote control (MSTSC)               │ $localip"
     Write-Host " │ [3] Shutdown, restart or logoff remotely │"
     Write-Host " │ [4] Station information                  │ $env:USERNAME"
     Write-Host " │ [5] Send a message to the station        │ $ENV:USERDOMAIN"
     Write-Host " │ [6] Executing commands at the station    │"
     Write-Host " │ [7] Show disk serial numbers             │ $localday"
     Write-Host " │ [8] Powershell as Administrator          │ $localdatetime"
     Write-Host " │ [x] Press 'X' to exit.                   │"
     Write-Host " │                                          │"
     Write-Host " └──────────── $Title ────────────┴──────────────────┘"
}
do{ 
     Menu
     $key = $Host.UI.RawUI.ReadKey()
	if ($key.Character -eq 'x') {
  	exit
    }

	if ($key.Character -eq '1') {
    Write-Host ""
    runas /savecred /user:$credent "powershell dsa msc"
	}

	if ($key.Character -eq '2') {
    Write-Host ""
  	mstsc
	}

	if ($key.Character -eq '3') {
    Write-Host ""
    $IP = Read-Host "Enter IP / Name"
    mode.com con: lines=18 cols=55
    Write-Host "Select: R - Restart, S - Shutdown, L - Logout"
    $choice = $Host.UI.RawUI.ReadKey()
    do {
	if ($choice.Character -eq 'R') {
    runas /savecred /user:$credent "powershell Invoke-Command -ComputerName $IP -ScriptBlock {shutdown /r /t 10 /c 'Remote restart by the Administrator'}" 
    pause
    break} 
    if ($choice.Character -eq 'S') {
    runas /savecred /user:$credent "powershell Invoke-Command -ComputerName $IP -ScriptBlock {shutdown /s /t 10 /c 'Remote shutdown by the Administrator' }"
    break}
    if ($choice.Character -eq 'L') {
    cls
    mode.com con: lines=18 cols=90
    query user /server:$IP
    $IDLogout = Read-Host "Enter User ID"
    runas /savecred /user:$credent "powershell Invoke-Command -ComputerName $IP -ScriptBlock {logoff $IDLogout}"
    break}
    if ($choice.Character -eq 'x') {break}
    } until ($input -eq 'x') 
	}
 
	if ($key.Character -eq '4') {
    Write-Host ""
    mode.com con: lines=50 cols=100
    systeminfo | FINDSTR "Host OS Owner Boot System Bios Memory Domain Logon Network [01]"
    #$IP = Read-Host "Enter IP / Name"
    #systeminfo /s \\$IP /u $credent | FINDSTR "Host OS Owner Boot System Bios Memory Domain Logon Network [01]"
    #Write-Host ""
    #query user /server:$IP
    #Write-Host ""
    sleep 2
    pause
	}

	if ($key.Character -eq '5') {
    Write-Host ""
    $hostname = read-host "Enter IP / Name"
    $msg = read-host "Enter the message"
    runas /savecred /user:$credent "powershell Invoke-WmiMethod -Path Win32_Process -Name Create -ArgumentList 'msg /w * $msg' -ComputerName $hostname"
    }

    if ($key.Character -eq '6') {
    Write-Host ""
    $hostname = read-host "Enter IP / Name"
    $command = read-host "Command"
    cls
    runas /savecred /user:$credent "powershell Invoke-Command -ComputerName $hostname -ScriptBlock {$command}"
	}

    if ($key.Character -eq '7') {
    Write-Host ""
    cls
    wmic diskdrive get model,serialnumber
    pause
    }
    if ($key.Character -eq '8') {
    Write-Host ""
    runas /savecred /user:$credent "powershell"
    }
} until ($input -eq 'x') 