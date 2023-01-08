## Task Verify Patch Compliance on all Hosts systems  


## Conditions  
Given domain credentials with the appropriate permissions, and a vulnerability scanner perform a vulnerability scan from an incident response workstation.  


## Standards  
* Detect. Use approved scanning tool to scan your systems for missing security patches.  
* Assess. If necessary updates are not installed, determine the severity of the issue(s) addressed by the patch and the mitigating factors that may influence your decision. By balancing the severity of the issue and mitigating factors, you can determine if the vulnerabilities are a threat to your current environment.  
* Approval. Obtain appropriate approval on enclave prior to proceeding with remediation procedures  
* Document. Document actions and approval through change management procedures.  
* Acquire. If the vulnerability is not addressed by the security measures already in place, download the patch for testing.  
* Test. Install the patch on a test system to verify the ramifications of the update against your production configuration.  
* Deploy. Deploy the patch to production computers. Make sure your applications are not affected. Employ your rollback or backup restore plan if needed.  

## End State  
Perform a Vulnerability scan on targeted systems in enclave and verify patch compliance is within standards with local policy requirements.  


## Notes  


## Manual Steps  
Detect open vulnerabilities using OpenVAS Security scanner  
* Access OpenVAS web front-end at https://x.x.x.x:9392  
* Enter the IP address or host name of the system(s) you wish to scan and press `Start Scan`  
	* You will be presented with an updated progress bar as the scan progresses through the scan  
	* Once the scan is completed you will be presented with a results page  
* Verify results are in compliance with enclave SOP and local policy  
* Review the report – The complete report as well as only filtered results can be viewed and downloaded. By default only the High and Medium risks are displayed.  

OR  

To manually detect missing updates using the MBSA graphical interface  
* Run MBSA by double-clicking the desktop icon or by selecting it from the Programs menu.  
* Click Scan a computer. MBSA defaults to the local computer. To scan multiple computers, select Scan more than one computer and select either a range of computers to scan or an IP address range.  
* Clear all check boxes except Check for security updates. This option detects uninstalled patches and updates.  
* Click Start scan. Your server is now analyzed. When the scan is complete, MBSA displays a security report and also writes the report to the %userprofile%\SecurityScans directory.  
* Download and install the missing updates.  
Click the Result details link next to each failed check to view the list of uninstalled security updates. A dialog box displays the Microsoft security bulletin reference number. Click the reference to find out more about the bulletin and to download the update.  

OR  

Windows:  
To detect missing updates using the MBSA command line interface  
* From a command window, change directory to the MBSA installation directory, and type the following command  
	```bat
	mbsacli /i 127.0.0.1 /n OS+IIS+SQL+PASSWORD
	```  

* You can also specify a computer name. For example:
	```bat
	mbsacli /c domain\machinename /n OS+IIS+SQL+PASSWORD
	```  

* You can also specify a range of computers by using the /r option. For example:
	```bat
	mbsacli /r 192.168.0.1-192.168.0.254 /n OS+IIS+SQL+PASSWORD
	```  

* Finally, you can scan a domain by using the /d option. For example:  
	```bat
	mbsacli /d NameOfMyDomain /n OS+IIS+SQL+PASSWORD
	```

To analyze the generated MSBA report  
* Run MBSA by double-clicking the desktop icon or by selecting it from the Programs menu.  
* Click Pick a security report to view and open the report or reports, if you scanned multiple computers.  
* To view the results of a scan against the target machine, mouse over the computer name listed. Individual reports are sorted by the timestamp of the report.  

* Ubuntu:  
	* Fetch list of available updates:  
		```bash
		apt-get update
		```  

	* Strictly upgrade the current packages:  
		```bash
		apt-get upgrade
		```  

	* Install updates (new ones):  
		```bash
		apt-get dist-upgrade
		```  

* Red Hat Enterprise Linux 2.1,3,4:  
	* Install updates (new ones):  
		```bash
		up2date
		```  

	* To update non-interactively:  
		```bash
		up2date-nox --update
		```  

	* To install a specific package:  
		```bash
		up2date <PACKAGE NAME>
		```  

	* To update a specific package:  
		```bash
		up2date -u <PACKAGE NAME>
		```  

* Red Hat Enterprise Linux 5:
	```bash
	pup
	```  

* Red Hat Enterprise Linux 6:  
	* Fetch list of available updates:
		```bash  
		yum update
		```  

	* To list a specific installed package:  
		```bash  
		yum list installed <PACKAGE NAME>  
		```  

	* To install a specific package:  
		```bash  
		yum install <PACKAGE NAME>
		```  

	* To update a specific package:  
		```bash  
		yum update <PACKAGE NAME>
		```  

* Kali:  
	```bash  
	apt-get update && apt-get upgrade
	```  


## Running Script  


## Dependencies  


## Other available tools  


## References  
[OpenVAS setup instructions](http://tools.kali.org/vulnerability-analysis/openvas-scanner)  
[OpenVAS Documentation](http://docs.greenbone.net/index.html#user_documentation)  
[Microsoft Baseline Security Analyzer](https://technet.microsoft.com/en-us/security/cc184924.aspx)  
[NIST SP 800-42, Guidelines on Network Security Testing](http://csrc.nist.gov/publications)  
[NIST SP 800-40, Creating a Patch and Vulnerability Management Program](http://csrc.nist.gov/publications)  


## Revision History  
