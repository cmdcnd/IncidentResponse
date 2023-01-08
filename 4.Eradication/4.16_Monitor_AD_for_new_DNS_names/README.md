## Task Monitor Active Directory (AD) for new Domain Name System (DNS) Names  


## Conditions  
Given a Domain Controller (DC), a domain account with required permissions, and a workstation with Remote Server Administration Tools (RSAT)  


## Standards  
* Team member opens the DNS Console on the workstation and navigates to the Forward Lookup zone  
* Team member exports the list of records in the zone to a local file  
* Team member repeats this task periodically and compares the output files for new entries  

OR  

* Team member chooses a command line tool and writes or chooses an existing script that will export the contents of a DNS zone to a local file  
* Team member repeats the task periodically and compares the output files for new entries  


## End State  
All new DNS zone records are found and recorded  


## Notes  
This task is repetitive in nature and the use of a script to generate new files each time it is accomplished should be used. Comparison of the output files can be done manually or with a file diff’ing tool such as Kdiff; however, this process can also be automated in the same PowerShell script that pulls the zone record information.  


## Manual Steps  


## Running Script  
* Example PowerShell Script:  
	* All DNS Records  
		```powershell
		get-wmiobject -Namespace root\MicrosoftDNS -class microsoftdns_resourcerecord | select __Class, ContainerName, DomainName, RecordData, ownername | out-gridview
		```  

* RootHints  
	```powershell
	get-wmiobject -Namespace root\MicrosoftDNS -class microsoftdns_resourcerecord | where{$_.domainname -eq "..roothints"} | out-gridview -Zones Get-WmiObject -namespace "root\MicrosoftDNS" -class MicrosoftDNS_Zone | select Name
	```  

## Dependencies  


## Other available tools  


## References  
[Dnscmd tool reference](https://technet.microsoft.com/en-us/library/cc772069.aspx#BKMK_25)  
[Scripting with PowerShell](https://technet.microsoft.com/en-us/library/bb978526.aspx)  
[PowerShell DNS](https://github.com/WiredPulse/PowerShell/tree/master/DNS)  


## Revision History  
