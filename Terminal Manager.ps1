<#
Script by Rikey 2024.11.05

LAUNCH SCRIPT VIA POWERSHELL
#>

if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
	$PSskrypt=$PSCommandPath
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSskrypt`"" -Verb RunAs

	exit
}

$Debug= $false

$global:hostn = "" 

$global:sh_window_state = 2

add-type -name user32 -namespace win32 -memberDefinition '[DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);'
$consoleHandle = (Get-Process -id $pid).mainWindowHandle;

if ($Debug -eq $false) {[win32.user32]::showWindow($consoleHandle, 0)}
if ($Debug -eq $true) {$global:sh_window_state = 3}

function change_view 
{
	if ($sh_window_state%2 -eq 0) {
		[win32.user32]::showWindow($consoleHandle, 5);
	}
	else {
		[win32.user32]::showWindow($consoleHandle, 0);
	} 
	$global:sh_window_state++
};

[console]::WindowWidth=65
[console]::WindowHeight=20

$Host.UI.RawUI.BackgroundColor = ($bckgrnd = 'Black')

$versionPS="Terminal Manager"
$HOST.UI.RAWUI.WINDOWTITLE = $versionPS
$ErrorActionPreference = "SilentlyContinue"

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

function init_menu {

		$versionPS="Terminal Manager"
		$mainMenu.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#0f4c91')
		
		$form.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#0d4482')
		$choose_form.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#0d4482')
		$extraForm.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#0d4482')
		$logoffForm.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#0d4482')
		$aboutForm.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#0d4482')
		$ChangeIPForm.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#0d4482')
		$form.Text = $versionPS;
		$choose_form.Text = $versionPS;
		$B_firstrun.Visible = $true
		#Button Colors 
		$global:changed_color = "#0a3565"
		Foreach ($control in $G_Actions.Controls+$G_Command.Controls+$G_Message.Controls+$G_Process.Controls+$G_Remote.Controls+$G_UpdMny.Controls)
		{
			$objectType = $control.GetType().Name
			if($objectType -like "Button")
			{
				$control.BackColor=[System.Drawing.ColorTranslator]::FromHTML($changed_color)
				$control.FlatStyle = 'Flat'
				$control.FlatAppearance.BorderSize = 0
			}
		}
		$B_choose.BackColor=[System.Drawing.ColorTranslator]::FromHTML($changed_color)
		$B_choose.FlatStyle = 'Flat'
		$B_choose.FlatAppearance.BorderSize = 0
		$logoffFormB.BackColor=[System.Drawing.ColorTranslator]::FromHTML($changed_color)
		$logoffFormB.FlatStyle = 'Flat'
		$logoffFormB.FlatAppearance.BorderSize = 0
		$ChangeIPFormB1.BackColor=[System.Drawing.ColorTranslator]::FromHTML($changed_color)
		$ChangeIPFormB1.FlatStyle = 'Flat'
		$ChangeIPFormB1.FlatAppearance.BorderSize = 0
		$ChangeIPFormB2.BackColor=[System.Drawing.ColorTranslator]::FromHTML($changed_color)
		$ChangeIPFormB2.FlatStyle = 'Flat'
		$ChangeIPFormB2.FlatAppearance.BorderSize = 0
		$aboutFormExit.BackColor=[System.Drawing.ColorTranslator]::FromHTML($changed_color)
		$aboutFormExit.FlatStyle = 'Flat'
		$aboutFormExit.FlatAppearance.BorderSize = 0
	
};

[reflection.assembly]::LoadWithPartialName( 'System.Windows.Forms'); 
[reflection.assembly]::loadwithpartialname('System.Drawing'); 
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()
	
$env:username -match "(\w{2}\.\w{2})(\.)(\w*)"
$global:region=$matches[1]
$onlyuser=$matches[3]
(Get-ADUser -Identity $onlyuser -Properties DistinguishedName).DistinguishedName -match "OU=((\w{3}\d{3})(\d{5}))"
$global:ou=$matches[1]
$global:etat=$matches[2]

init_menu;

$PSDefaultParameterValues['*:Encoding'] = 'utf8'

[win32.user32]::showWindow($consoleHandle, 5)

[console]::WindowWidth=90
[console]::WindowHeight=15

if ($Debug -eq $false) {cls}

if ($Debug -eq $false) { [win32.user32]::showWindow($consoleHandle, 0)}

[console]::WindowWidth=65
[console]::WindowHeight=20

$form = New-Object Windows.Forms.Form; 
$form.Size = New-Object System.Drawing.Size(825,400);
$form.StartPosition = 'CenterScreen'; 
$form.FormBorderStyle = 'FixedDialog'; 
$form.Text = $versionPS; 
$form.AutoSizeMode = 'GrowAndShrink'; 
$form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen; 
$form.MinimizeBox = $true; 
$form.MaximizeBox = $false; 
$Font = New-Object System.Drawing.Font('Consolas',9,[System.Drawing.FontStyle]::Regular); 
$Color = '#eeeeee'
$form.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#252525')
$form.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($Color)
$form.Font = $Font; 
$form.TopMost = $false; 

$StatusStrip = New-Object System.Windows.Forms.StatusStrip
$Status = New-Object System.Windows.Forms.ToolStripStatusLabel
$form.Controls.Add($StatusStrip)
$StatusStrip.Items.Add($Status)
$Status.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#eeeeee')
$Status.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#252525')
$Status.Text = "Logged as: "+$env:username

$base64IconString = "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"
$iconimageBytes = [Convert]::FromBase64String($base64IconString)
$ims = New-Object IO.MemoryStream($iconimageBytes, 0, $iconimageBytes.Length)
$ims.Write($iconimageBytes, 0, $iconimageBytes.Length); 
$Icon = [System.Drawing.Image]::FromStream($ims, $true)
$form.Icon = [System.Drawing.Icon]::FromHandle((new-object System.Drawing.Bitmap -argument $ims).GetHIcon())

$G_Remote = New-Object System.Windows.Forms.GroupBox
$G_Remote.Location = '10,30' 
$G_Remote.size = '790,390'
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

$G_Process = New-Object System.Windows.Forms.GroupBox
$G_Process.Location = '10,220' 
$G_Process.size = '400,75'
$G_Process.text = 'End Task'
$G_Process.Visible = $true
$G_Process.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$G_Process.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($Color)
$G_Remote.controls.Add($G_Process) 

$lista_test = ''

$B_pproc = New-Object Windows.Forms.Button; 
$B_pproc.Location = New-Object Drawing.Point 240,25; 
$B_pproc.Size = New-Object Drawing.Point 60,40; 
$B_pproc.text = '▼'; 
$B_pproc.text = '↓'; 
$B_pproc.FlatStyle = 'Flat'
$B_pproc.Font = New-Object System.Drawing.Font('Consolas',25,[System.Drawing.FontStyle]::Bold); 
$B_pproc.add_click({
	
	if (![string]::IsNullOrWhitespace($IP_TEXT.Text))
	{
		$hostn = $IP_TEXT.Text;
		if ($hostn -ne $env:COMPUTERNAME)
		{
			$lista_test = ''
			Invoke-Command -ComputerName $hostn -ScriptBlock {Get-Process | Select ProcessName -ExpandProperty ProcessName | get-unique > C:\log-procesy.txt}; Copy-Item -Path "\\$hostn\c$\log-procesy.txt" -Destination "C:\ProgramData\log-procesy.txt"; Sleep 1; Remove-Item \\$hostn\c$\log-procesy.txt;
			Sleep 2
			$lista_test = Get-Content -Path C:\ProgramData\log-procesy.txt
			$process_TEXT.DataSource = $lista_test	
			rm log-procesy.txt
			Remove-Item C:\ProgramData\log-procesy.txt
		}
		else
		{
			$lista_test = ''
			Get-Process | Select ProcessName -ExpandProperty ProcessName | get-unique > log-procesy.txt; 
			$lista_test = Get-Content -Path log-procesy.txt
			$process_TEXT.DataSource = $lista_test	
			rm log-procesy.txt
		}
	}
	
});
$G_Process.controls.add($B_pproc); 

$process_TEXT = New-Object System.Windows.Forms.ComboBox
$process_TEXT.Location = New-Object System.Drawing.Point(10,32)
$process_TEXT.Size = New-Object System.Drawing.Size(220,20)
$process_TEXT.DataSource = $lista_test
$G_process.controls.Add($process_TEXT)

$B_process = New-Object Windows.Forms.Button; 
$B_process.text = 'Kill'; 
$B_process.FlatStyle = 'Flat'
$B_process.Location = New-Object Drawing.Point 310,25; 
$B_process.Size = New-Object Drawing.Point 75,40;
$B_process.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular);
$B_process.add_click({do_kill;}); 
$G_process.controls.add($B_process);

$G_Actions = New-Object System.Windows.Forms.GroupBox
$G_Actions.Location = '420,10' 
$G_Actions.size = '360,285'
$G_Actions.text = 'Actions'
$G_Actions.Visible = $true
$G_Actions.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$G_Actions.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($Color)
$G_Remote.controls.Add($G_Actions)

$G_Command = New-Object System.Windows.Forms.GroupBox
$G_Command.Location = '10,60' 
$G_Command.size = '400,75'
$G_Command.text = 'Execute Command'
$G_Command.Visible = $true
$G_Command.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$G_Command.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($Color)
$G_Remote.controls.Add($G_Command)

$G_Message = New-Object System.Windows.Forms.GroupBox
$G_Message.Location = '10,140' 
$G_Message.size = '400,75'
$G_Message.text = 'Send Message'
$G_Message.Visible = $true
$G_Message.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$G_Message.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($Color)
$G_Remote.controls.Add($G_Message) 

$B_gpupdate = New-Object Windows.Forms.Button; 
$B_gpupdate.text = 'GpUpdate + WinUpdate'; 
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

$B_address = New-Object Windows.Forms.Button; 
$B_address.text = 'Change Addresses'; 
$B_address.FlatStyle = 'Flat'
$B_address.Location = New-Object Drawing.Point 20,230; 
$B_address.Size = New-Object Drawing.Point 100,40;
$B_address.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular);
$B_address.add_click({ChangeIP;}); 
$G_Actions.controls.add($B_address);

$B_soft = New-Object Windows.Forms.Button; 
$B_soft.text = 'Show Software'; 
$B_soft.FlatStyle = 'Flat'
$B_soft.Location = New-Object Drawing.Point 130,180;
$B_soft.Size = New-Object Drawing.Point 100,40;
$B_soft.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular);
$B_soft.add_click({do_soft;}); 
$G_Actions.controls.add($B_soft);

$B_printer = New-Object Windows.Forms.Button; 
$B_printer.text = 'Manage Printers'; 
$B_printer.FlatStyle = 'Flat'
$B_printer.Location = New-Object Drawing.Point 130,30; 
$B_printer.Size = New-Object Drawing.Point 100,40;
$B_printer.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular); 
$B_printer.add_click({do_printm;}); 
$G_Actions.controls.add($B_printer);

$B_information = New-Object Windows.Forms.Button; 
$B_information.text = 'Show Info'; 
$B_information.FlatStyle = 'Flat'
$B_information.Location = New-Object Drawing.Point 130,80; 
$B_information.Size = New-Object Drawing.Point 100,40;
$B_information.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular);
$B_information.add_click({do_information;}); 
$G_Actions.controls.add($B_information);

$B_devices1 = New-Object Windows.Forms.Button; 
$B_devices1.text = 'Show Devices'; 
$B_devices1.FlatStyle = 'Flat'
$B_devices1.Location = New-Object Drawing.Point 130,130; 
$B_devices1.Size = New-Object Drawing.Point 100,40;
$B_devices1.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular);
$B_devices1.add_click({do_get_devices}); 
$G_Actions.controls.add($B_devices1);

$B_showprint = New-Object Windows.Forms.Button; 
$B_showprint.text = 'Show Printers'; 
$B_showprint.FlatStyle = 'Flat'
$B_showprint.Location = New-Object Drawing.Point 240,30;  
$B_showprint.Size = New-Object Drawing.Point 100,40;
$B_showprint.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular);
$B_showprint.add_click({do_print;}); 
$G_Actions.controls.add($B_showprint);

$B_RESprint = New-Object Windows.Forms.Button; 
$B_RESprint.text = 'Reload Printers'; 
$B_RESprint.FlatStyle = 'Flat'
$B_RESprint.Location = New-Object Drawing.Point 240,80;  
$B_RESprint.Size = New-Object Drawing.Point 100,40;
$B_RESprint.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular);
$B_RESprint.add_click({do_res_printers;}); 
$G_Actions.controls.add($B_RESprint);

$B_taskopen = New-Object Windows.Forms.Button; 
$B_taskopen.text = 'Show Services'; 
$B_taskopen.FlatStyle = 'Flat'
$B_taskopen.Location = New-Object Drawing.Point 240,130;  
$B_taskopen.Size = New-Object Drawing.Point 100,40;
$B_taskopen.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular);
$B_taskopen.add_click({do_show_serv;}); 
$G_Actions.controls.add($B_taskopen);

$B_hotfi = New-Object Windows.Forms.Button; 
$B_hotfi.text = "Show HotFix'es"; 
$B_hotfi.FlatStyle = 'Flat'
$B_hotfi.Location = New-Object Drawing.Point 240,180;  
$B_hotfi.Size = New-Object Drawing.Point 100,40;
$B_hotfi.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular);
$B_hotfi.add_click({do_show_hotfix;}); 
$G_Actions.controls.add($B_hotfi);

$B_optimiz = New-Object Windows.Forms.Button; 
$B_optimiz.text = "CleanMgr"; 
$B_optimiz.FlatStyle = 'Flat'
$B_optimiz.Location = New-Object Drawing.Point 130,230;  
$B_optimiz.Size = New-Object Drawing.Point 100,40;
$B_optimiz.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular);
$B_optimiz.add_click({do_rem_optimize;}); 
$G_Actions.controls.add($B_optimiz);

function check_pre {
	$IP_TEXT.Text = $env:COMPUTERNAME
	$hostn=[string]$IP_TEXT.Text
	$ILJ_TEXT.Text = $IP_TEXT.Text.Substring(0,12)
};

function do_ad {
	& "dsac.exe"
};
function do_ad2 {
	& "dsa.msc"
};

function do_ps {
	#& "powershell"
	Start-Process "powershell_ISE.exe" -Verb Runas
};

function do_gp {
	if (![string]::IsNullOrWhitespace($IP_TEXT.Text))
	{
		$hostn = $IP_TEXT.Text;
		$pathtodefend = $env:programfiles+"\Windows Defender\"
		if ($hostn -ne $env:COMPUTERNAME)
		{
			Invoke-Command -ComputerName $hostn -ScriptBlock {wuauclt.exe /detectnow; wuauclt.exe /updatenow} -AsJob
			
			Invoke-Command -ComputerName $hostn -ScriptBlock {cd "$pathtodefend"; start MpCmdRun.exe /SignatureUpdate} -AsJob
			
			Invoke-Command -ComputerName $hostn -ScriptBlock {gpupdate /force} -AsJob
		}
		else
		{
			& "wuauclt.exe /detectnow; wuauclt.exe /updatenow"
			sleep 1
			& "cd '$pathtodefend'; start MpCmdRun.exe /SignatureUpdate;pause"
			sleep 1
			& "gpupdate /force"
		}
		
	}
};

function do_bios_res {
	& "shutdown /r /fw /t 1"
};

function do_uslugi {
	$komp=[string]$IP_TEXT.Text
	Start-Process "compmgmt.msc" -argumentlist "-a","/computer=$komp" -Verb Runas;
	#	& "services.msc"
};

function do_urzadzenia {
	& "devmgmt.msc"
};

function do_msconfig {
	& "msconfig"
};

function do_uac_ustaw {
	& "UserAccountControlSettings.exe"
};

function do_rejestr {
	& "regedit"
};

function do_restart {
	if (![string]::IsNullOrWhitespace($IP_TEXT.Text))
	{
		
		$hostn = $IP_TEXT.Text;
		if ($hostn -ne $env:COMPUTERNAME)
		{
			Invoke-Command -ComputerName $hostn -ScriptBlock {shutdown /r /t 10 /c "Remote restart by the Administrator"}
		}
		else
		{
			& "shutdown /r /t 10 /c 'Remote restart by the Administrator'"
		}
	}
};

function do_shutdown {
	if (![string]::IsNullOrWhitespace($IP_TEXT.Text))
	{
		$hostn = $IP_TEXT.Text;
		if ($hostn -ne $env:COMPUTERNAME)
		{
			Invoke-Command -ComputerName $hostn -ScriptBlock {shutdown /s /t 10 /c "Remote shutdown by the Administrator" }
		}
		else
		{
			& "shutdown /s /t 10 /c 'Remote shutdown by the Administrator'"
		}
	}
};

function do_message {
	if (![string]::IsNullOrWhitespace($IP_TEXT.Text))
	{
		$msg = $Message_TEXT.Text;
		$hostn = $IP_TEXT.Text;
		if ($hostn -ne $env:COMPUTERNAME -and $msg -ne "")
		{
			Invoke-WmiMethod -Path Win32_Process -Name Create -ArgumentList "msg /time:0 * $msg" -ComputerName $hostn
			$Message_TEXT.Text =""
		}
		if ($hostn -eq $env:COMPUTERNAME)
		{
			(New-Object -ComObject Wscript.Shell).Popup("Enter the address of the remote station, not the local.",0,"Terminal Manager",0x10 + 4096)
		}
	}
};

function do_command {
	if (![string]::IsNullOrWhitespace($IP_TEXT.Text))
	{
		$command = $COMMAND_TEXT.Text;
		$hostn = $IP_TEXT.Text;
		if ($hostn -ne $env:COMPUTERNAME)
		{
			Invoke-WmiMethod -Path Win32_Process -Name Create -ArgumentList "$command" -ComputerName $hostn
			$COMMAND_TEXT.Text =""
		}
		else 
		{
			& "$command"
			$COMMAND_TEXT.Text =""
		}
	}
};

function do_show_serv {
	if (![string]::IsNullOrWhitespace($IP_TEXT.Text))
	{
		$hostn = $IP_TEXT.Text;
		Invoke-Command -ScriptBlock {Get-Service -ComputerName $hostn | Select Status,Name,DisplayName | Out-GridView -Wait -Title $hostn}
	}
};

function do_show_hotfix {
	if (![string]::IsNullOrWhitespace($IP_TEXT.Text))
	{
		$hostn = $IP_TEXT.Text;
		Invoke-Command -ScriptBlock {Get-HotFix -ComputerName $hostn | Out-GridView -Wait -Title $hostn}
	}
};

function do_rem_optimize {
	if (![string]::IsNullOrWhitespace($IP_TEXT.Text))
	{
		$hostn = $IP_TEXT.Text;
		if ($hostn -ne $env:COMPUTERNAME)
		{
			Invoke-Command -ComputerName $hostn -ScriptBlock {powershell cleanmgr.exe /autoclean; Remove-Item -Force -Recurse $env:windir\Prefetch\*.pf; Remove-Item -Force -Recurse $env:temp\*; Remove-Item -Force -Recurse $env:windir\Temp\*; } -AsJob
		}
		else {
			powershell cleanmgr.exe /autoclean; Remove-Item -Force -Recurse $env:windir\Prefetch\*.pf; Remove-Item -Force -Recurse $env:temp\*; Remove-Item -Force -Recurse $env:windir\Temp\*;
		}
	}
};

function do_kill {
	if (![string]::IsNullOrWhitespace($IP_TEXT.Text))
	{
		$usluga = $process_TEXT.Text;
		$hostn = $IP_TEXT.Text;
		
		if ($usluga -ne "")
		{
			if ($hostn -ne $env:COMPUTERNAME)
			{
				Invoke-WmiMethod -Path Win32_Process -Name Create -ArgumentList "taskkill /f /im $usluga" -ComputerName $hostn
				Invoke-WmiMethod -Path Win32_Process -Name Create -ArgumentList "taskkill /f /im $usluga.exe" -ComputerName $hostn
				$process_TEXT.Text =""
			}
			else
			{
				& "taskkill /f /im $usluga"
				& "taskkill /f /im $usluga.exe"
				$process_TEXT.Text =""
			}
			
		}
	}
};

function do_logoffID {
	$hostn = $IP_TEXT.Text;
	if ($hostn -ne $env:COMPUTERNAME)
	{
		$IDLogout = $ID_TEXT.Text;
		Invoke-WmiMethod -Path Win32_Process -Name Create -ArgumentList "logoff $IDLogout" -ComputerName $hostn
	}
	else
	{
		& "logoff"
	}
};


function do_logoff {
	if (![string]::IsNullOrWhitespace($IP_TEXT.Text))
	{
		if (Test-Connection -ComputerName $IP_TEXT.Text -Count 1 -Quiet)
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
			$logoffForm.Text = 'Logged in users:'; 
			$logoffForm.Font = $font;
			
			$labeloff = New-Object Windows.Forms.Label; 
			$labeloff.Location = New-Object Drawing.Point 186,192; 
			$labeloff.Size = New-Object Drawing.Point 85,30; 
			$labeloff.text = 'Type ID:'; 
			$labeloff.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
			$logoffForm.controls.add($labeloff); 
			
			$ID_TEXT = New-Object System.Windows.Forms.TextBox
			$ID_TEXT.Location = New-Object System.Drawing.Point(271,188)
			$ID_TEXT.Size = New-Object System.Drawing.Size(50,20)
			$ID_TEXT.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold);
			$logoffForm.controls.Add($ID_TEXT)
			
			$logoffFormB.Location = '331, 182'; 
			$logoffFormB.Size = New-Object Drawing.Point 75,35;
			$logoffFormB.Text = 'Logoff'; 
			$logoffFormB.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular); 
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
	}
}; 

$global:var_tmp_log = 'ERROR cannot read the log'
$global:title_tmp_log = $hostn
function do_viewinfo {
	$hostn = $IP_TEXT.Text;
	
	$logoffForm = New-Object System.Windows.Forms.Form;  
	$logoffFormB = New-Object System.Windows.Forms.Button; 
	$logoffForm.MinimizeBox = $false; 
	$logoffForm.MaximizeBox = $false; 
	$logoffForm.TopMost = $true; 
	$logoffForm.AutoSizeMode = 'GrowAndShrink'; 
	$logoffForm.FormBorderStyle = 'FixedDialog'; 
	
	$logoffForm.ClientSize = '970, 425'; 
	$logoffForm.ShowInTaskBar = $false; 
	$logoffForm.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#252525')
	$logoffForm.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($Color)
	$logoffForm.StartPosition = 'CenterScreen'; 
	$logoffForm.Text = $global:title_tmp_log 
	$logoffForm.Font = $font;
	
	init_menu;
	
	$Users_TEXT = New-Object System.Windows.Forms.TextBox
	$Users_TEXT.Location = New-Object System.Drawing.Point(20,20)
	$Users_TEXT.Size = New-Object System.Drawing.Size(930,385)
	$Users_TEXT.Multiline = $true
	$Users_TEXT.ReadOnly = $true
	$Users_TEXT.ScrollBars = "Both";
	$Users_TEXT.Font = New-Object System.Drawing.Font('Consolas',10,[System.Drawing.FontStyle]::Regular); 
	$Users_TEXT.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#323232')
	$Users_TEXT.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#eeeeee')
	$logoffForm.controls.Add($Users_TEXT)
	
	
	ForEach ($Line in $global:var_tmp_log)
	{
		$Users_TEXT.Text += $Line
		$Users_TEXT.Text += '
		'
	}
	
	[void]$logoffForm.ShowDialog()
}; 

function do_printm {
	& printmanagement.msc
};

function do_print {
	if (![string]::IsNullOrWhitespace($IP_TEXT.Text))
	{
		$hostn = $IP_TEXT.Text; 
		Invoke-Command -ScriptBlock {Get-Printer -ComputerName $hostn | Select Name,PrinterStatus,PortName,DriverName,Shared, Published | Out-GridView -Wait -Title $hostn;}
	}
};

function do_information {
	if (![string]::IsNullOrWhitespace($IP_TEXT.Text))
	{
		$hostn = $IP_TEXT.Text;
		if ($hostn -ne $env:COMPUTERNAME)
		{
			Invoke-Command -ComputerName $hostn -ScriptBlock {Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -Name UBR | Select-Object UBR > c:\log-stacji.txt; systeminfo >> c:\log-stacji.txt}; Invoke-Command -ComputerName $hostn -ScriptBlock {Get-PhysicalDisk >> c:\log-stacji.txt}; Invoke-Command -ComputerName $hostn -ScriptBlock {Get-Volume >> c:\log-stacji.txt}; Invoke-Command -ComputerName $hostn -ScriptBlock {wmic diskdrive get model,serialnumber >> c:\log-stacji.txt};  Invoke-Command -ComputerName $hostn -ScriptBlock {ipconfig /all >> c:\log-stacji.txt}; Copy-Item -Path "\\$hostn\c$\log-stacji.txt" -Destination "C:\ProgramData\log-stacji.txt";echo true-done > C:\ProgramData\done-job.txt; Sleep 1; Remove-Item \\$hostn\c$\log-stacji.txt;
			while ($true)
			{
				if (Test-Path -Path "C:\ProgramData\done-job.txt")
				{
					$global:var_tmp_log = Get-Content -Path C:\ProgramData\log-stacji.txt;
					$global:title_tmp_log = 'Informations: '+$hostn
					rm "C:\ProgramData\done-job.txt"
					#Sleep 1;
					do_viewinfo;
					break;
				}
			}
		}
		else
		{
			Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -Name UBR | Select-Object UBR > log-stacji.txt
			systeminfo >> log-stacji.txt
			Get-PhysicalDisk; Get-Volume >> log-stacji.txt
			wmic diskdrive get model,serialnumber >> log-stacji.txt
			ipconfig /all >> log-stacji.txt
			sleep 1
			$global:var_tmp_log = Get-Content -Path log-stacji.txt;
			$global:title_tmp_log = 'Informations: '+$hostn
			do_viewinfo;
			sleep 1
			rm log-stacji.txt
		}
	}
};

function do_res_printers {
	if (![string]::IsNullOrWhitespace($IP_TEXT.Text))
	{
		$hostn = $IP_TEXT.Text;
		if ($hostn -ne $env:COMPUTERNAME)
		{
			Invoke-Command -ComputerName $hostn -ScriptBlock {net stop spooler}
			Sleep 5
			Invoke-Command -ComputerName $hostn -ScriptBlock {net start spooler}
		}
		else
		{
			& "net stop spooler"
			Sleep 5
			& "net start spooler"
		}
	}
};

function do_get_devices {
	if (![string]::IsNullOrWhitespace($IP_TEXT.Text))
	{
		$hostn = $IP_TEXT.Text;
		if ($hostn -ne $env:COMPUTERNAME)
		{
			Invoke-Command -ComputerName $hostn -ScriptBlock {Get-PnpDevice -Status Error > C:\log-pnpdevice.txt; Get-PnpDevice | Select-Object Status, Class, FriendlyName, InstanceId >> C:\log-pnpdevice.txt}; cls; Copy-Item -Path "\\$hostn\c$\log-pnpdevice.txt" -Destination "C:\ProgramData\log-pnpdevice.txt";echo true-done > C:\ProgramData\done-job.txt; Sleep 1; Remove-Item \\$hostn\c$\log-pnpdevice.txt;
			while ($true){
				if (Test-Path -Path "C:\ProgramData\done-job.txt")
				{
					$global:var_tmp_log = Get-Content -Path C:\ProgramData\log-pnpdevice.txt;
					$global:title_tmp_log = 'Devices: '+$hostn
					rm "C:\ProgramData\done-job.txt"
					do_viewinfo;
					break;
					
				}
			}
			
		}
		else
		{
			(New-Object -ComObject Wscript.Shell).Popup("Enter the address of the remote station, not the local.",0,"Terminal Manager",0x10 + 4096)
		}
	}
	
};

function do_soft {
	if (![string]::IsNullOrWhitespace($IP_TEXT.Text))
	{
		$hostn = $IP_TEXT.Text;
		if ($hostn -ne $env:COMPUTERNAME)
		{
			Invoke-Command -ComputerName $hostn -ScriptBlock {wmic product get name,version > c:\log-oprog.txt}; Copy-Item -Path "\\$hostn\c$\log-oprog.txt" -Destination "C:\ProgramData\log-oprog.txt"; echo true-done > C:\ProgramData\done-job.txt; Sleep 1; Remove-Item \\$hostn\c$\log-oprog.txt;
			while ($true){
				if (Test-Path -Path "C:\ProgramData\done-job.txt")
				{
					$global:var_tmp_log = Get-Content -Path C:\ProgramData\log-oprog.txt;
					$global:title_tmp_log = 'Installed Software: '+$hostn
					rm "C:\ProgramData\done-job.txt"
					do_viewinfo;
					break;
				}
			}
			
		}
		else
		{
			(New-Object -ComObject Wscript.Shell).Popup("Enter the address of the remote station, not the local.",0,"Terminal Manager",0x10 + 4096)
			
		}
	}
};

init_menu;

function do_sccm {
	& "${env:ProgramFiles(x86)}\ConfigMgr\bin\Microsoft.ConfigurationManagement.exe"
};

function do_ping {
	if (![string]::IsNullOrWhitespace($IP_TEXT.Text))
	{
		$hostn = $IP_TEXT.Text;
		
	if (Test-Connection -ComputerName $hostn -Count 2 -Quiet)
		{
		(New-Object -ComObject Wscript.Shell).Popup("Address: $hostn is connected.",0,"Terminal Manager",0x40 + 4096)
		}
	else {
		(New-Object -ComObject Wscript.Shell).Popup("Address: $hostn not responding",0,"Terminal Manager",0x10 + 4096)
		}
		
	}
};

$label1 = New-Object Windows.Forms.Label; 
$label1.Location = New-Object Drawing.Point 20,28; 
$label1.Size = New-Object Drawing.Point 110,25; 
$label1.text = 'IP/Hostname:'; 
$label1.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$G_Remote.controls.add($label1); 

$B_Ping = New-Object Windows.Forms.Button; 
$B_Ping.text = 'Ping'; 
$B_Ping.FlatStyle = 'Flat'
$B_Ping.Location = New-Object Drawing.Point 295,23; 
$B_Ping.Size = New-Object Drawing.Point 50,29;
$B_Ping.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular);
$B_Ping.TabIndex = 1
$B_Ping.add_click({do_ping;}); 
$G_Remote.controls.add($B_Ping);

$B_EFile = New-Object Windows.Forms.Button; 
$B_EFile.Image = [Drawing.Icon]::ExtractAssociatedIcon((Get-Command explorer).Path)
$B_EFile.FlatStyle = 'Flat'
$B_EFile.Location = New-Object Drawing.Point 355,23; 
$B_EFile.Size = New-Object Drawing.Point 50,29;
$B_EFile.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular);
$B_EFile.add_click({
	$hostn = $IP_TEXT.Text;
	if (Test-Connection -ComputerName $hostn -Count 1 -Quiet)
	{
		explorer.exe "\\${hostn}\c$"
	}
}); 
$G_Remote.controls.add($B_EFile);
$B_EFile.add_MouseHover({
	$tooltipEX = New-Object System.Windows.Forms.ToolTip
	$tooltipEX.SetToolTip($B_EFile, "Browse the files of remote station.")
})

$label2 = New-Object Windows.Forms.Label; 
$label2.Location = New-Object Drawing.Point 10,36; 
$label2.Size = New-Object Drawing.Point 75,25; 
$label2.text = 'Command:';
$label2.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$G_Command.controls.add($label2); 

$COMMAND_TEXT = New-Object System.Windows.Forms.TextBox
$COMMAND_TEXT.Location = New-Object System.Drawing.Point(85,32)
$COMMAND_TEXT.Size = New-Object System.Drawing.Size(180,20)
$COMMAND_TEXT.TabIndex = 2
$COMMAND_TEXT.Add_KeyDown({
	if ($_.KeyCode -eq "Enter") { do_command }
})
$G_Command.controls.Add($COMMAND_TEXT)

$B_Command = New-Object Windows.Forms.Button; 
$B_Command.text = 'Execute'; 
$B_Command.FlatStyle = 'Flat'
$B_Command.Location = New-Object Drawing.Point 280,25; 
$B_Command.Size = New-Object Drawing.Point 100,40;
$B_Command.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular);
$B_Command.add_click({do_command;}); 
$G_Command.controls.add($B_Command);

$label3 = New-Object Windows.Forms.Label; 
$label3.Location = New-Object Drawing.Point 10,36; 
$label3.Size = New-Object Drawing.Point 75,25; 
$label3.text = 'Message:'; 
$label3.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$G_Message.controls.add($label3); 

$Message_TEXT = New-Object System.Windows.Forms.TextBox
$Message_TEXT.Location = New-Object System.Drawing.Point(85,32)
$Message_TEXT.Size = New-Object System.Drawing.Size(180,20)
$Message_TEXT.Add_KeyDown({
	if ($_.KeyCode -eq "Enter") { do_message }
})
$G_Message.controls.Add($Message_TEXT)

$tost=@"
using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace System
{
public class IconExtractor
{
public static Icon Extract(string file, int
"@

$B_Message = New-Object Windows.Forms.Button; 
$B_Message.TextImageRelation = 'ImageBeforeText'
$B_Message.text = 'Send'; 
$B_Message.ImageAlign = 'MiddleCenter'
$B_Message.ImageLayout = 'Stretch';
$B_Message.FlatStyle = 'Flat'
$B_Message.Location = New-Object Drawing.Point 280,25; 
$B_Message.Size = New-Object Drawing.Point 100,40;
$B_Message.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular);
$B_Message.add_click({do_message;}); 
$G_Message.controls.add($B_Message);

init_menu;

function ChangeIP {
	if (![string]::IsNullOrWhitespace($IP_TEXT.Text))
	{
		$hostn = $IP_TEXT.Text;
		if ($hostn -ne $env:COMPUTERNAME)
		{
			init_menu; 
			$ChangeIPForm = New-Object System.Windows.Forms.Form;  
			$ChangeIPFormB1 = New-Object System.Windows.Forms.Button; 
			$ChangeIPFormB2 = New-Object System.Windows.Forms.Button; 
			$ChangeIPForm.MinimizeBox = $false; 
			$ChangeIPForm.MaximizeBox = $false; 
			$ChangeIPForm.TopMost = $true; 
			$ChangeIPForm.AutoSizeMode = 'GrowAndShrink'; 
			$ChangeIPForm.FormBorderStyle = 'FixedDialog'; 
			$ChangeIPForm.ClientSize = '300, 315'; 
			$ChangeIPForm.ShowInTaskBar = $false; 
			$ChangeIPForm.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#252525')
			$ChangeIPForm.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($Color)
			$ChangeIPForm.StartPosition = 'CenterScreen'; 
			$ChangeIPForm.Text = 'Change Address: '+$hostn; 
			$ChangeIPForm.Font = $font;
			
			$labelIP1 = New-Object Windows.Forms.Label; 
			$labelIP1.Location = New-Object Drawing.Point 20,25; 
			$labelIP1.Size = New-Object Drawing.Point 90,25; 
			$labelIP1.text = 'interface:'; 
			$labelIP1.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
			$ChangeIPForm.controls.add($labelIP1); 
			
			$textIP1 = New-Object System.Windows.Forms.TextBox
			$textIP1.Location = New-Object System.Drawing.Point(120,25)
			$textIP1.Size = New-Object System.Drawing.Size(150,20)
			$textIP1.Text ='Ethernet'
			$textIP1.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
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
			$textIP2.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
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
			$textIP3.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
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
			$textIP4.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
			$ChangeIPForm.controls.Add($textIP4)
			
			$ChangeIPFormB1.Location = '10, 170'; 
			$ChangeIPFormB1.Size = New-Object Drawing.Point 280,35;
			$ChangeIPFormB1.Text = 'Change Addressing'; 
			$ChangeIPFormB1.add_click({do_change_ip});
			$ChangeIPFormB1.FlatStyle = 'Flat'
			$ChangeIPFormB1.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular); 
			$ChangeIPForm.Controls.Add($ChangeIPFormB1); 
			
			init_menu; 
			
			$labelIPHost = New-Object Windows.Forms.Label; 
			$labelIPHost.Location = New-Object Drawing.Point 20,225; 
			$labelIPHost.Size = New-Object Drawing.Point 90,25; 
			$labelIPHost.text = 'Hostname:'; 
			$labelIPHost.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
			$ChangeIPForm.controls.add($labelIPHost); 
			
			$textIPHost = New-Object System.Windows.Forms.TextBox
			$textIPHost.Location = New-Object System.Drawing.Point(120,225)
			$textIPHost.Size = New-Object System.Drawing.Size(150,20)
			$textIPHost.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
			$ChangeIPForm.controls.Add($textIPHost)
			
			$ChangeIPFormB2.Location = '10, 265'; 
			$ChangeIPFormB2.Size = New-Object Drawing.Point 280,35;
			$ChangeIPFormB2.Text = 'Change Hostname'; 
			$ChangeIPFormB2.add_click({do_change_hostname});
			$ChangeIPFormB2.FlatStyle = 'Flat'
			$ChangeIPFormB2.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Regular); 
			$ChangeIPForm.Controls.Add($ChangeIPFormB2); 
		
        [void]$ChangeIPForm.ShowDialog()
		}
		else{
			(New-Object -ComObject Wscript.Shell).Popup("Enter the address of the remote station, not the local.",0,"Terminal Manager",0x10 + 4096)
		}


	}
};


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
					Invoke-WmiMethod -Path Win32_Process -Name Create -ArgumentList "netsh interface ipv4 set address name=$hint static $haddr $hmask $hgat" -ComputerName $hostn
					$ChangeIPForm.Close()
				}
			}
		}
	}
};


function do_mstsc 
{
	& "mstsc.exe" "/v:$hostn"
};

function do_change_hostname 
{
	if (![string]::IsNullOrWhitespace($textIPHost.Text))
	{
		$newhostnamechange = $textIPHost.Text;
		Invoke-WmiMethod -Path Win32_Process -Name Create -ArgumentList "Rename-Computer -NewName $newhostnamechange" -ComputerName $hostn
		$ChangeIPForm.Close()
	}
	
	
}; 

function AboutF {
	init_menu; 
	$aboutForm = New-Object System.Windows.Forms.Form; 
	$aboutFormExit = New-Object System.Windows.Forms.Button; 
	$aboutFormNameLabel = New-Object System.Windows.Forms.Label; 
	$aboutFormText = New-Object System.Windows.Forms.Label;
	$aboutFormText2 = New-Object System.Windows.Forms.Label;  
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
	$aboutFormText.Size = '300, 20'; $aboutFormText.Text = '        Sebastian Mazurek'; 
	$aboutForm.Controls.Add($aboutFormText); 
	$aboutFormText2.Location = '80, 50'; 
	$aboutFormText2.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($Color)
	$aboutFormText2.Size = '300, 20'; 
	$aboutFormText2.Text = '                   semazurek.pl'; 
	$aboutForm.Controls.Add($aboutFormText2); 
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
	if (($ParentItem.Value) -is [System.Windows.Forms.MenuStrip]) { ($ParentItem.Value).Items.Add($private:menuItem);}
	if (($ParentItem.Value) -is [System.Windows.Forms.ToolStripMenuItem]) { ($ParentItem.Value).DropDownItems.Add($private:menuItem);} 
	return $private:menuItem; 
	}; 
	
	
	[System.Windows.Forms.MenuStrip]$mainMenu=New-Object System.Windows.Forms.MenuStrip; $form.Controls.Add($mainMenu); 
	$mainMenu.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#323232');
	$mainMenu.ForeColor = [System.Drawing.ColorTranslator]::FromHtml($Color);
	[scriptblock]$exit= {$form.Close()}; 
	[scriptblock]$activedirectory= {do_ad;}; 
	[scriptblock]$activedirectory2= {do_ad2;}; 
	[scriptblock]$remotedesktop= {do_mstsc;}; 
	[scriptblock]$putty= {putty;}; 
	[scriptblock]$powershell= {do_ps;}; 
	[scriptblock]$about= {AboutF}; 
	[scriptblock]$mnuFileEX1= {do_msconfig;}; 
	[scriptblock]$mnuFileEX2= {control.exe}; 
	[scriptblock]$mnuFileEX3= {do_urzadzenia;}; 
	[scriptblock]$mnuFileEX4= {do_uac_ustaw;}; 
	[scriptblock]$mnuFileEX5= {msinfo32}; 
	[scriptblock]$mnuFileEX6= {do_uslugi;}; #& "services.msc"
	[scriptblock]$mnuFileEX7= {eventvwr.msc}; 
	[scriptblock]$mnuFileEX8= {do_rejestr;}; 
	[scriptblock]$mnuFileEX9= {rundll32.exe keymgr.dll, KRShowKeyMgr}; 
	[scriptblock]$mnuFileEX10= {do_bios_res;}; 
	[scriptblock]$mnuFileView1= {if ($form.TopMost -eq $true) {$form.TopMost = $false} else {$form.TopMost = $true} ;}; 
	[scriptblock]$mnuFileView2= {change_view;}; 
	[scriptblock]$mnuFileView3= {cls
	Write-Host("`n----------------------------------------------------------------`n")
	Write-Host("`nPowerShell executive window for Terminal Manager application.`n")
	Write-Host("`n----------------------------------------------------------------`n")
	}; 
	
	(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuFileAD' -ItemText 'Active Directory' -ScriptBlock $null) | %{
	$null=addMenuItem -ParentItem ([ref]$_) -ItemName 'mnuFileAD1' -ItemText 'Active Directory Administrative Center' -ScriptBlock $activedirectory;
	$null=addMenuItem -ParentItem ([ref]$_) -ItemName 'mnuFileAD2' -ItemText 'Active Directory (Old)' -ScriptBlock $activedirectory2;} | Out-Null
	
	(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuFileZS' -ItemText 'Remote Control' -ScriptBlock $null) | %{
	$null=addMenuItem -ParentItem ([ref]$_) -ItemName 'mnuFilePZ' -ItemText 'Remote Desktop' -ScriptBlock $remotedesktop;
	$null=addMenuItem -ParentItem ([ref]$_) -ItemName 'mnuFilePutty' -ItemText 'PuTTY' -ScriptBlock $putty;  } | Out-Null;
	
	(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuFilePS' -ItemText 'PowerShell' -ScriptBlock $powershell); 
	(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuFileView' -ItemText 'View' -ScriptBlock $null) | %{
	$null=addMenuItem -ParentItem ([ref]$_) -ItemName '$mnuFileView1' -ItemText 'Pin/Unpin Window Always on Top' -ScriptBlock $mnuFileView1;
	$null=addMenuItem -ParentItem ([ref]$_) -ItemName '$mnuFileView2' -ItemText 'Show/Hide PowerShell Window' -ScriptBlock $mnuFileView2;
	$null=addMenuItem -ParentItem ([ref]$_) -ItemName '$mnuFileView3' -ItemText 'Clear PowerShell Window' -ScriptBlock $mnuFileView3;
	} | Out-Null
	(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuFileEX' -ItemText 'Extras' -ScriptBlock $null) | %{
	$null=addMenuItem -ParentItem ([ref]$_) -ItemName 'mnuFileEX1' -ItemText 'Msconfig' -ScriptBlock $mnuFileEX1;
	$null=addMenuItem -ParentItem ([ref]$_) -ItemName 'mnuFileEX2' -ItemText 'Control Panel' -ScriptBlock $mnuFileEX2;
	$null=addMenuItem -ParentItem ([ref]$_) -ItemName 'mnuFileEX3' -ItemText 'Device Manager' -ScriptBlock $mnuFileEX3;
	$null=addMenuItem -ParentItem ([ref]$_) -ItemName 'mnuFileEX4' -ItemText 'UAC Settings' -ScriptBlock $mnuFileEX4;
	$null=addMenuItem -ParentItem ([ref]$_) -ItemName 'mnuFileEX5' -ItemText 'Msinfo32' -ScriptBlock $mnuFileEX5;
	$null=addMenuItem -ParentItem ([ref]$_) -ItemName 'mnuFileEX6' -ItemText 'Services' -ScriptBlock $mnuFileEX6;
	$null=addMenuItem -ParentItem ([ref]$_) -ItemName 'mnuFileEX7' -ItemText 'Event Viewer' -ScriptBlock $mnuFileEX7;
	$null=addMenuItem -ParentItem ([ref]$_) -ItemName 'mnuFileEX8' -ItemText 'Registry Editor' -ScriptBlock $mnuFileEX8;
	$null=addMenuItem -ParentItem ([ref]$_) -ItemName 'mnuFileEX9' -ItemText 'Credential Manager' -ScriptBlock $mnuFileEX9;
	$null=addMenuItem -ParentItem ([ref]$_) -ItemName 'mnuFileEX10' -ItemText 'Restart to BIOS' -ScriptBlock $mnuFileEX10;
	} | Out-Null
	(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuFileAB' -ItemText 'About' -ScriptBlock $about); 
	
	init_menu;
	check_pre;
	
	if ($Debug -eq $false) {cls}
	Write-Host("`n----------------------------------------------------------------`n")
	Write-Host("`nPowerShell executive window for Terminal Manager application.`n")
	Write-Host("`n----------------------------------------------------------------`n")
	$form.ShowDialog();
	Invoke-Command -ScriptBlock {rm C:\ProgramData\log-oprog.txt;rm C:\ProgramData\log-pnpdevice.txt;rm C:\ProgramData\log-procesy.txt;rm C:\ProgramData\log-stacji.txt;}
		
