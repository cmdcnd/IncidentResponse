# Task Monitor Account Creations  


## Conditions  
Given a Security Onion Server, a SO adamin account to query account creations, and an incident response workstation  


## Standards  
* Team member queries the Security Onion Server to obtain the following minimum information:  
	* Account Name  
	* Account Domain  
	* Machine the account was created on(If the account was created locally)  
	* SID of new account  
* Team member outputs the account creation data to a comma-separate values (CSV) file and compares the entries to existing user accounts.  
* Team member checks information on account used to create new accounts against known IOCs or system owner activities to determine if accounts are legitimate.  


## End State  
All new user or service account creation events are discovered  


## Notes  
Security Onion is able to detect local and domain account creations.  


## Manual Steps  
Use the following Security Onion search query  

winlog.event_id:"4720" | groupby event.module event.dataset  

Alternative Steps: Using windows event log, query for event id 4720.   


## Running Script  


## Dependencies  


## Other available tools  
PR.AC-1.7-Monitor_AD_New_Account_Creation will provide information about accounts created on the DC.


## References  
[EventID 4720](https://www.ultimatewindowssecurity.com/securitylog/encyclopedia/event.aspx?eventid=4720)  


## Revision History  
