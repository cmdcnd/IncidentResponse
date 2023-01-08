### before running the PowerShell script pushing Wazuh and Sysmon modify these files to reflect your security onion or Wazuh manager server.

## Ideally all the files required should be available and packaged into a folder.
## read the comments on the script for additional information and run the script from a PowerShell window instead of ISE since it is referencing the directory the script is ran from. ISE had issues following that.

## Steps

5. Extract into created directory C:\Sysmon.old
6. Modify scripts
	a. Sysmon_Wazuh_push.ps1
		- Line 7 = IP address of Security Onion server
	b.install-sysmon.bat
		- Line 5 WAZUH_MANAGER=“IP of Security Onion server” WAZUH_REGISTRATION_SERVER=“IP of Security Onion server”
	c. Ossec.conf
		- Line 11 <address>IP of Security Onion server</address>
	d.ips.txt 
		- Add all workstation and domain controller IPs within network
7. Run PowerShell as an administrator
8. Run command “Cd C:\Sysmon.old” (no quotes when actually running any command)
9  Run PowerShell script by running the following command: “.\Sysmon_Wazuh_push.ps1”
	a. Press 1 to make Current directory SMB Share, and wait for command to run, if errors received (red text) review script
	b. Press 2 to copy files to the workstations
	c. Press 3 to install Wazuh agents
	d. Press 5 to push modified ossec configuration file
10. On a workstation, log into Security Onion web console and verify syslogs are forwarding from all workstations
	a. In Security Onion Dashboard, under “Event Category”, select “Network”
	b. Under “Datasets” (on left side of page), select “Syslog”, if you are receiving syslogs, you will see the IP addresses of the workstations that are reporting to Security Onion under “Source IPs” on the left side of the screen
