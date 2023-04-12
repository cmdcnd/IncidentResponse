## Task Gather AD Structure Information  


## Conditions  
Given a suspected compromised network segment(s), access to a system that can gather the structure of the suspected domain.  


## Standards  
* The team member identifies possibly compromised network segment(s).  
* The team member accesses a system that can enumerate the domain  
* The team member utilizes various Powershell cmdlets to enumerate the domain structure and/or users  
  * Task 2.14 – Gather AD structure information  
* The resulting enumerated data is compared to a known good AD configuration file to determine any anomalies present in the domain.  

## End State  
The structure of the domain is enumerated based on the specific sub-task accomplished and any anomalies on the domain will be identified.  

## Manual Steps  
* Get information of the current domain  
	```powershell  
	PS C:\Users\btadmin\Desktop> $adddomain = Get-ADDomain  
	PS C:\Users\btadmin\Desktop> $adddomain  
	AllowedDNSSuffixes    : {}  
	ChildDomains          : {}  
	ComputersContainer    : CN=Computers,DC=team01,DC=tgt  
	--snipped--  
	```  
  
* Get structure of domain  
	```powershell  
	PS C:\Users\btadmin\Desktop> Get-ADObject -Filter { ObjectClass -eq 'organizationalunit' } -PropertiesCanonicalName | Select-Object -Property CanonicalName
	CanonicalName
	-------------
	team01.tgt/Domain Controllers
	team01.tgt/Microsoft Exchange Security Groups
	team01.tgt/Groups
	team01.tgt/Chula Vista
	--snipped--
	```  

Output should be in the format identified in 'output_format_template.csv' and named [mm/dd/yyyy_hh:mm:ss_AD_Structure_(xx.xx.xx.xx/x)]  

Notify mission element lead and intelligence analyst of completion of this battle drill  

## Running Script  
* Download script from 2.14_Gather_AD_Structure_Information  

* Run scripts  
	```powershell  
	PS C:\Users\btadmin\Desktop> .\2.14_GatherADSTructureInfo.ps1
	[+] Writing Active Directory structure to C:\Users\btadmin\Desktop\CyberSurfers\CyberSurfers_ACL_1593261366.22937.txt...
	[+] Done!
	```  

* The logfile will be saved to CyberSurfers directory for analysis  
	```powershell  
	PS C:\Users\btadmin\Desktop> cat .\CyberSurfers\CyberSurfers_ACL_1593261366.txt
	[+] Domains infrastructure master: Team01-DC01.team01.tgt
	[+] The Active Directory structure as follows:
	DC=team01,DC=tgt
	--> OU=Alameda
	----> OU=Computers
	----> OU=Groups
	----> OU=Servers
	----> OU=Users
	--snipped--
	```  


## Dependencies  
N/A

  
## Other available tools  
N/A


## References  
N/A 


## Revision History  
