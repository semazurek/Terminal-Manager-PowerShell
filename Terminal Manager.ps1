<#
Script by Rikey 2023.02.03
LAUNCH SCRIPT VIA POWERSHELL
#>

#credent = $env:USERNAME
$credent = $env:USERNAME+'@'+$env:USERDOMAIN

$versionPS="Terminal Manager v2.3.2.3"
$HOST.UI.RAWUI.WINDOWTITLE = $versionPS
$ip_host = ""
$ErrorActionPreference = "SilentlyContinue"

[reflection.assembly]::LoadWithPartialName( 'System.Windows.Forms'); 
[reflection.assembly]::loadwithpartialname('System.Drawing'); 
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$form= New-Object Windows.Forms.Form; 
$form.Size = New-Object System.Drawing.Size(835,380); 
$form.StartPosition = 'CenterScreen'; 
$form.FormBorderStyle = 'FixedDialog'; 
$form.Text = $versionPS; 
$form.AutoSizeMode = 'GrowAndShrink'; 
$form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen; 
$form.MinimizeBox = $false; 
$form.MaximizeBox = $false; 
$Font = New-Object System.Drawing.Font('Consolas',9,[System.Drawing.FontStyle]::Regular); 
$form.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#252525')
$form.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#eeeeee')
$form.Font = $Font;  

$G_Remote = New-Object System.Windows.Forms.GroupBox
$G_Remote.Location = '10,30' 
$G_Remote.size = '570,300'
$G_Remote.text = 'Remote'
$G_Remote.Visible = $true
$G_Remote.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$G_Remote.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#eeeeee')
$form.controls.Add($G_Remote) 
$G_Remote.add_MouseLeave({
	SaveIP;
});

$G_Command = New-Object System.Windows.Forms.GroupBox
$G_Command.Location = '10,60' 
$G_Command.size = '400,115'
$G_Command.text = 'Execute Command'
$G_Command.Visible = $true
$G_Command.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$G_Command.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#eeeeee')
$G_Remote.controls.Add($G_Command) 

$G_Actions = New-Object System.Windows.Forms.GroupBox
$G_Actions.Location = '420,60' 
$G_Actions.size = '140,230'
$G_Actions.text = 'Actions'
$G_Actions.Visible = $true
$G_Actions.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$G_Actions.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#eeeeee')
$G_Remote.controls.Add($G_Actions) 

$G_Message = New-Object System.Windows.Forms.GroupBox
$G_Message.Location = '10,175' 
$G_Message.size = '400,115'
$G_Message.text = 'Send Message'
$G_Message.Visible = $true
$G_Message.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$G_Message.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#eeeeee')
$G_Remote.controls.Add($G_Message) 

$G_Info = New-Object System.Windows.Forms.GroupBox
$G_Info.Location = '590,30' 
$G_Info.size = '220,300'
$G_Info.text = 'Information'
$G_Info.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#323232');
$G_Info.Visible = $true
$G_Info.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$G_Info.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#eeeeee')
$form.controls.Add($G_Info) 


$B_gpupdate = New-Object Windows.Forms.Button; 
$B_gpupdate.text = 'Gpupdate'; 
$B_gpupdate.FlatStyle = 'Flat'
$B_gpupdate.Location = New-Object Drawing.Point 20,30; 
$B_gpupdate.Size = New-Object Drawing.Point 100,40;
$B_gpupdate.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular);
$B_gpupdate.add_click({do_gp;}); 
$G_Actions.controls.add($B_gpupdate);

$B_restart = New-Object Windows.Forms.Button; 
$B_restart.text = 'Restart'; 
$B_restart.FlatStyle = 'Flat'
$B_restart.Location = New-Object Drawing.Point 20,80; 
$B_restart.Size = New-Object Drawing.Point 100,40;
$B_restart.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular);
$B_restart.add_click({do_restart;}); 
$G_Actions.controls.add($B_restart);

$B_shutdown = New-Object Windows.Forms.Button; 
$B_shutdown.text = 'Shutdown'; 
$B_shutdown.FlatStyle = 'Flat'
$B_shutdown.Location = New-Object Drawing.Point 20,130; 
$B_shutdown.Size = New-Object Drawing.Point 100,40;
$B_shutdown.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular);
$B_shutdown.add_click({do_shutdown;}); 
$G_Actions.controls.add($B_shutdown);

