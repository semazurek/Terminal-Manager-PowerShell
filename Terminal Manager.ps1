<#
Script by Rikey 2023.07.05
LAUNCH SCRIPT VIA POWERSHELL
#>

#credent = $env:USERNAME
$credent = $env:USERNAME+'@'+$env:USERDOMAIN

$PSDefaultParameterValues['*:Encoding'] = 'utf8'

[console]::WindowWidth=65
[console]::WindowHeight=20

$versionPS="Terminal Manager"
$HOST.UI.RAWUI.WINDOWTITLE = $versionPS
$ErrorActionPreference = "SilentlyContinue"

[reflection.assembly]::LoadWithPartialName( 'System.Windows.Forms'); 
[reflection.assembly]::loadwithpartialname('System.Drawing'); 
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$form= New-Object Windows.Forms.Form; 
$form.Size = New-Object System.Drawing.Size(715,380); 
$form.StartPosition = 'CenterScreen'; 
$form.FormBorderStyle = 'FixedDialog'; 
$form.Text = $versionPS; 
$form.AutoSizeMode = 'GrowAndShrink'; 
$form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen; 
$form.MinimizeBox = $false; 
$form.MaximizeBox = $false; 
$Font = New-Object System.Drawing.Font('Consolas',9,[System.Drawing.FontStyle]::Regular); 
$Color = '#eeeeee'
$form.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#252525')
$form.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($Color)
$form.Font = $Font; 

$StatusStrip = New-Object System.Windows.Forms.StatusStrip
$Status = New-Object System.Windows.Forms.ToolStripStatusLabel
$form.Controls.Ass($StatusStrip)
$StatusStrip.Items.Add($Status)
$Status.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#eeeeee')
$Status.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#252525')
$Status.Text = "Zalogowano jako: "+$credent

#Ikonka forms
$base64IconString = "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"
$iconimageBytes = [Convert]::FromBase64String($base64IconString)
$ims = New-Object IO.MemoryStream($iconimageBytes, 0, $iconimageBytes.Length)
$ims.Write($iconimageBytes, 0, $iconimageBytes.Length); 
$Icon = [System.Drawing.Image]::FromStream($ims, $true)
$form.Icon = [System.Drawing.Icon]::FromHandle((new-object System.Drawing.Bitmap -argument $ims).GetHIcon())

$G_Remote = New-Object System.Windows.Forms.GroupBox
$G_Remote.Location = '10,30' 
$G_Remote.size = '680,300'
$G_Remote.text = 'Remote'
$G_Remote.Visible = $true
$G_Remote.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$G_Remote.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($Color)
$form.controls.Add($G_Remote) 

$IP_TEXT = New-Object System.Windows.Forms.TextBox
$IP_TEXT.Location = New-Object System.Drawing.Point(130,25)
$IP_TEXT.Size = New-Object System.Drawing.Size(150,20)
$IP_TEXT.TabIndex = 0
$IP_TEXT.Add_KeyDown({
    if ($_.KeyCode -eq "Enter") { do_ping }
    })
$G_Remote.controls.Add($IP_TEXT) 


$G_Actions = New-Object System.Windows.Forms.GroupBox
$G_Actions.Location = '420,10' 
$G_Actions.size = '250,280'
$G_Actions.text = 'Actions'
$G_Actions.Visible = $true
$G_Actions.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$G_Actions.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($Color)
$G_Remote.controls.Add($G_Actions)

$G_Command = New-Object System.Windows.Forms.GroupBox
$G_Command.Location = '10,60' 
$G_Command.size = '400,115'
$G_Command.text = 'Execute Command'
$G_Command.Visible = $true
$G_Command.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$G_Command.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($Color)
$G_Remote.controls.Add($G_Command)
$G_Command.add_MouseHover({
$tooltip9 = New-Object System.Windows.Forms.ToolTip
$tooltip9.SetToolTip($G_Command, "Execute commands on the station remotely.")
}) 

