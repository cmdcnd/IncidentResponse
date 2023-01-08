## Task Perform a SCAP or Retina Scan of Network Configurations  


## Conditions  
Given an incident response workstation configured with the latest SCAP Compliance Checker, a current Open Vulnerability and Assessment Language (OVAL) file, and a copy of the configuration file for the device to be tested  


## Standards  
* Team member checks the make, model and software version of the device to be tested and ensures the latest OVAL file has been obtained from the manufacturer’s website or other source, such as DoD Cyber Exchange website https://cyber.mil/stigs/scap/   
* Team member uploads the OVAL file to the SCAP tool.  
* Team member selects the configuration file for the device to be tested in the SCAP tool.  
* Team member runs the SCAP tool and upon completion selects for output the detailed report for the scan.  
* Team member uses the report findings to research remediation steps for all vulnerabilities found.  


## End State  
All vulnerabilities present in the device configuration file are found.  


## Manual Steps  
* Open SCAP (Admin Account needed).  
* Under the Content section, right-click on the SCAP Content section & select Delete All  
* Select Install, then Browse.  
* Locate and select the downloaded SCAP 1.2 Content (only load the content needed for scanning).  
* Select Open, then Install.  
* Ensure the installed SCAP content is highlighted.  
* Under Stream Details, select the dropdown on MAC-1_Classified and choose MAC-1_Sensitive (this will need to be accomplished for all SCAP content installed).  
* Select Options, then Show Options.  
* Under Scanning Options, uncheck "Perform OCIL Scan".  
* Select Output Options, and then under Directory Options, select "Save Results to a Custom Directory" and type in where the files will be saved.  
* Select Save.  
* Under the Scan section, choose a scan type.  
	* Local (System you are currently logged into)  
	* Single Remote (Enter the FQDN of the remote system to scan)  
	* Multiple Remote (Uses a host.txt file with fully qualified DNS names)  
* Under the Content section, select the SCAP Benchmarks that you want to scan for.  
	* If content is now shown, select the Show Content button	
* Select "Start Scan".	
* Once the scan is complete, results will be available in specified folder.  


## Dependencies  
Latest SCAP tool and scan content `MUST` be installed  


## References  
[SCC 5.3 GUI Scanner](https://cyber.mil/stigs/scap/)  
[Cisco OVAL content](http://www.cisco.com/go/psirt)  
[OVAL Adoption Program Participant information](http://oval.mitre.org/adoption/participants.html)  
[The Security Content Automation Protocol](https://scap.nist.gov/index.html)  


## Revision History  
