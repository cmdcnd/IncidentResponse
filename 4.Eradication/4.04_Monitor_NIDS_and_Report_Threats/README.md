## Task Monitor Network Intrusion Detection System (NIDS) and Report Threats  


## Conditions  
Given a fully installed NIDS, e.g. Security Onion, connected to a span port or tap that monitors key terrain, an account for the NIDS, a known network topology and list of computers and provided services, and access to a second computer with Internet access for investigation.  


## Standards  
* Scan anomalies and irregularities within the interface to find possible malicious activity  
* Investigate suspicious anomalies to make a reasonable determination the NIDS information represents malicious activity  
* Use other tools (e.g. Bro/Zeke, Wireshark, Snort/Suricata) to validate the incident and rule out false positives  
* Report the incident to the intelligence team and the team leader  
* Collect all information relevant to the incident for a detailed report  


## End State  
After investigating NIDS report and malicious activity is determined, the intelligence team and team leader are informed. The team leader then informs the network owner of the incident and begins the response process.  


## Notes  


## Manual Steps  
* Login to the NIDS interface, e.g. Security Onion.  
* Scan through dashboards, visualizations, alerts, and individual documents/logs to find suspicious network activity.  
* Investigate each suspicious action on the network. The goal at this point is to quickly eliminate false positives and prioritize positive reports for further investigation. This is likely where defenders will spend most of their time and effort.  
* Once activity is determined to likely be malicious, use other available tools to corroborate the information and establish certainty about the nature of the activity. False positives are still eliminated and positives reprioritized.  
* When the defender is reasonably certain the suspicious activity is actually malicious, they alert the intelligence team and team leader. This begins the parallel processes for addressing network incidents, e.g. collecting intelligence, corroborating information with other team members, identifying patterns of malicious activity.  
* Continue to collect information about the activity and move on to the next steps in the investigation.  


## Running Script  
N/A  

## Dependencies  
* Security Onion  
	* Zeek (formerly Bro)  
	* Snort/Suricata  
	* SGUIL  
	* SO-forwarders  


## Other available tools  
* Splunk  


## References  


## Revision History  