$G_Message = New-Object System.Windows.Forms.GroupBox
$G_Message.Location = '10,175' 
$G_Message.size = '400,115'
$G_Message.text = 'Send Message'
$G_Message.Visible = $true
$G_Message.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$G_Message.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($Color)
$G_Remote.controls.Add($G_Message) 
$G_Message.add_MouseHover({
$tooltip8 = New-Object System.Windows.Forms.ToolTip
$tooltip8.SetToolTip($G_Message, "Send a message to the station.")
})

$B_gpupdate = New-Object Windows.Forms.Button; 
$B_gpupdate.text = 'GpUpdate + WinUpdate'; 
$B_gpupdate.FlatStyle = 'Flat'
$B_gpupdate.Location = New-Object Drawing.Point 20,30; 
$B_gpupdate.Size = New-Object Drawing.Point 100,40;
$B_gpupdate.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular);
$B_gpupdate.add_click({do_gp;}); 
$G_Actions.controls.add($B_gpupdate);
$B_gpupdate.add_MouseHover({
$tooltip1 = New-Object System.Windows.Forms.ToolTip
$tooltip1.SetToolTip($B_gpupdate, "gpupdate /force and windows update.")
})

$B_restart = New-Object Windows.Forms.Button; 
$B_restart.text = 'Restart'; 
$B_restart.FlatStyle = 'Flat'
$B_restart.Location = New-Object Drawing.Point 20,80; 
$B_restart.Size = New-Object Drawing.Point 100,40;
$B_restart.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular);
$B_restart.add_click({do_restart;}); 
$G_Actions.controls.add($B_restart);
$B_restart.add_MouseHover({
$tooltip2 = New-Object System.Windows.Forms.ToolTip
$tooltip2.SetToolTip($B_restart, "Restarts stations after 10 seconds.")
})

$B_shutdown = New-Object Windows.Forms.Button; 
$B_shutdown.text = 'Shutdown'; 
$B_shutdown.FlatStyle = 'Flat'
$B_shutdown.Location = New-Object Drawing.Point 20,130; 
$B_shutdown.Size = New-Object Drawing.Point 100,40;
$B_shutdown.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular);
$B_shutdown.add_click({do_shutdown;}); 
$G_Actions.controls.add($B_shutdown);
$B_shutdown.add_MouseHover({
$tooltip3 = New-Object System.Windows.Forms.ToolTip
$tooltip3.SetToolTip($B_shutdown, "Turns stations off after 10 seconds.")
})

$B_logoff = New-Object Windows.Forms.Button; 
$B_logoff.text = 'Logoff'; 
$B_logoff.FlatStyle = 'Flat'
$B_logoff.Location = New-Object Drawing.Point 20,180; 
$B_logoff.Size = New-Object Drawing.Point 100,40;
$B_logoff.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular);
$B_logoff.add_click({do_logoff;}); 
$G_Actions.controls.add($B_logoff);
$B_logoff.add_MouseHover({
$tooltip4 = New-Object System.Windows.Forms.ToolTip
$tooltip4.SetToolTip($B_logoff, "Log out selected user.")
})

$B_address = New-Object Windows.Forms.Button; 
$B_address.text = 'Change Addresses'; 
$B_address.FlatStyle = 'Flat'
$B_address.Location = New-Object Drawing.Point 20,230; 
$B_address.Size = New-Object Drawing.Point 100,40;
$B_address.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular);
$B_address.add_click({ChangeIP;}); 
$G_Actions.controls.add($B_address);
$B_address.add_MouseHover({
$tooltip12 = New-Object System.Windows.Forms.ToolTip
$tooltip12.SetToolTip($B_address, "Change station addresses.")
})

