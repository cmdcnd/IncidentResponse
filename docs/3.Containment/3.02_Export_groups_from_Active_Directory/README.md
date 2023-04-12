## Task Export List of Groups from Active Directory    


## Conditions  
Given domain credentials with the appropriate permissions, and an incident response workstation with necessary tools and access to the Primary Domain Controller for the target domain  


## Standards  
* Team selects the best method to connect to the Domain Controller (DC) and tool that will provide the required information  
* Team member obtains Domain group information that may include the following:  
	* Canonical Name  
	* Display Name  
	* Distinguished Name  
	* Group Category  
	* Group Scope  
	* Object GUID  
	* sAMAccountName  
	* Security Identifier (SID)  
	* Creation Date/Time  
	* Modified Date/Time  
* Group data is exported to a CSV file and stored according to team SOP  


## End State  
All Domain Groups have been exported to a CSV file with information required to allow for detection of malicious activity.  


## Manual Steps  


## Notes  
The tool chosen can limit the amount and type of information exported and is an important consideration for this task. In an incident response scenario, information such as creation time/date or modified date can all be vital information in determining malicious activity. Unless the Domain Controller is a version that does not support it, PowerShell is the best choice for this task.  

While not necessary, retrieving all of the group name properties enables the responder to determine anomalies in the naming of groups that may indicate they were created by a malicious actor unfamiliar with the domain naming convention or policy.  

There are various Active Directory (AD) PowerShell commands that can be combined to provide a comprehensive script that combines group property information along with a list of users that are members of the group. While not part of this task, this is important information when monitoring changes in AD during an incident.  


## Running Script  


## Dependencies  


## Other available tools  


## References  
[Get-ADGroup PowerShell syntax](https://technet.microsoft.com/en-us/library/ee617196.aspx)  
[Get-ADGroupMember syntax](https://technet.microsoft.com/en-us/library/ee617193.aspx)  
[Compare-Object syntax](https://technet.microsoft.com/en-us/library/ee156812.aspx)  


## Revision History  
