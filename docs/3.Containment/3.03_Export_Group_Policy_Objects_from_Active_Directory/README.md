## Task Export Group Policy Objects (GPOs) from Active Directory   


## Conditions  
Given a Domain Controller (DC), a domain account with required permissions, and a workstation with Remote Server Administration Tools (RSAT)  


## Standards  
* Team member runs the Group Policy Management Console on the workstation and locates a GPO for export  
* Team member saves the report for the GPO to the local workstation.  

OR  

* Team member opens a PowerShell console and selects or creates a script using the Group Policy Cmdlets to export one or more GPOs to a local file  


## End State  
All Group Policy Objects have been exported to a local file for review  


## Notes  
The Group Policy Cmdlets for PowerShell are only available for Windows Server 2008 R2 and higher or Windows 7 or higher with the RSAT tools installed
## Manual Steps  
Example:  
	```powershell
	$GPOs = Get-GPO -All -Server $Server | Select-Object ID, Path, DisplayName, GPOStatus, WMIFilter, CreationTime, ModificationTime, User, Computer
	```  


## Running Script  


## Dependencies  


## Other available tools  


## References  
[Group Policy Cmdlets](https://technet.microsoft.com/en-us/library/ee461027.aspx)  
[List of PowerShell Scripts that will accomplish the tasks](https://github.com/WiredPulse/PowerShell)  


## Revision History  
