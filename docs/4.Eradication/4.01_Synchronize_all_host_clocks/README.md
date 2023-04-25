## Synchronize all host clocks  


## Conditions  
Given a known network configuration, an NTP data source(s), and system owner preferences on time synchronization within their enclave  


## Standards  
* Identify or stand up Network Time Protocol (NTP) server.  
* Ensure NTP server is set to synchronize from a known good time source (ex: time.nist.gov).  
* Configure all non-Windows systems to synchronize from the local NTP server.  
* Configure all Windows systems which are not members of a domain to synchronize from the local NTP server.  
* Configure Windows primary domain controller to synchronize from the local NTP server and configure GPO settings for domain.  


## End State  
All host clocks in the environment are synchronized from a known good time source, enabling operations and accurate forensic log analysis.  


## Notes  
Windows domain member systems will automatically synchronize their time based on the primary domain controller (PDC).  Best Practices for NTP configuration include filtering the NTP protocol at the firewall and blocking outbound NTP (to prevent being used in a Distributed Denial-of-Service (DDOS) attack).  


## Manual Steps  
### Windows  
* Check NTP Status:  
	```bat
	w32tm /query /status
	```  

* Check NTP Configuration:  
	```bat
	w32tm /query /configuration
	```  

* Start NTP Windows:  
	```bat
	net start w32time
	```  

* Check NTP sever settings in registry:  
	```bat
	reg QUERY HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Parameters
	```  

* Check NTP settings in registry:  
	```bat
	reg QUERY HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Config
	w32tm /dumpreg
	```  

* Get Date and Time:
	```powershell
	Get-Date -F o
	```  

* Set NTP Server:  
	```bat
	w32tm /config /manualpeerlist:time.nist.gov /syncfromflags:manual /reliable:yes /update
	```  

* Restore NTP settings back to default:  
	```bat
	net stop w32time
	w32tm /unregister
	w32tm /unregister (Yes run twice)
	w32tm /register
	net start w32time
	```  

### Linux  
* Check synchronized clock status:  
	```bash
	systemctl status systemd-timesyncd.service
	```  

* Check NTP Status:  
	```bash
	timedatectl status
	```  

* Configure NTP Server selection options:  
	```bash
	/etc/systemd/timesyncd.conf
	```  

* Current NTP settings:  
	```bash
	cat /etc/ntp.conf
	```  

* Restart NTP service after configuration changes:  
	```bash
	/etc/init.d/ntp restart
	```  

* Check NTP synchronized servers:  
	```bash
	ntpq -p
	systemctl status systemd-timesyncd.service
	```  

* Check NTP Status:  
	```bash
	timedatectl status
	```

* Configure NTP Server selection options:  
	```bash
	/etc/systemd/timesyncd.conf
	```  

* Current NTP settings:  
	```bash
	cat /etc/ntp.conf
	```  

* Restart NTP service after configuration changes:  
	```bash
	/etc/init.d/ntp restart
	```  

* Check NTP synchronized servers:  
	```bash
	ntpq -p
	```  


## Running Script  


## Dependencies  


## Other available tools  


## References  
[Good information on implementing NTP](http://Support.ntp.org/bin/view/Support/SelectingOffsiteNTPServers)  
[VMWare info on NTP for Windows Guest operating systems](https://kb.vmware.com/kb/1318)  
[Cisco Best Practices](https://www.cisco.com/c/en/us/support/docs/availability/high-availability/19643-ntpm.html)  


## Revision History  
