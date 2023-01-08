## Task Investigate Alerts from Network Security Information and Event Management (SIEM) using IDS and other Logs  


## Conditions  
Given a fully installed SIEM (e.g., Graylog or similar) configured to accept logs from network hosts, a logon account for the SIEM, and a known network topology  


## Standards  
* Logon to the SIEM interface.  
* Scan for potential malicious or abnormal user or system activity, possibly by filtering events by certain category (e.g., logon/logoff of privileged users) to locate abnormal or suspected malicious behavior.  
* Using the reported information (user logon; privilege escalation; source/destination IP addresses, ports; file download information), conduct initial investigative steps to determine if activity can be deemed malicious.  
* If necessary, coordinate with other team members or system owner to determine if the activity is normal.  
* Notify Team Leader of suspected malicious activity and provide detailed information gathered from initial investigative steps.  


## End State  
Suspected abnormal activity reported by SIEM is investigated, determined to be malicious activity and reported to team intel member and Team Lead for further action.  


## Notes  
Rarely will an alert displayed by a SIEM be sufficient to determine a course of action for the team. The SIEM operator must correlate reported activity against normal network and host activity often without the time to establish a proper baseline. As with NIDS monitoring, SIEM activity is only a piece of the puzzle that may lead to establishing the presence of malicious activity on the network. The SIEM operator should be aware of the cyber key terrain including servers, administrator accounts, file storage and database locations to name a few that will be likely targets. If Host-based Intrusion Detection systems are not being aggregated to the SIEM, the operator must coordinate with other Blue Team members and/or the system owner to access those logs to cross-check events in the SIEM.  


## Manual Steps  


## Running Script  


## Dependencies  


## Other available tools  


## References  
[Security Onion](https://securityonion.net/)  
[Splunk Enterprise Security](https://www.splunk.com/en_us/products/premium-solutions/splunk-enterprise-security.html)  
[SIEM](http://www.tomsitpro.com/articles/siem-solutions-guide,2-864.html)  


## Revision History  
