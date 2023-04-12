## Task Export Organizational Unit (OU) structure from Active Directory  


## Conditions  
Given a Domain Controller (DC), a domain account with required permissions, and a workstation with Remote Server Administration Tools (RSAT)  


## Standards  
* Team member obtains the correct name for the target domain  
* Team member determines the appropriate tool to connect to the domain controller and export the OU structure to a file on the local workstation  


## End State  
All Organizational Unit (OU) information been exported to a local file for review  


## Notes  
There are multiple tools available for this task, including dsquery and PowerShell. There are multiple examples of scripts using these tools available via Microsoft Technet and other forums.  


## Manual Steps  
Useful Commands:  
Windows  
* Get all of the OUs in a domain:  
	```powershell
	Get-ADOrganizationalUnit -Filter * | Select-Object -ExpandProperty DistinguishedName

	Get-ADOrganizationalUnit -Filter 'Name -like "*"' | Format-Table Name, DistinguishedName -A
	```

* List all OUs:  
	```bat
	dsquery ou DC=<DOMAIN>,DC=<DOMAIN EXTENSION>
	```  

* List of workstations in the domain:
	```bat
	netdom query WORKSTATION
	```  

* List of servers in the domain:  
	```bat
	netdom query SERVER
	```

* List of domain controllers:  
	```bat
	netdom query DC
	```  

* List of organizational units under which the specified user can create a machine object:  
	```bat
	netdom query OU
	```  

* List of primary domain controller:  
	```bat
	netdom query PDC
	```  


## Running Script  


## Dependencies  


## Other available tools  


## References  
[Get-ADOrganizationalUnit PowerShell Cmdlet](https://technet.microsoft.com/en-us/library/ee617236.aspx)   
[Get-OU_Permissions](https://github.com/WiredPulse/PowerShell/blob/master/Active_Directory/Get-OU_Permissions.ps1)  
[Dsquery OU command line reference](https://technet.microsoft.com/en-us/library/cc770509(v=ws.11).aspx)  
[LDIFDE.EXE command line tool](https://technet.microsoft.com/en-us/library/cc731033(v=ws.11).aspx)  
[CSVDE.EXE command line tool](https://technet.microsoft.com/en-us/library/cc732101(v=ws.11).aspx)  


## Revision History  
