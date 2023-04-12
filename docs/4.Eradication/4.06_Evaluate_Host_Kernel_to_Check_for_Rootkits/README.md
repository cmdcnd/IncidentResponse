# Task Evaluate Host Kernel to Check for Rootkits  


## Conditions  
Given a suspected compromised Windows desktop computer system, a local administrator account, incident response tools, and one or more Indicators of Compromise (IOCs).  


## Standards  
* The team member annotates the system name, serial number, manufacturer, and time of action in the Incident Log.   
* The team member inserts media that contains the rootkit detection application.   
* The team member runs the rootkit detection application with the correct parameters and exports the data to the local drive, external USB media, or network share. a. Removal of the rootkit is not part of this evaluation, only identification. Removal is part of Task 4.25: Stop Malware – Rootkit.  
* Review screen or tool log file for indicators of the presence of a rootkit against provided IOCs  


## End State  
rootkit-related elements are identified  


## Notes  
When a rootkit is suspected, there are various considerations to consider when determining the best method to complete this task. Based on the IOCs some research of the suspected rootkit may preclude the connection of USB drives which may in turn be compromised. This task can be accomplished remotely using PSExec or batch file. Some tools require renaming before being copied to the compromised machine and should be covered in their documentation.   


## Manual Steps for Linux  


### Chkrootkit  

* Install chkrootkit  
	```bash
	sudo apt-get install chkrootkit
	```

* You can run chkrootkit once installation has been complete.  
	```bash
	chkrootkit
	```

* Investigate any findings  To view the help section for chkrootkit use the following command  
	```bash
	chkrootkit -h
	```


### Rkhunter  
* Install rkhunter  
	```bash
	sudo apt-get install rkhunter
	```

* View the options for rkhunter by typing the following command  
	```bash
	rkhunter
	```

* Run rkhunter  
	```bash
	rkhunter -c
	```

* View results in the terminal or read the log file. The location for the log file is located in /var/log/rkhunter.log  
	```bash
	cat /var/log/rkhunter.log
	```

* Investigate any findings  


## Dependencies  


## References
[chkrootkit - Linux](http://www.chkrootkit.org/)  
[rkhunter - Linux](http://rkhunter.sourceforge.net/)  
[GMER](http://www.gmer.net)  
Windows Defender Offline (32-bit and 64-bit downloads from Microsoft.com) 
[TDSSKiller - Kaspersky](http://usa.kaspersky.com/downloads/TDSSKiller)  
[McAfee Rootkit Remover](http://www.mcafee.com/us/downloads/free-tools/rootkitremover.aspx)  
[OSSEC](http://ossec.github.io/downloads.html)  


## Revision History  
