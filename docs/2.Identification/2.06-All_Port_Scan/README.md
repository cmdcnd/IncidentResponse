## TAsk All port scan  
2.04 – Active_Host_and_Service_Enumeration  
2.01 – Create a list of active IP addresses  
2.05 – Create a list of active IP addresses with key ports included  
2.07 – Scan ICS Equipment Ports  
2.06 – Scan all ports of all hosts on given network segment  


## Conditions  
Given a suspected compromised network segment(s), access to a system that can access and scan the identified network segment(s), and network scanning software included in the team’s incident response kit.  


## Standards  
* The team member identifies possibly compromised network segment(s).  
* The team member accesses a system that can scan the identified network segment(s).  
* The team member utilizes an IP-based network scanning utility to perform one of the following scanning tasksand directs the output to a text file for analysis:  
	* 2.04 – Active_Host_and_Service_Enumeration  
	* 2.01 – Create a list of active IP addresses  
	* 2.05 – Create a list of active IP addresses with key ports included  
	* 2.07 – Scan ICS Equipment Ports  
	* 2.06 – Scan all ports of all hosts on given network segment  
* The resulting scan data is compared to known network host data to determine anomalies present in the scanned network segment.  


## End State  
All active hosts, ports and services are carefully enumerated based on the specific sub-task accomplished and any anomalies or mis-configurations are identified.  


## Manual Steps
A list of IP ranges can be provided by using the `-f IPRanges` option; otherwise, a range can be specified with `-i IPRange`. For each BD, the script will need to be ran.  
The script will need to be marked executable before running:  

* Make the script executable  
	```bash
	chmod +x NmapScript.sh  
	```  

* For Task 2.04, run the NmapScript.sh and choose menu 1  
	```  
	1. 2.04 – Active_Host_and_Service_Enumeration  
	2. 2.01 – Create a list of active IP addresses  
	3. 2.05 – Create a list of active IP addresses with key ports included  
	4. 2.07 – Scan ICS Equipment Ports  
	5. 2.06 – Scan all ports of all hosts on given network segment   
	6. Exit  

	Selection:> 1  
	```  

* A log will be generated to NmapScript.txt and the output will be shown to the user:  
	```  
	Selection:> 1  
	[+] Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-26 13:47 EDT  
	[+] Nmap scan report for 192.168.69.2  
	[+] Host is up (0.00084s latency).  
	[+] Not shown: 999 closed ports  
	[+] PORT   STATE SERVICE VERSION  
	[+] 53/tcp open  domain  dnsmasq 2.55  
	[+] MAC Address: 00:50:56:EB:3D:1D (VMware)  

	[+] Service detection performed. Please report any incorrect results at https://nmap.org/submit/.  
	[+] Nmap done: 256 IP addresses (6 hosts up) scanned in 17.23 seconds  
	```  

* For Task 2.04, run the NmapScript.sh and choose menu 2  
	```  
	Selection:> 2  
	[+] 192.168.69.1 is live!  
	[+] 192.168.69.2 is live!  
	[+] 192.168.69.142 is live!  
	[+] 192.168.69.254 is live!  
	[+] 192.168.69.132 is live!  
	[+] 192.168.69.137 is live!  
	```

* For Task 2.02, run the NmapScript.sh and choose menu 3. It is important to provide key ports interested. If any ports are open on the targets, they will get displayed; otherwise, you will have no output.  
	```  
	Selection:> 3  
	[+] Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-26 13:56 EDT  
	[+] Nmap done: 256 IP addresses (6 hosts up) scanned in 3.41 seconds  
	```  

* For Task 2.07, run the script and choose menu 4. This will scan for ports on ICS equipment. This will warn you if you would like to continue.  
	```  
	Selection:> 4  
	[!] It is possible for Scada devices to fail with an Nmap scan, do you want to continue? Y  
	[+] Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-26 13:59 EDT  
	[+] Nmap done: 256 IP addresses (6 hosts up) scanned in 3.41 seconds  
	```  

* For Task 2.06, run the script and choose menu 5. This will scan for all ports on the target/target list.  
	```  
	Selection:> 5  
	[+] Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-26 14:01 EDT  
	[+] Nmap done: 256 IP addresses (6 hosts up) scanned in 3.41 seconds  
	```  

## Dependencies  
* If NMap is not installed:  
	```  bash
	sudo apt install nmap  
	```  


## Other available tools  
* Angry IP scanner  
* Advanced IP Scanner  
* Solarwinds IP Scanner  


## References  
[NMAP Site](https://nmap.org)  
[LAN Spy](http://lantricks.com/lanspy/)  
[NMAP Man Pages Nmap Man page](http://linuxcommand.org/man_pages/nmap1.html)  
[Nmap Network Scanning –online book](http://nmap.org/book/toc.html)  


## Revision History  
