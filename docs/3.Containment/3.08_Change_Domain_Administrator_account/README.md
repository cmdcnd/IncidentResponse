## Task Change Local Administrator Account Password on Domain Controller (DC)  


## Conditions  
Given a target Domain, a Domain Controller (DC), a user account with appropriate rights and privileges to modify user accounts, and a workstation with the Windows Remote Server Administration Tools (RSAT) installed  


## Standards  
* Team member coordinates the requirement to modify the Administrator account on the DC  
* Team member opens the Active Directory Users and Computers (ADUC) console on the workstation and locates the built-in Administrator account within the Organizational Unit (OU) structure  
* Team member resets the password and closes ADUC  

OR  

* Team member coordinates the requirement to modify the Administrator account on the DC  
* Team member utilizes AD PowerShell cmdlets to modify the Administrator account  


## End State  
Target domain Administrator account password has been modified  


## Notes  
Mission Element lead ought to request this capability of the business owner in order to secure accounts and organizational units  


## Manual Steps  
Caution should be used when changing the domain Administrator password. In some environments the domain Administrator account may be tied to various services which may or not be affected. In a response scenario, this action should be closely coordinated with the system owner who can assist in monitoring the impact to the enclave.  
* Example PowerShell Command:  
	* Using CNAME  
		```powershell  
		Set-ADAccountPassword 'CN=<CN Name>,OU=<OU>,DC=<domain>,DC=<DC>' -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "<NewPassword>" -Force)
		```

	* Using SAM Account Name  
		```powershell  
		Set-ADAccountPassword -Identity <SAMAccountName> -OldPassword (ConvertTo-SecureString -AsPlainText "<old password>" -Force) -NewPassword (ConvertTo-SecureString -AsPlainText "<new password>" -Force)
		```  


## Running Script  


## Dependencies  


## Other available tools  


## References  
[PowerShell Set-ADAccountPassword documentation](https://technet.microsoft.com/en-us/library/ee617261)  


## Revision History  
