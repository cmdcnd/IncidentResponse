## Task Investigate Alerts from Host Sensors  


## Conditions  
* Given a network with HIDS agents installed on all relevant hosts.  
* Given a fully installed and properly configured SIEM that displays information reported by HIDS agents.  
* Given accounts for all relevant tools and hosts.  
* Given a notification of a host based sensor alert  
* Given prior approval from network owner to begin host based investigation  


## Standards- Network Analyst  
* Recognize alert related to host sensor data, if possible, rule out as false positive  
* Analyze other relevant SIEM data gathered from host ie. network connections to other hosts, suspicious traffic, etc.  
* Notify team leader and hand off report to host analyst team  
* Continue monitoring and report additional relevant data as it becomes available  

## Standards- Host Analyst  
* Determine Operating System, Windows, Linux, MacOS, etc.  
* Log onto system with authorized administrative credentials  
* Utilize native OS tools to confirm alert data, ie. network connections, open ports, active/startup processes, etc. (Windows- 'NetStat' 'TaskManager' 'arp'; Linux- 'ps -aux' 'top' 'htop' 'netstat' 'arp'; MacOS- 'top' 'ps' 'activity monitor' 'network utility')  
* If available, utilize third party tools to discover parent or child processes associated with alert. (Windows- SysInternals, 'ProcMon' 'ProcessExplorer') 'TCPview'; Linux-  
* Determine any potentially compromised account information: (Windows- powershell 'get-localuser, get-aduser'; Linux- 'cat /etc/passwd'; MacOS- 'cat /etc/passwd')  
* Determine source of IOC and any potential lateral movement conducted post compromise using (Windows- EventViewer)  
* Gather sufficient data to send a detailed report of the IOC  
* Send detailed report of IOC via specified channel to team lead or designated person  


## End State  
Host-based alert reporting is actioned and fully investigated  


## Notes  


## Manual Steps  
* Login to the SIEM interface, e.g. Kibana  
* Defenders should be able to see the reporting status of all hosts with agents. The most obvious and immediate problem a host might report is that it isn't reporting anymore.  

## Running Script  
* `4.Eradication/4.08_Deploy_or_evaluate_host_sensors/scripts/Sysmon_Wazuh_push.ps1`  


## Dependencies  
* Sysmon  
* Wazuh  
  * Wazuh configuration file (ossec.conf)  
* Security Onion  
  * Elasticsearch  


## Other available tools  
* Splunk  


## References  
[Security Onion documentation](https://docs.securityonion.net/en/16.04)  
[Elasticsearch documentation](https://www.elastic.co/guide/index.html)  


## Revision History  