$B_soft = New-Object Windows.Forms.Button; 
$B_soft.text = 'Show Software'; 
$B_soft.FlatStyle = 'Flat'
$B_soft.Location = New-Object Drawing.Point 130,180;
$B_soft.Size = New-Object Drawing.Point 100,40;
$B_soft.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular);
$B_soft.add_click({do_soft;}); 
$G_Actions.controls.add($B_soft);
$B_soft.add_MouseHover({
$tooltip11 = New-Object System.Windows.Forms.ToolTip
$tooltip11.SetToolTip($B_soft, "Shows the software installed on the station.")
})

$B_printer = New-Object Windows.Forms.Button; 
$B_printer.text = 'Show Printers'; 
$B_printer.FlatStyle = 'Flat'
$B_printer.Location = New-Object Drawing.Point 130,30; 
$B_printer.Size = New-Object Drawing.Point 100,40;
$B_printer.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular);
$B_printer.add_click({do_print;}); 
$G_Actions.controls.add($B_printer);
$B_printer.add_MouseHover({
$tooltip5 = New-Object System.Windows.Forms.ToolTip
$tooltip5.SetToolTip($B_printer, "View printers connected to the station.")
})

$B_information = New-Object Windows.Forms.Button; 
$B_information.text = 'Show Info'; 
$B_information.FlatStyle = 'Flat'
$B_information.Location = New-Object Drawing.Point 130,80; 
$B_information.Size = New-Object Drawing.Point 100,40;
$B_information.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular);
$B_information.add_click({do_information;}); 
$G_Actions.controls.add($B_information);
$B_information.add_MouseHover({
$tooltip6 = New-Object System.Windows.Forms.ToolTip
$tooltip6.SetToolTip($B_information, "Display station information.")
})

$B_printer2 = New-Object Windows.Forms.Button; 
$B_printer2.text = 'Reload Printers'; 
$B_printer2.FlatStyle = 'Flat'
$B_printer2.Location = New-Object Drawing.Point 130,130; 
$B_printer2.Size = New-Object Drawing.Point 100,40;
$B_printer2.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular);
$B_printer2.add_click({do_res_printers;}); 
$G_Actions.controls.add($B_printer2);
$B_printer2.add_MouseHover({
$tooltip7 = New-Object System.Windows.Forms.ToolTip
$tooltip7.SetToolTip($B_printer2, "Restart of the Spooler Printout service")
})

