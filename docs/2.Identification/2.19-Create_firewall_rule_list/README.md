## Task Create Firewall Rule List  


## Conditions  
Given access to suspected compromised hosts, and appropriate credentials.  


## Standards  
* The team member establishes a start point baseline of local firewall rules.  
* The team member periodically reruns the local rules check and compares to established baseline.  
* The team member reviews established baseline to identify possible security gaps and/or misconfigurations.  

## End State  
Local firewall rules baseline is established, periodically checked against, and audited for security gaps/misconfigurations.  


## Manual Steps  
* Show all rules:  
	```bat
	netsh advfirewall firewall show rule name=all
	```  

* Setfirewall on/off:  
	```bat
	netsh advfirewall set currentprofile state on
	netsh advfirewall set currentprofile firewallpolicy blockinboundalways,allowoutbound
	netsh advfirewall set publicprofile state on
	netsh advfirewall set privateprofile stateon
	netsh advfirewall set domainprofile state on
	netsh advfirewall set allprofile state on
	netsh advfirewall set allprofile state off
	```  

ENSURE CHANGES HAVE BEEN APPROVED BY COMMAND BEFORE CONTINUING  

* Set firewall rules examples:  
	```bat
	netsh advfirewall firewall add rule name="Open Port 80" dir=in action=allow protocol=TCP localport=80
	netsh advfirewall firewall add rule name="My Application" dir=in action=allow program="C:\MyApp\MyApp.exe" enable=yes
	netsh advfirewall firewall add rule name="My Application" dir=in action=allow program="C:\MyApp\MyApp.exe" enable=yes remoteip=157.60.0.1,172.16.0.0/16,LocalSubnet profile=domain
	netsh advfirewall firewall add rule name="My Application" dir=in action=allow program="C:\MyApp\MyApp.exe" enable=yes remoteip=157.60.0.1,172.16.0.0/16,LocalSubnet profile=domain
	netsh advfirewall firewall add rule name="My Application" dir=in action=allow program="C:\MyApp\MyApp.exe" enable=yes remoteip=157.60.0.1,172.16.0.0/16,LocalSubnet profile=private
	netsh advfirewall firewall delete rule name=rule name program="C:\MyApp\MyApp.exe"
	netsh advfirewall firewall delete rule name=rule name protocol=udp localport=500
	netsh advfirewall firewall set rule group="remote desktop" new enable=Yes profile=domain
	netsh advfirewall firewall set rule group="remote desktop" new enable=No profile=publicSetup logging location:
	netsh advfirewall set currentprofile logging C:\<LOCATION>\<FILE NAME>
	```  

* Windows firewall log location and settings:  
	```bat
	more %systemroot%\system32\LogFiles\Firewall\pfirewall.log
	netsh advfirewall set allprofile logging maxfilesize 4096
	netsh advfirewall set allprofile logging droppedconnections enable
	netsh advfirewall set allprofile logging allowedconnections enable
	```  

* Get full list of firewall cmdlets in PowerShell:  
	```powershell  
	Get-Command *-*firewall*
	```  


## Running Script  
* Transfer powershell script to target host.  
* Navigate to containing folder and run `2.19_CreateFirewallRuleList.ps1`  


## Dependencies  
* Windows
* Powershell  


## Other available tools  
N/A


## References  
[PowerShell NetSecurity](https://technet.microsoft.com/en-us/library/jj554906(v=wps.630).aspx)  


## Revision History  