$B_logoff = New-Object Windows.Forms.Button; 
$B_logoff.text = 'Logoff'; 
$B_logoff.FlatStyle = 'Flat'
$B_logoff.Location = New-Object Drawing.Point 20,180; 
$B_logoff.Size = New-Object Drawing.Point 100,40;
$B_logoff.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular);
$B_logoff.add_click({do_logoff;}); 
$G_Actions.controls.add($B_logoff);

function SaveIP
{
	$ip_host = $IP_TEXT.Text;
	
	if ($ip_host -like "*.*" -and ![string]::IsNullOrWhitespace($ip_host)) { 
	if ($ip_host.length -gt 6)
	{
	$hostnamer = [system.net.dns]::gethostentry($ip_host) | select -ExpandProperty HostName
	$label5.Text = $ip_host
	$label4.Text = $hostnamer
	$label4.Visible = $true
	$label5.Visible = $true
	$userlogin = query user /server:$ip_host | Select-String '(\w+)' | ForEach-Object { $_.Matches[0].Groups[1].Value }
	$userlogin = $userlogin -replace 'USERNAME', ''
	$label6.Text = $userlogin
	$label6.Visible = $true
	}
	}
	else 
	{
		if (![string]::IsNullOrWhitespace($ip_host) -and $ip_host.length -gt 2)
		{
		$hostnamer = [system.net.dns]::gethostbyname($ip_host)
		$IPlabel_0 = $hostnamer.AddressList[0].IPAddressToString
		$IPlabel_1 = $hostnamer.AddressList[1].IPAddressToString
		$IPlabel_2 = $hostnamer.AddressList[2].IPAddressToString
		$label5.Text = $IPlabel_0
		$label4.Text = $ip_host
		$label4.Visible = $true
		$label5.Visible = $true
		$userlogin = query user /server:$ip_host | Select-String '(\w+)' | ForEach-Object { $_.Matches[0].Groups[1].Value }
		$userlogin = $userlogin -replace 'USERNAME', ''
		$userlogin = $userlogin.Split([System.Environment]::NewLine,[System.StringSplitOptions]::RemoveEmptyEntries) 
		$label6.Text = $userlogin
		$label6.Visible = $true
		}
	}
};

function do_ad {
	runas /savecred /user:$credent "powershell dsa msc"
};

function do_ps {
	runas /savecred /user:$credent "powershell"
};

function do_gp {
	if (![string]::IsNullOrWhitespace($IP_TEXT.Text))
		{
	$hostn = $IP_TEXT.Text;
	runas /savecred /user:$credent "powershell Invoke-Command -ComputerName $hostn -ScriptBlock {gpupdate /force}"
		}
};

function do_restart {
		if (![string]::IsNullOrWhitespace($IP_TEXT.Text))
		{
	$hostn = $IP_TEXT.Text;
    runas /savecred /user:$credent "powershell Invoke-Command -ComputerName $hostn -ScriptBlock {shutdown /r /t 10 /c 'Remote restart by the Administrator'}" 
		}
};

function do_shutdown {
		if (![string]::IsNullOrWhitespace($IP_TEXT.Text))
		{
	$hostn = $IP_TEXT.Text;
	runas /savecred /user:$credent "powershell Invoke-Command -ComputerName $hostn -ScriptBlock {shutdown /s /t 10 /c 'Remote shutdown by the Administrator' }"
		}
};

function do_message {
		if (![string]::IsNullOrWhitespace($IP_TEXT.Text))
		{
	$msg = $Message_TEXT.Text;
	$hostn = $IP_TEXT.Text;
	runas /savecred /user:$credent "powershell Invoke-WmiMethod -Path Win32_Process -Name Create -ArgumentList 'msg /w * $msg' -ComputerName $hostn"
		}
};

function do_command {
		if (![string]::IsNullOrWhitespace($IP_TEXT.Text))
		{
	$command = $COMMAND_TEXT.Text;
	$hostn = $IP_TEXT.Text;
    runas /savecred /user:$credent "powershell Invoke-Command -ComputerName $hostn -ScriptBlock {$command}"
		}
};