function init_menu {
$mainMenu.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#0f4c91')

$form.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#0d4482')
$extraForm.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#0d4482')
$logoffForm.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#0d4482')
$aboutForm.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#0d4482')
$ChangeIPForm.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#0d4482')

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
    runas /savecred /user:$credent "powershell Invoke-Command -ComputerName $hostn -ScriptBlock {wuauclt.exe /updatenow}"
    sleep 1
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
$hostn = $IP_TEXT.Text;
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
$logoffForm.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($Color)
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

init_menu;

$userlogin = query user /server:$hostn

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

function do_print {
		if (![string]::IsNullOrWhitespace($IP_TEXT.Text))
		{
	$hostn = $IP_TEXT.Text;
	runas /savecred /user:$credent "powershell Get-Printer -ComputerName $hostn; pause"
		}
};

function do_information {
		if (![string]::IsNullOrWhitespace($IP_TEXT.Text))
		{
	$hostn = $IP_TEXT.Text;
    runas /savecred /user:$credent "powershell Invoke-Command -ComputerName $hostn -ScriptBlock {systeminfo > c:\log-stacji.txt}; Invoke-Command -ComputerName $hostn -ScriptBlock {Get-PhysicalDisk >> c:\log-stacji.txt}; Invoke-Command -ComputerName $hostn -ScriptBlock {Get-Volume >> c:\log-stacji.txt}; start \\$hostn\c$\log-stacji.txt"
		}
};

function do_res_printers {
		if (![string]::IsNullOrWhitespace($IP_TEXT.Text))
		{
	$hostn = $IP_TEXT.Text;
    runas /savecred /user:$credent "powershell Invoke-Command -ComputerName $hostn -ScriptBlock {net stop spooler}"
    Sleep 5
    runas /savecred /user:$credent "powershell Invoke-Command -ComputerName $hostn -ScriptBlock {net start spooler}"
		}
};

function do_soft {
		if (![string]::IsNullOrWhitespace($IP_TEXT.Text))
		{
        $hostn = $IP_TEXT.Text;
        runas /savecred /user:$credent "powershell Invoke-Command -ComputerName $hostn -ScriptBlock {wmic product get name,version > c:\log-oprog.txt}; start \\$hostn\c$\log-oprog.txt"
        }
};

init_menu;

function do_ping {
if (![string]::IsNullorWhitespace($IP_TEXT.Text))
{
$hostn = $IP_TEXT.Text;
	if(Test-Connection -ComputerName $hostn -Count 1 -Quiet)
 	{
  	(New-Object -ComObject Wscript.Shell).Popup("Address: $hostn is connected.",0,"Terminal Manager",0x40 + 4096)
  	}
   	else {
    	(New-Object -ComObject Wscript.Shell).Popup("Address: $hostn not responding",0,"Terminal Manager",0x40 + 4096)
     	}
}

}

$label1 = New-Object Windows.Forms.Label; 
$label1.Location = New-Object Drawing.Point 20,28; 
$label1.Size = New-Object Drawing.Point 110,25; 
$label1.text = 'IP/Hostname:'; 
$label1.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$G_Remote.controls.add($label1); 

$B_Ping = New-Object Windows.Forms.Button; 
$B_Ping.text = 'Ping'; 
$B_Ping.FlatStyle = 'Flat'
$B_Ping.Location = New-Object Drawing.Point 295,25; 
$B_Ping.Size = New-Object Drawing.Point 100,25;
$B_Ping.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular);
$B_Ping.TabIndex = 1
$B_Ping.add_click({do_ping;}); 
$G_Remote.controls.add($B_Ping);

$label2 = New-Object Windows.Forms.Label; 
$label2.Location = New-Object Drawing.Point 10,51; 
$label2.Size = New-Object Drawing.Point 75,25; 
$label2.text = 'Command:'; 
$label2.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$G_Command.controls.add($label2); 

$COMMAND_TEXT = New-Object System.Windows.Forms.TextBox
$COMMAND_TEXT.Location = New-Object System.Drawing.Point(85,47)
$COMMAND_TEXT.Size = New-Object System.Drawing.Size(180,20)
$COMMAND_TEXT.TabIndex = 2
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

init_menu;

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
$extraForm.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($Color)
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

init_menu; 

[void]$extraForm.ShowDialog()
}; 


