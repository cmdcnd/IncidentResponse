## Task Identify SMB using Security Onion  


## Conditions  
While using Security Onion alerts find SMB traffic  


## Standards  
* Login into Security Onion. 
* Select Alerts on the left panel  
* Ensure that Alerts are properly configured  
	* Set alerts as follows:  
		* Group: rule.name; Group: event.module; Group: event.severity_label  
* Set timeframe for your scan period (underlined area to the left of the refresh button)  
	* If the time is listed as calendar and hours, then click the calendar icon next to the date and select frequency (i.e. 1 day or last 6 hours etc. etc.)  
* Click on column title `event.severity_label` to sort the alerts by severity (high to low).  
* Search for SMB alert (i.e. `ET POLICY SMB Executable File Transfer.`)  
* Left click on the SMB alert and scroll down to Actions and click Hunt.  
* Click on the Hunt tab on the left side of the dashboard.  
* Ensure that the time frame is the same as the alert.  
* To the right of the search bar, delete everything in the quotations except `SMB.` Make sure that Group: event.module and Group: event.dataset is still active.  
	* If the two group sets are not active, click on the down arrow next to the search bar and click  
	* ` | groupby event.module event.dataset`  
* Click on Hunt. The search criteria should look as such: `SMB` | groupby event.module event.dataset  
* Scroll down to Events and then to sort, click on categories `rule.name` and/or event.severity_label  
* You may see a result such as:  
	* ET TROJAN CobaltStrike SMB P2P Default Msagent Named Pipe Interaction, A Network Trohan was detected, high  

## End State  
* Identify and monitor SMB file transfers  


## Manual Steps  
NA  


## Running Script  
N/A  


## Dependencies  
* Security Onion is running
* Alerts on Security Onion is properly configured 


## Other available tools  
NA  


## References  
[Security Onion Alerts](https://docs.securityonion.net/en/16.04/alerts.html)  
[Security Onion Hunt](https://github.com/Security-Onion-Solutions/securityonion-docs/blob/2.2/hunt.rst)  
