## Task Evaluate Active Directory (AD) Configurations using PowerShell  


## Conditions  
Given an incident response workstation with PowerShell configured, Domain Administrator-level credentials, and a target Domain.  
Must of knowledged of domain given from network owner.  


## Standards  
* Team member verifies connectivity to the Domain Controller with provided credentials  
* Team member ensures the Active Directory module has been imported into the PowerShell console prior torunning scan.  
* Team member runs a PowerShell script utilizing ADcommandlets that capturethe following AD-related informationto an output file.  
	* Domain Controllers(DCs)  
	* Domain Groups  
	* Domain Organizational Units (OUs)  
	* Domain Computers  
	* Domain Users  
	* Domain Service Accounts  
	* Group Membership  
	* OU Membership  
* Team member saves the output file for comparison to later evaluations  


## End State  
AD configuration information for the target domain is output to a text or XML file for later comparison.  


## Manual Steps  
Using a team laptop that is not a member of the domain launch ad enumeration script.  
After launching the script you will be prompted for some additional information.  

* Type in domain credentials in the format Domain\Username. `i.e. team02\Administrator`  
* Type in known Domain Controller Name. In the range it looks like something like: `i.e. team02-dc01`  
* Type in Known Domain name. In the range it looks something like: `i.e. team02.tgt`  
* Give the script 5-10 minutes to run, then check `C:\Temp\export.txt`  

To compare this file save it to a differen directory then run again at a later time and user a program like Notepad++ and the Diff extention  


## Script  
2.15_AD_Enumeration_FromExternal.ps1  


## Dependencies  
* PowerShell  


## Other available tools  
* Windows Command Line  
* Managed Engine AD Manager and AD Audit Plus  


## References  
[Microsoft PowerShell Scripting Version 7](https://docs.microsoft.com/en-us/powershell/scripting/overview?view=powershell-7)  


## Revision History  