function ChangeIP {
if (![string]::IsNullOrWhitespace($IP_TEXT.Text))
{
$hostn = $IP_TEXT.Text;
init_menu; 
$ChangeIPForm = New-Object System.Windows.Forms.Form;  
$ChangeIPFormB1 = New-Object System.Windows.Forms.Button; 
$ChangeIPForm.MinimizeBox = $false; 
$ChangeIPForm.MaximizeBox = $false; 
$ChangeIPForm.TopMost = $true; 
$ChangeIPForm.AutoSizeMode = 'GrowAndShrink'; 
$ChangeIPForm.FormBorderStyle = 'FixedDialog'; 
$ChangeIPForm.AcceptButton = $extraFormExit; 
$ChangeIPForm.CancelButton = $extraFormExit; 
$ChangeIPForm.ClientSize = '300, 220'; 
$ChangeIPForm.ShowInTaskBar = $false; 
$ChangeIPForm.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#252525')
$ChangeIPForm.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($Color)
$ChangeIPForm.StartPosition = 'CenterScreen'; 
$ChangeIPForm.Text = 'Change Addresses of '+$hostn; 
$ChangeIPForm.Font = $font;

$labelIP1 = New-Object Windows.Forms.Label; 
$labelIP1.Location = New-Object Drawing.Point 20,25; 
$labelIP1.Size = New-Object Drawing.Point 90,25; 
$labelIP1.text = 'Interface:'; 
$labelIP1.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$ChangeIPForm.controls.add($labelIP1); 

$textIP1 = New-Object System.Windows.Forms.TextBox
$textIP1.Location = New-Object System.Drawing.Point(120,25)
$textIP1.Size = New-Object System.Drawing.Size(150,20)
$textIP1.Text ='Ethernet'
$ChangeIPForm.controls.Add($textIP1) 

$labelIP2 = New-Object Windows.Forms.Label; 
$labelIP2.Location = New-Object Drawing.Point 20,60; 
$labelIP2.Size = New-Object Drawing.Point 90,25; 
$labelIP2.text = 'IP:'; 
$labelIP2.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$ChangeIPForm.controls.add($labelIP2); 

$textIP2 = New-Object System.Windows.Forms.TextBox
$textIP2.Location = New-Object System.Drawing.Point(120,60)
$textIP2.Size = New-Object System.Drawing.Size(150,20)
$ChangeIPForm.controls.Add($textIP2) 

$labelIP3 = New-Object Windows.Forms.Label; 
$labelIP3.Location = New-Object Drawing.Point 20,95; 
$labelIP3.Size = New-Object Drawing.Point 90,25; 
$labelIP3.text = 'Mask:'; 
$labelIP3.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$ChangeIPForm.controls.add($labelIP3); 

$textIP3 = New-Object System.Windows.Forms.TextBox
$textIP3.Location = New-Object System.Drawing.Point(120,95)
$textIP3.Size = New-Object System.Drawing.Size(150,20)
$ChangeIPForm.controls.Add($textIP3)

$labelIP4 = New-Object Windows.Forms.Label; 
$labelIP4.Location = New-Object Drawing.Point 20,130; 
$labelIP4.Size = New-Object Drawing.Point 90,25; 
$labelIP4.text = 'Gateway:'; 
$labelIP4.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$ChangeIPForm.controls.add($labelIP4); 

$textIP4 = New-Object System.Windows.Forms.TextBox
$textIP4.Location = New-Object System.Drawing.Point(120,130)
$textIP4.Size = New-Object System.Drawing.Size(150,20)
$ChangeIPForm.controls.Add($textIP4)

$ChangeIPFormB1.Location = '110, 165'; 
$ChangeIPFormB1.Size = New-Object Drawing.Point 75,35;
$ChangeIPFormB1.Text = 'Confirm'; 
$ChangeIPFormB1.add_click({do_change_ip});
$ChangeIPFormB1.FlatStyle = 'Flat'
$ChangeIPForm.Controls.Add($ChangeIPFormB1); 

init_menu; 

function do_change_ip {
if (![string]::IsNullOrWhitespace($textIP1.Text))
{
    if (![string]::IsNullOrWhitespace($textIP2.Text))
    {
       if (![string]::IsNullOrWhitespace($textIP3.Text))
       {
        if (![string]::IsNullOrWhitespace($textIP4.Text))
            {
            $hint = $textIP1.Text;
            $haddr = $textIP2.Text;
            $hmask = $textIP3.Text;
            $hgat = $textIP4.Text;
                runas /savecred /user:$credent "powershell Invoke-Command -ComputerName $hostn -ScriptBlock {netsh interface ipv4 set address name='$hint' static $haddr $hmask $hgat}"
                $ChangeIPForm.Close()
            }
       }
    }
}
};

[void]$ChangeIPForm.ShowDialog()
}
}; 

