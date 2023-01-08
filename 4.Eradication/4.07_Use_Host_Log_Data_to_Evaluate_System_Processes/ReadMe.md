## Task Use Host Log Data to Evaluate System Processes  


## Conditions  
Given a suspected compromised Windows desktop computer system, local administrator account credentials, one or more Indicators of Compromise (IOCs) and incident response software  


## Standards  
* The team member annotates the system name, serial number, manufacturer, and time of action in the Incident Log.  
* The team member logs into or connects remotely using the credentials of an account with local administrator privileges.  
* The team member obtains an image of the target computer physical memory to an external USB drive or network share.   
* The team member obtains a cryptographic hash (MD5 or SHA1) of the physical memory image and saves to a file on an external USB drive or network share.  
* The team member utilizes a file hashing utility to gather the MD5 and/or SHA1 hashes of all files on the target computer and saves to a file on an external USB drive or network share.  
* The team member utilizes the tools from the selected incident response software to obtain the following information from the target system and saves the data to an external USB drive or network share:  
	* System date/time with time zone  
	* Operating System version plus Service pack, if any  
	* Memory capacity (RAM)  
	* Listing of hard drives and sizes  
	* Current and previous file system mount information  
	* USB connection history  
	* List of auto-run software (registry keys, Startup folder, etc.)  
	* Listing of services and status  
	* List of installed software  
	* List of scheduled tasks  
	* List of local user accounts and group membership  
	* List of network interfaces with IP and MAC addresses  
	* Routing table  
	* Arp cache  
	* DNS cache  
	* Network connections with associated processes  
	* Loaded drivers  
	* Open files and handles  
	* Running processes with Process ID (PID) and runtime information  
	* All Windows event logs  
	* Antivirus, firewall or HIDS logs if available  
* The team member reviews the log and text files obtained in Step 6 for entries that match one or more IOCs.  
   

## End State  
Log and text file entries are found that match provided IOCs  


## Manual Steps  
NA


## Running Script  
After downloading script, Launch powershell with Administrative Privileges, select options to run and press q to quit  


## Dependencies  
* Download Powershell  
* Windows Operating System  


## Other available tools  
NA  


## References  
[PowerShell Overview](https://docs.microsoft.com/en-us/powershell/scripting/overview?view=powershell-7)  


## Revision History  
