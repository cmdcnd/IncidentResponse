## Task Identify all AD Domain Accounts  


## Conditions  
Given a suspected compromised network segment(s), access to a system that can access and view the list of AD accounts as is.  


## Standards  
* The team member accesses the compromised system    
* The team member uses this script to output the AD users to a text file for analysis    
* The resulting scan data is a list of AD users for later analysis    


## End State    
All users of the domain are enumerated and any newly created accounts that may have happen will be identified.   


## Manual Steps    
* Get the users of the current domain:    
	```powershell  
	Get-ADUser -Filter *  
	```  

* To get the amount of users in the domain:    
	```powershell  
	$dcUsers = Get-ADUser -Filter *
	$dcUsers.Count
	6609
	```  

* To list all of the disabled AD accounts:  
	```powershell  
	Get-ADUser -Filter { Enabled -eq "False" } | Select-Object SamAccountName
	```  

* List of all accounts and attributes:    
	```bat
	dsquery * -limit 0
	"CN=Sochan\, Carlenel,OU=Users,OU=Santa Ana,DC=team01,DC=tgt"
	"CN=Team01-WK4355,OU=Computers,OU=Los Angeles,DC=team01,DC=tgt"
	```  


## Running Script   
When the script is ran, it will enumerate all users of the domain and output them into a file named all_ad_domain_accounts.txt later analysis.     
	```powershell
	PS .\2.16_ListADDomainAccounts.ps1
	[+] Current Domain: team01.tgt
	[+] There are 6609 users in team01.tgt
	[+] Writing domain users to all_ad_domain_accounts.txt...
	[+] Done!
	```  

## Dependencies  
N/A

  
## Other available tools  
N/A


## References  
N/A 


## Revision History    