function do_logoffID {
	$hostn = $IP_TEXT.Text;
	$IDLogout = $ID_TEXT.Text;
	runas /savecred /user:$credent "powershell Invoke-Command -ComputerName $hostn -ScriptBlock {logoff $IDLogout}"
};

function do_logoff {
	if (![string]::IsNullOrWhitespace($IP_TEXT.Text))
		{
$logoffForm = New-Object System.Windows.Forms.Form;  
$logoffFormB = New-Object System.Windows.Forms.Button; 
$logoffForm.MinimizeBox = $false; 
$logoffForm.MaximizeBox = $false; 
$logoffForm.TopMost = $true; 
$logoffForm.AutoSizeMode = 'GrowAndShrink'; 
$logoffForm.FormBorderStyle = 'FixedDialog'; 

$logoffForm.ClientSize = '620, 225'; 
$logoffForm.ShowInTaskBar = $false; 
$logoffForm.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#252525')
$logoffForm.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#eeeeee')
$logoffForm.StartPosition = 'CenterScreen'; 
$logoffForm.Text = 'Logoff'; 
$logoffForm.Font = $font;

$labeloff = New-Object Windows.Forms.Label; 
$labeloff.Location = New-Object Drawing.Point 196,190; 
$labeloff.Size = New-Object Drawing.Point 75,30; 
$labeloff.text = 'Type ID:'; 
$labeloff.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$logoffForm.controls.add($labeloff); 

$ID_TEXT = New-Object System.Windows.Forms.TextBox
$ID_TEXT.Location = New-Object System.Drawing.Point(271,188)
$ID_TEXT.Size = New-Object System.Drawing.Size(50,20)
$logoffForm.controls.Add($ID_TEXT)

$logoffFormB.Location = '331, 187'; 
$logoffFormB.Size = New-Object Drawing.Point 55,25;
$logoffFormB.Text = 'Logoff'; 
$logoffFormB.FlatStyle = 'Flat'
$logoffFormB.add_click({do_logoffID;});
$logoffForm.Controls.Add($logoffFormB); 

$userlogin = query user /server:$ip_host

$Users_TEXT = New-Object System.Windows.Forms.TextBox
$Users_TEXT.Location = New-Object System.Drawing.Point(20,20)
$Users_TEXT.Size = New-Object System.Drawing.Size(580,150)
$Users_TEXT.Multiline = $true
$Users_TEXT.ReadOnly = $true
$Users_TEXT.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#323232')
$Users_TEXT.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#eeeeee')
$logoffForm.controls.Add($Users_TEXT)

$Users_TEXT.Text= $userlogin

[void]$logoffForm.ShowDialog()
		}
}; 

$label1 = New-Object Windows.Forms.Label; 
$label1.Location = New-Object Drawing.Point 140,28; 
$label1.Size = New-Object Drawing.Point 110,25; 
$label1.text = 'IP/Hostname:'; 
$label1.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$G_Remote.controls.add($label1); 

$IP_TEXT = New-Object System.Windows.Forms.TextBox
$IP_TEXT.Location = New-Object System.Drawing.Point(250,25)
$IP_TEXT.Size = New-Object System.Drawing.Size(150,20)
$G_Remote.controls.Add($IP_TEXT)
$IP_TEXT.add_MouseLeave({
	SaveIP;
});

$label2 = New-Object Windows.Forms.Label; 
$label2.Location = New-Object Drawing.Point 10,51; 
$label2.Size = New-Object Drawing.Point 75,25; 
$label2.text = 'Command:'; 
$label2.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$G_Command.controls.add($label2); 

$COMMAND_TEXT = New-Object System.Windows.Forms.TextBox
$COMMAND_TEXT.Location = New-Object System.Drawing.Point(85,47)
$COMMAND_TEXT.Size = New-Object System.Drawing.Size(180,20)
$G_Command.controls.Add($COMMAND_TEXT)

