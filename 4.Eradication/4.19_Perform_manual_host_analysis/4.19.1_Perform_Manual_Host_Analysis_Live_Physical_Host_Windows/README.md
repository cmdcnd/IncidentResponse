## Task Perform Manual Host Analysis – Live Physical Host - Windows  


## Conditions  
Given a suspected compromised system, local administrator account credentials, analysis tools, and one or more Indicators of Compromise (IOC).  


## Standards  
* The team member inserts a USB device containing the memory analysis tools to the suspected compromised computer.  
* The team member loads the analysis software from the USB drive and initiates a scan of the computer’s live memory outputting the results to the USB drive.  
* The team member analyzes the output of the tool and validates the presence of provided IOCs.  


## End State  
Processes, files, registry entries and other artifacts are identified that match one or more IOCs  


## Notes  
If the IOCs from the incident indicate possible infection passing to any external USB data device plugged into the target system, the tools output results should be sent over the network to a secure share folder.  
* Tools:
  * Redline – Mandiant tool that can analyze the live memory of a compromised computer from from an external USB drive. This required that Mandiant Redline be installed on a team member computer which can then copy the required files to an external USB.  


## Manual Steps  


## Running Script  


## Dependencies  


## Other available tools  


## References  
[FireEye Redline](https://www.fireeye.com/services/freeware/redline.html)  


## Revision History  
