# Terminal Manager

PowerShell Script for remote management computers in a domain.  
Getch information about local station. Last tested on Windows 10 Enterprise version 21H2.  

## What it can do

The script has such things as:  
<ul>
  <li>Active Directory, Remote Desktop and PowerShell as Admin launch, </li>  
  <li>Remote shutdown, restart and logout users from the station.  </li>
  <li>Information about current station.  </li>
  <li>Send remote messages to the station.  </li>
  <li>Show the current station storage serial numbers.  </li>
</ul>

## First look NEW (GUI)
![image](https://github.com/semazurek/Terminal-Manager-PowerShell/assets/85984736/9d77e8b7-47fe-42a6-832e-dacb1e45ef5a)

## How to use

You will probably need to change credentials to Domain Administrator of AD.  
It is 7th line in code of Terminal Manager.ps1  
(If you are already logged in, you don't have to change anything, because script will get it from Windows)  

```
#CREDENTIALS USED BY YOU:
$credent = $env:USERNAME+'@'+$env:USERDOMAIN
```

Value $credent stores information like so: username@localdomain.com and you can change it to whatever you want like:  

```
$credent = 'JohnSmith@'+$env:USERDOMAIN
```
or 
```
$credent = 'JohnSmith@Workdomain.com'
```
*<p align="center">And you are ready to go !</p>*

## Tips

### Get information about remote station
Use option: **Executing commands at the station**  
Type IP/Hostname and Command:  
```
systeminfo > C:\file.txt
```
After that in windows explorer type:  
```
\\IP/Hostname\c$
```
And view **file.txt** with all information in it.

### Get information about installed printers on remote station
Use option: **Powershell**  

```
Get-Printer -ComputerName IP/Hostname
```
This command provides information like:  
<ul>
  <li>Name of driver</li>
  <li>Local/Shared Printer</li>
  <li>Published (to others shared)</li>
  <li>Driver Name</li>
  <li>Port Name</li>
</ul>