$B_Command = New-Object Windows.Forms.Button; 
$B_Command.text = 'Execute'; 
$B_Command.FlatStyle = 'Flat'
$B_Command.Location = New-Object Drawing.Point 280,40; 
$B_Command.Size = New-Object Drawing.Point 100,40;
$B_Command.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular);
$B_Command.add_click({do_command;}); 
$G_Command.controls.add($B_Command);

$label3 = New-Object Windows.Forms.Label; 
$label3.Location = New-Object Drawing.Point 10,51; 
$label3.Size = New-Object Drawing.Point 75,25; 
$label3.text = 'Message:'; 
$label3.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$G_Message.controls.add($label3); 

$Message_TEXT = New-Object System.Windows.Forms.TextBox
$Message_TEXT.Location = New-Object System.Drawing.Point(85,47)
$Message_TEXT.Size = New-Object System.Drawing.Size(180,20)
$G_Message.controls.Add($Message_TEXT)

$B_Message = New-Object Windows.Forms.Button; 
$B_Message.text = 'Send'; 
$B_Message.FlatStyle = 'Flat'
$B_Message.Location = New-Object Drawing.Point 280,40; 
$B_Message.Size = New-Object Drawing.Point 100,40;
$B_Message.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular);
$B_Message.add_click({do_message;}); 
$G_Message.controls.add($B_Message);

$label4 = New-Object Windows.Forms.Label; 
$label4.Location = New-Object Drawing.Point 10,30; 
$label4.Size = New-Object Drawing.Point 200,25; 
$label4.text = 'Hostname'; 
$label4.Visible = $false;
$label4.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$G_Info.controls.add($label4); 

$label5 = New-Object Windows.Forms.Label; 
$label5.Location = New-Object Drawing.Point 10,55; 
$label5.Size = New-Object Drawing.Point 200,25; 
$label5.text = '127.0.0.1'; 
$label5.Visible = $false;
$label5.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$G_Info.controls.add($label5); 

$label6 = New-Object Windows.Forms.Label; 
$label6.Location = New-Object Drawing.Point 10,80; 
$label6.Size = New-Object Drawing.Point 200,100; 
$label6.text = 'Username'; 
$label6.Visible = $false;
$label6.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$G_Info.controls.add($label6); 


