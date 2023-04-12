## Task Find and contain rogue workstations  


## Conditions  
Given a suspected compromised system, local administrator account credentials, analysis tools, and one or more Indicators of Compromise (IOC).  


## Standards  
* Rogue access indicators of compromise are identified or alerted.  
* The team member analyzes network to identify any rogue workstations.  
* The rogue workstation(s) are contained.  

## End State  
Rogue workstations are identified and contained.  


## Notes  


## Manual Steps  
Detect - Indicators of Compromise  
* Rogue/Unauthorized Access Points  
  * Internal rogue devices such as a user brings in an unauthorized access point that serves as a gateway to the internal network.  
  * External rogue access points used by an attacker spoofing the legitimate users. The attacker may steal authentication attributes to gain access to the internal network.  
  * Detection: Review of any new access points to be compared to a known authorized list. Run Active Directory Script (Below). Review any new workstations detected on the domain. Compare to authorized workstation list.  
  * Containment: Block/Remove any unauthorized access points. Disable/Remove device from network/domain.  
* Rogue Workstations  
  * Deploy/Hunt to perform quick logical Rogue Workstation validation/enumeration  
* Ping, trace route and NMAP Rogue Host (within same subnet if possible)  
* Nessus scan if required/authorized  


## Running Script  
Nmap Commands  
* list scan  
	```bash
	nmap -sL <IP Address/Subnet>
	```  

* Ping scan
	```bash
	nmap -sn <IP Address/Subnet>
	```  

* Ping scan, no ports  
	```bash
	nmap -sn <IP Address/Subnet>
	```  

* ARP scan
	```bash
	nmap -PR <IP Address/Subnet>
	```  

* No ping scan
	```bash
	nmap -Pn <IP Address/Subnet>
	```  


* Nessus  
Follow Host Discovery process/procedures using the most current version of Nessus.
Containment  
* Switch Port  
  * Turn off switch port to rogue host  
  * Dispatch Security to investigate  
* Access Layer Switch ACL  
  * Apply Switch ACLs to drop all traffic from host  
  * Dispatch Security to investigate  
* Boundary Firewall / GPO  
  * Apply ACLs to drop all traffic at nearest firewall  
  * Apply GPO firewall rule on all hosts in OU to drop all traffic from host  
  * Dispatch Security to investigate  
* Add MAC to DHCP deny list (DHCP Manager -> IPv4 -> Filters –> Deny)  

## Dependencies  


## Other available tools  


## References  
[NMAP Discovery](https://nmap.org/book/man-host-discovery.html)  
[Wireless Preventing Rogue devices](https://www.sans.org/reading-room/whitepapers/wireless/detecting-preventing-rogue-devices-network-1866)  


## Revision History  
