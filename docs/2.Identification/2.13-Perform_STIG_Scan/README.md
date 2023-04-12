## Task Perform STIG Scan  


## Conditions  
Given a list of hosts with known operating systems and/or applications, the user will complete a scan using the appropriate STIG (Security Technical Implementation Guide) using assigned tool. These standards follow using Nessus as the tool to perform the scan. SCAP (Security Content Automation Protocol) compliant STIGs should be used when possible.  


## Standards  
* Identify appropriate STIG(s) to be used to analyze.  
  * This is dependent upon the Network Owner disclosing their complete IT Inventory  
* Scan using the chosen STIG using Nessus.  
  * These will likely be conducted several times, one per software target  
* Export results of the scan.  
  * Standardize naming convention to include Software Target and Time/Date  


## End State  
Results of the STIG scan baselines the host and identifies any security control weaknesses.  


## Manual Steps  
* Navigate to the Mission Directory and view the discovered targets.  
	```
	cd /ios/data/assess/<MISSION_DIR>  
	```  

* List the output files specifying the discovered targets.  Files with a size > 0 indicate that OS were found in the initial scan.  
	```bash
	ls –la ./collect/targ  
	```  

* For the STIG/Compliance scan, run a Nessus STIG scan against each OS type (a.k.a. target):  
	```bash
	nessus.sh localhost win_<OS Type>_stig ./collect/targ/<OS Type>.ips   
	```  

* View the output of the above STIG scan:  
	```bash
	ls -la ./collect/nbe  
	```  
 
* Determine the timestamp of win_<OS Type>_stig.nbe file by running the nbeSTIG2tab.sh script against the nbe files created in Step 2  
	```bash
	nbeSTIG2tab.sh ./collect/nbe/<timestamp>-win_<OS Type>_stig.nbe > win_<OS Type>_stig.tab  
	```  

* Organize the results by moving the timestamped tab file into the 'reports' directory:  
	```bash
	mv ./win_<OS Type>_stig.tab ./report/  
	```  


### Nessus Command Line Switches  
	```  
	-I #Specify the input file for the Nessus client to read when converting between two report formats. You can use nessus to do conversion between formats used for reports. Nessus can take any NSR or NBE reports and change them into HTML, XML, NSR or N  
	
	-o #Specify the output file for the Nessus client to create when converting between two report formats. You can use nessus to do conversion between formats used for reports. Nessus can take any NSR or NBE reports and change them into HTML, XML, NSR  
	
	-p #Uses the Nessus client to obtain the list of plugins available on the Nessus server.  
	
	-P #Uses the Nessus client to obtain the list of server and plugin preferences from the Nessus server.  
	
	-S #Causes the Nessus client to generate SQL syntax for the output of the '-p' (show plugins on the server) and '-P' (show server/plugin preferences) commands.  
	
	-T #Define what format should be used for the report data from a scan. Options are: nbe, html, html_graph, text, xml, old-xml, tex, or nsr.  
	```  
  

### Nessus Web Interface  
To perform a certified SCAP assessment, follow these high-level steps:  
* Download certified NIST SCAP content in its zip file format. Note that the entire zip file must be obtained for use with Nessus.  
* Create a scan or policy using Nessus’ SCAP Compliance Audit library template. Add a scan name, target(s), and credentials for the target system(s).  
* Upload the SCAP content zip file to the Nessus scan or policy in the appropriate Active SCAP Components section under “SCAP File (zip)”. From the SCAP XML file, select the appropriate data stream, benchmark, and profile to be used in the desired audit.  
* Perform a vulnerability scan based on the selected scan or policy.  
* When the scan is completed, view the results within Nessus’ “Scans” section  


### Downloading SCAP XCCDF  
Nessus users can obtain the various SCAP bundles. Bundles can be downloaded collectively as a single .zip archive depending on the platform to be assessed and the version of SCAP and OVAL desired to be used in an assessment.  

[NIST Scap Content](https://nvd.nist.gov/ncp/repository)  
[Stig Viewer](https://www.stigviewer.com/stigs)  


### Exporting Scan Results  
To export your scan results for importing into another Nessus instance, choose the “Nessus” export format. This provides a .nessus file of the report results. The name of the file will be in the format of <scan_name>_<scan_ID>.nessus where the scan name is the actual scan name used in Nessus.   


## Running Script  
N/A  
  

## Dependencies  
[Nessus (Free Trial)](https://www.tenable.com/try)  
* NOTE: The Free version only allows scanning of 16 IPs  
[Nessus Professional](https://www.tenable.com/products/nessus)  
* NOTE: You can try Nessus Professional Free for 7 days  
  * Most likely requires a minimum 1yr subscription  
  
## Other available tools  
- [DISA SCAP tool](https://public.cyber.mil/stigs/)  


## References  
[Tenable Trial](https://www.tenable.com/try)  
[Tenable SCAP Guide](http://static.tenable.com/documentation/Nessus_6.1_SCAP_Assessments.pdf)  
* NOTE: Notice the version number on this link. Steps should be similar with different Nessus versions unless noted.  
[Stig Viewer](https://www.stigviewer.com/stigs)  
[NIST Scap Content](https://nvd.nist.gov/ncp/repository)  


## Revision History  
