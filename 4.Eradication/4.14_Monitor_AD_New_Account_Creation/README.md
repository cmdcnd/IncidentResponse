# Task Monitor DHCP Server for New Reservations  


## Conditions  
Given a Domain Controller (DC), a domain account with required permissions to query AD, and an incident response workstation  


## Standards  
* Team member queries the DC to obtain the following minimum information:  
	* Name of user who created the new account  
	* Security Identifier (SID) of the user who created the new account  
	* Logon ID – provides semi-unique way to track user activity between reboots of computer  
	* Name of new user account  
	* SID of new account  
	* Domain of new account (only if multiple domains exist)  
* Team member outputs the account creation data to a comma-separate values (CSV) file and compares the entries to existing user accounts.  
* Team member checks information on account used to create new accounts against known IOCs or system owner activities to determine if accounts are legitimate.  
* Optional – Team member re-accomplished Task PR.AC-1.1 to obtain all user account attributes for comparison to existing accounts and verifying malicious activity  


## End State 
All new user or service account creation events are discovered  


## Notes  
There are various ways to do this task but from an incident response perspective the best choice (when supported) is a PowerShell script that queries the DC event logs for account creation event IDs. Team SOP will drive output formats, file-naming and storage requirements of output files for this and similar tasks. Windows Event ID 4720 is used in Windows 2008+ and Windows 7+ for account creation Windows Event ID 624 is used in Windows 2003 and prior.  

NB: Moved this BD from 'Protect' to the 'Detect' LOE per commander's guidance  


## Manual Steps  
* Lists all users who have been created within the last 5 days and the actual date:  
	```powershell
	$When = ((Get-Date).AddDays(-5)).Date
	Get-ADUser -Filter {whenCreated -ge $When} -Properties whenCreated
	```  

* Using PowerShell, dump new Active Directory accounts in last 5 Days:  
	```powershell
	import-module activedirectory
	Get-QADUser -CreatedAfter (Get-Date).AddDays(-5)
	Get-ADUser -Filter * -Properties whenCreated | Where-Object {$_.whenCreated -ge ((Get-Date).AddDays(-5)).Date}
	```  

* Get log events of new account creation:  
	```powershell
	Get-EventLog Security 4720 -after ((get-date).addDays(-1))
	```  

4722, when a account was enabled  
4726, when a account is deleted  
4725, when a account is disabled  

* Get SID of AD Group:  
	```powershell
	Get-ADGroup -Identity "some_group_name"
	```  

* Get Group name from SID:  
	```powershell
	Get-ADGroup -Identity S-1-5-32-544
	```  

* Get SID of a local user:  
	```bat
	wmic useraccount where name=‘some_username' get sid
	```

* Get SID for current logged in domain user:  
	```bat
	whoami /user
	```  

* Get SID for the local administrator of the computer:  
	```bat
	wmic useraccount where (name='administrator' and domain='%computername%') get name,sid
	```  

* Find username from a SID:  
	```bat
	wmic useraccount where sid='S-1-3-12-1234525106-3567804255-XYZAA-1111' get name
	```  

* Get SID for the domain administrator:  
	```bat
	wmic useraccount where (name='administrator' and domain='%userdomain%') get name,sid
	```  


## Running Script  
This script will be run at a command directed interval.  
`.\AD_AccountCreationDetection.ps1`  


## Dependencies  


## Other available tools  
[BloodHound](https://github.com/BloodHoundAD/BloodHound)  


## References  
[PowerShell Get Recently Created Users](https://github.com/WiredPulse/PowerShell/blob/master/Active_Directory/Get-ADUser_RecentlyCreatedUsers.ps1)  


## Revision History  