function Extras {
$extraForm = New-Object System.Windows.Forms.Form;  
$extraFormB3 = New-Object System.Windows.Forms.Button; 
$extraFormB4 = New-Object System.Windows.Forms.Button; 
$extraFormB5 = New-Object System.Windows.Forms.Button; 
$extraFormB6 = New-Object System.Windows.Forms.Button; 
$extraFormB7 = New-Object System.Windows.Forms.Button; 
$extraFormB8 = New-Object System.Windows.Forms.Button; 
$extraFormB10 = New-Object System.Windows.Forms.Button; 
$extraFormB11 = New-Object System.Windows.Forms.Button; 
$extraForm.MinimizeBox = $false; 
$extraForm.MaximizeBox = $false; 
$extraForm.TopMost = $true; 
$extraForm.AutoSizeMode = 'GrowAndShrink'; 
$extraForm.FormBorderStyle = 'FixedDialog'; 
$extraForm.AcceptButton = $extraFormExit; 
$extraForm.CancelButton = $extraFormExit; 
$extraForm.ClientSize = '200, 225'; 
$extraForm.ShowInTaskBar = $false; 
$extraForm.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#252525')
$extraForm.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#eeeeee')
$extraForm.StartPosition = 'CenterScreen'; 
$extraForm.Text = 'Extras'; 
$extraForm.Font = $font;

$extraFormB3.Location = '25, 10'; 
$extraFormB3.Size = New-Object Drawing.Point 150,25;
$extraFormB3.Text = 'Msconfig'; 
$extraFormB3.add_click({msconfig});
$extraFormB3.FlatStyle = 'Flat'
$extraForm.Controls.Add($extraFormB3); 
$extraFormB3.add_MouseHover({
$tooltipEB3 = New-Object System.Windows.Forms.ToolTip
$tooltipEB3.SetToolTip($extraFormB3, 'Utility designed to troubleshoot and configure Windows startup process.')
})
$extraFormB4.Location = '25, 40'; 
$extraFormB4.Size = New-Object Drawing.Point 150,25;
$extraFormB4.Text = 'Control Panel'; 
$extraFormB4.add_click({control.exe});
$extraFormB4.FlatStyle = 'Flat'
$extraForm.Controls.Add($extraFormB4); 
$extraFormB5.Location = '25, 70'; 
$extraFormB5.Size = New-Object Drawing.Point 150,25;
$extraFormB5.Text = 'Device Manager'; 
$extraFormB5.add_click({devmgmt.msc});
$extraFormB5.FlatStyle = 'Flat'
$extraForm.Controls.Add($extraFormB5); 
$extraFormB6.Location = '25, 100'; 
$extraFormB6.Size = New-Object Drawing.Point 150,25;
$extraFormB6.Text = 'UAC Settings'; 
$extraFormB6.add_click({UserAccountControlSettings.exe});
$extraFormB6.FlatStyle = 'Flat'
$extraForm.Controls.Add($extraFormB6); 
$extraFormB7.Location = '25, 130'; 
$extraFormB7.Size = New-Object Drawing.Point 150,25;
$extraFormB7.Text = 'Msinfo32'; 
$extraFormB7.add_click({msinfo32});
$extraFormB7.FlatStyle = 'Flat'
$extraForm.Controls.Add($extraFormB7); 
$extraFormB7.add_MouseHover({
$tooltipEB7 = New-Object System.Windows.Forms.ToolTip
$tooltipEB7.SetToolTip($extraFormB7, 'This tool gathers information about your computer.')
})
$extraFormB8.Location = '25, 160'; 
$extraFormB8.Size = New-Object Drawing.Point 150,25;
$extraFormB8.Text = 'Services'; 
$extraFormB8.add_click({services.msc});
$extraFormB8.FlatStyle = 'Flat'
$extraForm.Controls.Add($extraFormB8); 
$extraForm.Controls.Add($extraFormB9); 
$extraFormB10.Location = '25, 190'; 
$extraFormB10.Size = New-Object Drawing.Point 150,25;
$extraFormB10.Text = 'Event Viewer'; 
$extraFormB10.add_click({eventvwr.msc});
$extraFormB10.FlatStyle = 'Flat'
$extraForm.Controls.Add($extraFormB10); 

[void]$extraForm.ShowDialog()
}; 
function addMenuItem { param([ref]$ParentItem, [string]$ItemName='', [string]$ItemText='', [scriptblock]$ScriptBlock=$null ) [System.Windows.Forms.ToolStripMenuItem]$private:menuItem=` New-Object System.Windows.Forms.ToolStripMenuItem;
$private:menuItem.Name =$ItemName; 
$private:menuItem.Text =$ItemText; 
if ($ScriptBlock -ne $null) { $private:menuItem.add_Click(([System.EventHandler]$handler=` $ScriptBlock));}; 
if (($ParentItem.Value) -is [System.Windows.Forms.MenuStrip]) { ($ParentItem.Value).Items.Add($private:menuItem);} return $private:menuItem; }; 
[System.Windows.Forms.MenuStrip]$mainMenu=New-Object System.Windows.Forms.MenuStrip; $form.Controls.Add($mainMenu); 
$mainMenu.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#323232');
$mainMenu.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#eeeeee');
[scriptblock]$exit= {$form.Close()}; 
[scriptblock]$activedirectory= {do_ad;}; 
[scriptblock]$remotedesktop= {mstsc}; 
[scriptblock]$powershell= {do_ps;}; 
[scriptblock]$extras= {Extras}; 
(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuFile' -ItemText 'Active Directory' -ScriptBlock $activedirectory); 
(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuFile' -ItemText 'Remote Desktop' -ScriptBlock $remotedesktop); 
(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuFile' -ItemText 'PowerShell' -ScriptBlock $powershell); 
(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuFile' -ItemText 'Extras' -ScriptBlock $extras); 
(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuFile' -ItemText 'Exit' -ScriptBlock $exit); 
cls
Write-Host("`n--------------------------------------------------------------------------------------------`n")
Write-Host("If the window is stuck after choosing the option,`r`nenter the password here (invisible) and confirm with ENTER key`n")
Write-Host("Password:")
$form.ShowDialog();
