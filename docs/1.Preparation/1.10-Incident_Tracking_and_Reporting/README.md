## Incident Tracking Task  


## Conditions  
* Given a database that all team members have access to  
* Create a database schema that support the tracking of cyber incidents  
* Report any incident that is confirmed as a true-positive to ACOIC (Who: Support - INTEL)  


## Standards  

???+ note "INCIDENT ID"  
	- **Question text:** Incident or case ID  
	- **User notes:** N/A  
	- **Question type:** text field  
	- **Variable name:** `incident_id` (string)  
	- **Purpose:** To uniquely identify incidents for storage and tracking over time.  
	- **Developer notes:** We recommend auto-generating IDs rather than prompting the user to create/submit one. If you plan to share an incident with others, we suggest not making your org's name part of the incident ID (e.g., `verizonBreach_00001`).  
	- **Miscellaneous:** N/A  

???+ note "SOURCE ID"  
    - **Question text:** Source or handler ID  
    - **User notes:** N/A  
    - **Question type:** text field  
    - **Variable name:** source_id (string)  
    - **Purpose:** Associate an incident with an entity that is handling or reporting it. This may be a CERT, law enforcement agency, consortium body, or some other custodian/aggregator of incident data. If the incident is handled or reported by the victim, this field is unnecessary (the victim_id will suffice).  
    - **Developer notes:** N/A  
    - **Miscellaneous:** N/A  

???+ note "INCIDENT CONFIRMATION"  
    - **Question text:** Was this a confirmed security incident?  
    - **User notes:** "Security incident" refers to any incident/event/occurrence/issue (or whatever) that compromises (or negatively affects) a security attribute (C*I-A) of an information asset in any form. This is an intentionally broad definition. In the case of false positives or “near misses” (unsuccessful attacks), the schema allows you to record the actor, action, and asset involved while leaving the attribute blank (since ascribing an attribute would imply the asset was negatively affected…which would mean it qualifies as an incident).  
    - **Question type:** [Enumerated list](http://veriscommunity.net/enums.html#section-incident_desc) (single-select)  
    - **Variable name:** `security_incident` (string; enumeration)  
    - **Purpose:** N/A  
    - **Developer notes:** N/A  
    - **Miscellaneous:** Designates confirmed incidents from those that are suspected or known non-incidents. One could, if desired, record information on a significant (but unsuccessful) attack while maintaining the ability to remove it from incident rollups and reporting (if desired).  

???+ note "INCIDENT SUMMARY"  
    - **Question text:** Please provide a brief summary of the incident.  
    - **User notes:** For each major event or phase in the incident, try to convey **"who did what to what/whom with what result?"** with as much detail as you deem appropriate. Consider, for example, the following scenario:  
		- **Event 1:** External attacker sends a phishing email to a victim employee to gain admin credentials.  
		- **Event 2:** Employee visits a web link in the phishing email and downloads a keylogger to their desktop.  
		- **Event 3:** Attacker uses stolen credentials to access the corporate network via legitimate remote access software and searches for sensitive data.  
		- **Event 4:** Attacker installs a backdoor program and a packet sniffer on a web server to capture card data and store it locally.  
		- **Event 5:** Attacker returns via the backdoor and exfiltrates the data.  
    - **Question type:** text field  
    - **Variable name:** `summary` (string)  
    - **Purpose:** Though the purpose of VERIS is to describe an incident using a structured format, capturing a short free-form narrative is still very useful for many reasons.  
    - **Developer notes:** N/A  
    - **Miscellaneous:** N/A  

???+ note "RELATED INCIDENTS"  
    - **Question text:** For example, the incident shares the same threat actor, external IP address, malware hash, or other characteristics with incidents submitted previously.  
    - **Question type:** text field  
    - **Variable name:** `related_incidents` (string)  
    - **Purpose:** Provides a simple and explicit way to associate different incidents.  
    - **Developer notes:** N/A  
    - **Miscellaneous:** This field can be used to link incidents in a larger campaign. To do this, simply generate some kind of shared identifier and record it in this field for each incident in the campaign. You'll be able to easily retrieve all incidents associated with that identifier when necessary.  
    - **Enumerations:** N/A  

???+ note "CONFIDENCE RATING"  
    - **Question text:** How certain are you that the information you provided about this incident is accurate?  
    - **User notes:** N/A  
    - **Question type:** [Enumerated list](http://veriscommunity.net/enums.html#section-incident_desc) (single-select)  
    - **Variable name:** `confidence` (string; enumeration)  
    - **Purpose:** Provides a level of confidence associated with the information submitted for this incident.  
    - **Developer notes:** N/A  
    - **Miscellaneous:** N/A  

???+ note "INCIDENT NOTES"  
    - **Question text:** General incident notes.  
    - **User notes:** Use this field to record general information, observations, etc., about the incident that are not captured by fields specified within VERIS. Each section has a similar place to record notes, and information specific to certain aspects of the incident (e.g., the threat actor involved) should be recorded in the appropriate section.  
    - **Question type:** text field  
    - **Variable name:** `notes` (string)  
    - **Purpose:** Record general information, observations, etc., about the incident that are not captured by fields specified within VERIS.  
    - **Developer notes:** N/A  
    - **Miscellaneous:** N/A  



## End State  
A commonly accessed database is set up for the team to record Incident Records for tracking purpose  


## Notes  
The intent of this Task is to create a common reporting structure for incidents so that they may be recorded accurately and shared as needed.  If Security Onion is used


## Manual Steps  


## Running Script  


## Dependencies  


## Other available tools  


## References  
[VERIS: the vocabulary for event recording and incident sharing](http://veriscommunity.net/index.html)  


## Revision History  
