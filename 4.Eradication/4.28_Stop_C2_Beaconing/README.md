## Task Stop C2 Beaconing  


## Conditions  
* Compromised host that is beaconing externally to a potential malicious IP.  
* The compromised host have been compromised by malware (including zero-day) or system configuration vulnerability.  


## Standards  
* An alert, event, or communication has been received indicating external connection attempts.  
* Identify the following:  
	* Source/Destination IP Addresses. Ensure logs/event are being read correctly. It may appear as the connection is coming from external to internal however it is in fact still internal to external. Bro logs/Snort rules may differ from Squil and ELSA events  
	* Ports/Protocols Used - Common  
		* 80/443 – Http/Https  
		* 53 - DNS  
		* 6667 – IRC  
		* 4444 – Metasploit  
		* 20/21 – FTP  
		* 22 – SSH  
		* 23 – Telnet  
		* 50050 - Cobaltstrike  
	* DNS names, if available  
	* Even though there may initially be only one identified alert/event, there may be more than one host beaconing out to more than one malicious IPs/sites. Ensure that thorough review and pivoting is conducted to ensure that all affected hosts are identified. Reasonable anomalies should be investigated.  
	* Malware names, hashes (MD5, SHA-256, etc).  
	* Known system configuration vulnerabilities on affected hosts.  
* Remove recursive DNS queries or remove root hints (if possible - this will prevent any dns lookups other than current domain) a. DNS Manager -> <Server Name> -> properties -> Forwarders b. Remove all recursive IPs c. Create a new recursive IP pointing no nowhere  
* Create primary zone for the domain that is being called  
	* DNS Manager -> <Server Name> -> New Zone  
	* Primary Zone  
	* To all DNS servers running on domain controllers in this domain  
	* Forward lookup zone  
	* Zone name: <name of zone>  
* Remove malware  
* Patch/harden system, if possible  
* Monitor and alert for future C2 beaconing events for any residual C2 characteristics not remediated.  


## End State  
Compromised credentials are disabled and/or changed in all areas. Appropriate hosts are restricted or disabled. Attacker cannot re-use credentials to access any internal network area, hosts, hardware, or software.  


## Notes  
Specific manual steps, specific scripts, and dependencies cannot represent the multitude of ways beacons can communicate or the associated remediation. General actions are to either block the destination (ideally at the border to protect other assets), or remove the beacon itself.  


## Manual Steps  
N/A  


## Running Script  
N/A  


## Dependencies  
N/A  


## Other available tools  


## References  
[SANS C2 Analysis for IR](https://digital-forensics.sans.org/blog/2014/03/31/the-importance-of-command-and-control-analysis-for-incident-response/)  
[Anti-Trojan Ports](http://www.anti-trojan.org/port_opened.html)  


## Revision History  
