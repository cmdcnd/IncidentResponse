## Task DNS Host Name Mapping  


## Conditions  
Given a responder’s computer, a known network topology including IP address ranges, and the proper tools to map network hosts.  


## Standards  
* Team member selects an appropriate tool for conducting host scans of the network  
* Team member configures the tool to do a full or partial (i.e., per subnet) scan of the network and saves the results to a text or comma-separated values (CSV) file  


## End State  
* A list of all accessible computers within the given IP ranges are listed with their domain name and IP addresses  
* These scripts are meant to be an Out-Of-the-Box (OOB) solution to Cybersecurity Operations  
* All scripts are open source and can be branched/edited as needed  


## Manual Steps  
There are multiple tools available to scan network IP ranges and determine their host names. While a simple ping scan using the built-in Ping tool in Windows will work, the difficulty is that some Operating Systems (OS) block ICMP pings by default. Additionally network administrators may institute a firewall policy to block ICMP across the Enterprise. In those cases a simple ping sweep will not work. In this case, other 3rd-party tools will be more effective, Nmap being one of the most effective.  

* Example Host Discovery scan with Nmap:  On a network with working DNS server, this scan will return all live hosts on this network. For network hosts that do not synch with the local DHCP or DNS server this scan may not return the host name.  
  ```bash
  nmap -sn 192.168.1.0/24  
  ```  

If the above scan does not return hostnames (poorly configured DNS issues), then the following script can be run to further enumerate Windows hosts and possible return the hostname:  
```bash
nmap -sU –script nbstsat.nse -p137 192.168.1.0/24  
```  

Output should be in the format identified in 'output_format_template.csv' and named [mm/dd/yyyy_hh:mm:ss_DNS_HOSTNAME_Mapping_(xx.xx.xx.xx/x)]  

Notify mission element lead and intelligence analyst of completion of this Task  


## Running Script  
* Runs the script as Admin for full capabilities  
* Script execution is menu driven  
* Ensure the script is executable  
  * Linux: `chmod 755 dns_hostname_mapping.py`  
  * Windows: Right-click script file, Properties/Unblock  
* Execute the script: `python dns_hostname_mapping.py`  
* Execute the script using Python3.6+: `python3 dns_hostname_mapping_py3.py`  
* Select a menu option  
* Specify the IP address range to be scanned  
* Specify the path and filename for output files  


## Dependencies  
[Python 3.6+](https://www.python.org/downloads/)  
[Nmap](https://nmap.org/)  


## Other available tools  


## References  
[NMAP Discovery](https://nmap.org/docs/discovery.pdf)  
[NMAP Host Discovery](https://nmap.org/book/man-host-discovery.html)  
[NMAP NBTSTAT](https://nmap.org/nsedoc/scripts/nbstat.html)  


## Revision History  
