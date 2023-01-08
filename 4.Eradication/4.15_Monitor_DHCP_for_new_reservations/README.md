## Task Monitor DHCP Server for New Reservations  


## Conditions  
Given a Dynamic Host Configuration Protocol (DHCP) server, an administrator-level account, and an incident response workstation  


## Standards  
* Team member determines if audit logging is enabled within the DHCP Management Console  
* Team member enables logging if it is not already enabled.  
* Team member connects to the DHCP server log and determines the presence of creation of new reservations  
* Team member exports applicable Windows events to an external file  


## End State  
All new DHCP reservations are discovered and logged  


## Notes  
There are various ways to do this task but from an incident response perspective the best choice (when supported) is a PowerShell script that queries the DHCP event logs for reservation creation event IDs. The applicable log on Server 2008+ is Microsoft-Windows-DHCP Server Events/Operational in c:\windows\system32\winevt\logs. The applicable Event ID is 106. (csv files can be parsed with powershell via the Get-Content Commandlet). Team SOP will drive output formats, file-naming and storage requirements of output files for this and similar tasks. Windows 2012 Server and higher support PowerShell DHCP commands that may also leave log traces in the PowerShell logs.  


## Manual Steps  
Example Commands:  

* Windows
	* Enable DHCP server logging:  
		```bat
		reg add HKLM\System\CurrentControlSet\Services\DhcpServer\Parameters /v ActivityLogFlag /t REG_DWORD /d 1
		```  

* Default Location Windows 2003/2008/2012:  
    `%windir%\System32\Dhcp`  

* Linux
  * View DHCP lease logs: Ubuntu:  
		```bash
		grep -Ei 'dhcp' /var/log/syslog.1
		```  

  * View DHCP logs  
		```bash
		tail -f dhcpd.log
		```  

## Running Script  

* Example Script  
	```powershell
	# Gather dhcp lease information  
	# Change the scope range to your specific scope range  
	netsh dhcp server scope <IP ADDRESS> show clients 1 > C:\Monitor\New_dhcp_list.txt

	# remove top 8 lines  
	$file = cat C:\Monitor\New_dhcp_list.txt | select -skip 8

	#remove bottom 4 lines
	$len = $file.length-4
	$file = $file[0..($len)]

	#loop through each line in the file and grab the relevant columns
	$file | foreach-object{$_.split()[0,4,7,18] -join ' '} > C:\Monitor\New_dhcp_list.txt

	#add white space and title
	echo " " >> .\Domain_Changes_Log.txt
	echo " " >> .\Domain_Changes_Log.txt echo "DHCP Checked" >> .\Domain_Changes_Log.txt

	#add date time stamp
	get-date >> .\Domain_Changes_Log.txt

	#compare known good to new list then add new dhcp leases to the log file
	Compare-Object $(Get-Content .\Known_good_dhcp_list.txt) $(Get-Content .\new_dhcp_list.txt) >> .\Domain_Changes_Log.txt
	if ((Compare-Object $(Get-Content .\Known_good_dhcp_list.txt) $(GetContent .\New_dhcp_list.txt)) -ne $null)
			{
					[System.Reflection.Assembly]::LoadWithPartialName("System.Windows. Forms") $oReturn=[system.windows.forms.messagebox]::show("DHCP Client has been added! This change needs to be verified and the master list updated.")
			}
	```  

## Dependencies  


## Other available tools  


## References  
[DHCP Diagnostics](https://technet.microsoft.com/en-us/library/dn800671(v=ws.11).aspx)  
[DHCP Operational Events](https://technet.microsoft.com/en-us/library/dn800668(v=ws.11).aspx)  
[Get-Content Commandlet (usefull parsing csv files)](https://technet.microsoft.com/en-us/library/ee176843.aspx)  

## Revision History  