function AboutF {
init_menu; 
$aboutForm = New-Object System.Windows.Forms.Form; 
$aboutFormExit = New-Object System.Windows.Forms.Button; 
$aboutFormNameLabel = New-Object System.Windows.Forms.Label; 
$aboutFormText = New-Object System.Windows.Forms.Label; 
$aboutForm.MinimizeBox = $false; 
$aboutForm.MaximizeBox = $false; 
$aboutForm.TopMost = $true; 
$aboutForm.FlatStyle = 'Flat'
$aboutForm.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#252525')
$aboutForm.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($Color)
$aboutForm.AutoSizeMode = 'GrowAndShrink'; 
$aboutForm.FormBorderStyle = 'FixedDialog'; 
$aboutForm.AcceptButton = $aboutFormExit; 
$aboutForm.CancelButton = $aboutFormExit; 
$aboutForm.ClientSize = '350, 110'; 
$aboutForm.ControlBox = $false; 
$aboutForm.ShowInTaskBar = $false; 
$aboutForm.StartPosition = 'CenterParent'; 
$aboutForm.Text = 'About'; 
$aboutForm.Add_Load($aboutForm_Load); 
$aboutFormNameLabel.Font = New-Object Drawing.Font('Consolas', 9, [System.Drawing.FontStyle]::Bold); 
$aboutFormNameLabel.Location = '110, 10'; 
$aboutFormNameLabel.Size = '200, 18'; 
$aboutFormNameLabel.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($Color)
$aboutFormNameLabel.Text = ' Terminal Manager'; 
$aboutForm.Controls.Add($aboutFormNameLabel); 
$aboutFormText.Location = '100, 30'; 
$aboutFormText.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($Color)
$aboutFormText.Size = '300, 20'; $aboutFormText.Text = '         Sebastian Mazurek'; 
$aboutForm.Controls.Add($aboutFormText);  
$aboutFormExit.Location = '138, 75'; 
$aboutFormExit.Text = 'OK'; 
$aboutFormExit.FlatStyle = 'Flat'
$aboutForm.Controls.Add($aboutFormExit);  

init_menu;

[void]$aboutForm.ShowDialog()
};

function addMenuItem { param([ref]$ParentItem, [string]$ItemName='', [string]$ItemText='', [scriptblock]$ScriptBlock=$null ) [System.Windows.Forms.ToolStripMenuItem]$private:menuItem=` New-Object System.Windows.Forms.ToolStripMenuItem;
$private:menuItem.Name =$ItemName; 
$private:menuItem.Text =$ItemText; 
if ($ScriptBlock -ne $null) { $private:menuItem.add_Click(([System.EventHandler]$handler=` $ScriptBlock));}; 
if (($ParentItem.Value) -is [System.Windows.Forms.MenuStrip]) { ($ParentItem.Value).Items.Add($private:menuItem);} return $private:menuItem; }; 
[System.Windows.Forms.MenuStrip]$mainMenu=New-Object System.Windows.Forms.MenuStrip; $form.Controls.Add($mainMenu); 
$mainMenu.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#323232');
$mainMenu.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($Color);
[scriptblock]$exit= {$form.Close()}; 
[scriptblock]$activedirectory= {do_ad;}; 
[scriptblock]$remotedesktop= {mstsc}; 
[scriptblock]$powershell= {do_ps;}; 
[scriptblock]$extras= {Extras}; 
[scriptblock]$about= {AboutF}; 
(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuFile' -ItemText 'Active Directory' -ScriptBlock $activedirectory); 
(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuFile' -ItemText 'Remote Desktop' -ScriptBlock $remotedesktop);  
(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuFile' -ItemText 'PowerShell' -ScriptBlock $powershell); 
(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuFile' -ItemText 'Extras' -ScriptBlock $extras); 
(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuFile' -ItemText 'About' -ScriptBlock $about); 
(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuFile' -ItemText 'Exit' -ScriptBlock $exit); 

init_menu;

cls
Write-Host("`n----------------------------------------------------------------`n")
Write-Host("If the window is stuck after choosing the option,`r`nenter the password here (invisible) and confirm with ENTER key.")
Write-Host("`n----------------------------------------------------------------`n")
Write-Host("Password:")
$form.ShowDialog();
