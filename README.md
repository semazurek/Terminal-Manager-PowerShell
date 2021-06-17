# Terminal Manager

## First look
![ss2](https://user-images.githubusercontent.com/85984736/122421879-fce26a80-cf8c-11eb-9a8d-50a00a2ebf75.png)

## What it can do

The script has such things as:  
<ul>
  <li>Active Directory, Remote Desktop and PowerShell as Admin launch, </li>  
  <li>Remote shutdown, restart and logout users from the station.  </li>
  <li>Information about current station.  </li>
  <li>Send remote messages to the station.  </li>
  <li>Show the current station storage serial numbers.  </li>
</ul>
  
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
$credent = JohnSmith@Workdomain.com
```



