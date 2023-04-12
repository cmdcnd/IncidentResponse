## Security Onion Hunting  
The purpose of this task is to document the procedures for threat hunting in Security Onion.  The task includes Sysmon examples and queries used to find the events.  

## Conditions  
* Security Onion: The system must be installed and setup to receive log forwarding from the Wazuh agent on endpoints  
* Clients: 
	* Sysmon installed using the ionstorm config file  
	* Wazuh agent installed and forwarding, inscluding sysmon logs to Security Onion  


## Standards  
These first examples are events from Sysmon showing some of the common tactics used by threat actors.  The events have been generated using MetaSploit and  CobaltStrike  

### Lateral Movement  
A common tactic for lateral movement is to push an executable to a remote system and start a service, similar to how psexec.exe works  
* Metasploit lateral movement using a service to initiate callback  
	```
	Registry value set:
	RuleName: MitreRef=T1060,Technique=Registry Autorun Keys,Tactic=Persistence
	EventType: SetValue
	UtcTime: 2021-06-12 03:49:29.470
	ProcessGuid: {298db6a9-2c67-60c4-eeb3-000000000000}
	ProcessId: 620
	Image: C:\Windows\system32\services.exe
	TargetObject: HKLM\System\CurrentControlSet\Services\DpRHdvsE\Start
	Details: DWORD (0x00000003)
	```

* Metasploit lateral movement using a service to initiate callback, second event  
	```
	Registry value set:
	RuleName: MitreRef=T1060,Technique=Registry Autorun Keys,Tactic=Persistence
	EventType: SetValue
	UtcTime: 2021-06-12 03:49:29.470
	ProcessGuid: {298db6a9-2c67-60c4-eeb3-000000000000}
	ProcessId: 620
	Image: C:\Windows\system32\services.exe
	TargetObject: HKLM\System\CurrentControlSet\Services\DpRHdvsE\ImagePath
	Details: %%COMSPEC%% /b /c start /b /min powershell.exe -nop -w hidden -noni -c "if([IntPtr]::Size -eq 4){$b='powershell.exe'}else{$b=$env:windir+'\syswow64\WindowsPowerShell\v1.0\powershell.exe'};$s=New-Object System.Diagnostics.ProcessStartInfo;$s.FileName=$b;$s.Arguments='-noni -nop -w hidden -c &([scriptblock]::create((New-Object System.IO.StreamReader(New-Object System.IO.Compression.GzipStream((New-Object System.IO.MemoryStream(,[System.Convert]::FromBase64String(''H4sIAMguxGACA7shortentedforreadability''))),[System.IO.Compression.CompressionMode]::Decompress))).ReadToEnd()))';$s.UseShellExecute=$false;$s.RedirectStandardOutput=$true;$s.WindowStyle='Hidden';$s.CreateNoWindow=$true;$p=[System.Diagnostics.Process]::Start($s);"
	```  

Process create is a useful event to look for.  It is common for an infected to host to create additional processes when performing other tasks such as, credential dumping or lateral movement  

* Process create event  
	```
	Process Create:
	RuleName: technique_id=T1086,technique_name=PowerShell
	UtcTime: 2018-09-01 02:26:12.384
	ProcessGuid: {79579f2b-f8c4-5b89-0000-0010a8e24300}
	ProcessId: 5568
	Image: C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
	FileVersion: 10.0.14393.0 (rs1_release.160715-1616)
	Description: Windows PowerShell
	Product: Microsoft® Windows® Operating System
	Company: Microsoft Corporation
	CommandLine: powershell.exe  -nop -w hidden -encodedcommand JABzAD0ATgBlAHcALQBPAGIAagBlAGMAdAAgAEkAT
	CurrentDirectory: C:\Windows\system32\
	User: computer\user
	LogonGuid: {79579f2b-f60c-5b89-0000-0020415e0600}
	LogonId: 0x65E41
	TerminalSessionId: 1
	IntegrityLevel: High
	Hashes: SHA1=044A0CF1F6BC478A7172BF207EEF1E201A18BA02,MD5=097CE5761C89434367598B34FE32893B,SHA256=BA4038FD20E474C047BE8AAD5BFACDB1BFC1DDBE12F803F473B7918D8D819436,IMPHASH=CAEE994F79D85E47C06E5FA9CDEAE453
	ParentProcessGuid: {79579f2b-f737-5b89-0000-0010a2d22200}
	ParentProcessId: 2764
	ParentImage: C:\Windows\System32\cmd.exe
	ParentCommandLine: "C:\Windows\system32\cmd.exe"
	```  

* Process create event for lateral movement  
	```
	Process Create:
	RuleName: -
	UtcTime: 2021-06-24 02:44:23.786
	ProcessGuid: {f3da3d38-f187-60d3-b099-6a1600000000}
	ProcessId: 7072
	Image: C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
	FileVersion: 10.0.14393.206 (rs1_release.160915-0644)
	Description: Windows PowerShell
	Product: Microsoft® Windows® Operating System
	Company: Microsoft Corporation
	OriginalFileName: PowerShell.EXE
	CommandLine: powershell.exe -nop -w hidden -enc SQBFAFgAIAAoACgAbgBlAHcALQBvA==
	CurrentDirectory: C:\WINDOWS\system32\
	User: computer\user
	LogonGuid: {f3da3d38-f187-60d3-e798-6a1600000000}
	LogonId: 0x166A98E7
	TerminalSessionId: 0
	IntegrityLevel: High
	Hashes: MD5=097CE5761C89434367598B34FE32893B,SHA256=BA4038FD20E474C047BE8AAD5BFACDB1BFC1DDBE12F803F473B7918D8D819436,IMPHASH=CAEE994F79D85E47C06E5FA9CDEAE453
	ParentProcessGuid: {f3da3d38-d166-60cb-4b31-020000000000}
	ParentProcessId: 2868
	ParentImage: C:\Windows\System32\wbem\WmiPrvSE.exe
	ParentCommandLine: C:\WINDOWS\system32\wbem\wmiprvse.exe -secured -Embedding
	```  

Malware almost always has to connect back to a C2 system for follow on instructions and to maintain persistance  

* Network event.  This is an example of powershell used as the initial infection making a call back.  Not a great example, since it was done locally in vmware  
	```
	Network connection detected:
	RuleName: technique_id=T1218,technique_name=Signed Binary Proxy Execution
	UtcTime: 2018-09-01 02:26:19.331
	ProcessGuid: {79579f2b-f8c7-5b89-0000-0010f4864400}
	ProcessId: 5552
	Image: C:\Windows\SysWOW64\WindowsPowerShell\v1.0\powershell.exe
	User: computer\user
	Protocol: tcp
	Initiated: true
	SourceIsIpv6: false
	SourceIp: 192.168.1.130
	SourceHostname: computer
	SourcePort: 1907
	SourcePortName: 
	DestinationIsIpv6: false
	DestinationIp: 192.168.1.143
	DestinationHostname: 
	DestinationPort: 443
	DestinationPortName: https
	```  

* mimikatz grabbing credentials from current logged on users
	```
	Process accessed:
	RuleName: technique_id=T1003,technique_name=Credential Dumping
	UtcTime: 2018-09-01 02:40:12.833
	SourceProcessGUID: {79579f2b-fc0c-5b89-0000-001097eb6f00}
	SourceProcessId: 5212
	SourceThreadId: 6996
	SourceImage: C:\Windows\System32\rundll32.exe
	TargetProcessGUID: {79579f2b-f5fa-5b89-0000-00105a9c0000}
	TargetProcessId: 604
	TargetImage: C:\Windows\system32\lsass.exe
	GrantedAccess: 0x1010
	CallTrace: C:\Windows\SYSTEM32\ntdll.dll+a6574|C:\Windows\System32\KERNELBASE.dll+20edd|UNKNOWN(000001C7A2AA710D)
	```  

* mimikatz grabbing hashes from the local accounts  
	```
	Process accessed:
	RuleName: technique_id=T1003,technique_name=Credential Dumping
	UtcTime: 2018-09-01 02:45:26.030
	SourceProcessGUID: {79579f2b-fd45-5b89-0000-0010c5657300}
	SourceProcessId: 6420
	SourceThreadId: 4172
	SourceImage: C:\Windows\System32\rundll32.exe
	TargetProcessGUID: {79579f2b-f5fa-5b89-0000-00105a9c0000}
	TargetProcessId: 604
	TargetImage: C:\Windows\system32\lsass.exe
	GrantedAccess: 0x1FFFFF
	CallTrace: C:\Windows\SYSTEM32\ntdll.dll+a6574|C:\Windows\System32\KERNELBASE.dll+20edd|UNKNOWN(0000022B28BB1D25)
	```  

* PROCESS INJECTION  
	```
	Registry object added or deleted:
	CreateRemoteThread detected:
	RuleName: -
	UtcTime: 2021-06-24 03:10:58.927
	SourceProcessGuid: {f3da3d38-f187-60d3-b099-6a1600000000}
	SourceProcessId: 7072
	SourceImage: C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
	TargetProcessGuid: {f3da3d38-d163-60cb-f2d1-010000000000}
	TargetProcessId: 1316
	TargetImage: C:\Program Files\VMware\VMware Tools\vmtoolsd.exe
	NewThreadId: 4032
	StartAddress: 0x000001A4BC400000
	StartModule: -
	StartFunction: -
	```  
### Security Onion Hunt  
The next section will provide some basic queries that can be used in Security Onion Hunt  
----------------------------------------------------------------------------------------  

* Filter for all sysmon events  
	```
	AND event.module:"sysmon" | groupby event.module event.dataset
	```  

* Filter for create remote thread type events  
	```
	AND event.module: "sysmon" AND event.dataset:"create_remote_thread" | groupby event.module event.dataset
	```  

* Filter for network events  
	```
	AND event.module: "sysmon" AND event.dataset: "network_connection" | groupby event.module event.dataset
	```  

* Filtering for specifc systems  
	```
	AND event.module: "sysmon" AND agent.ip:"x.x.x.x" | groupby event.module event.dataset
	```  

### Security Onion Elastic  
The next section will provide some basic queries that can be used in Security Onion Elastic  
----------------------------------------------------------------------------------------  

* Credential dumping  
Note: You are looking for processes that do not normally touch lsass.exe  
	```
	event.module: "sysmon" AND event.dataset:"create_remote_thread" AND message:"*lsass.exe"
	```  

	```
	event.module: "sysmon" AND event.dataset:"create_remote_thread" AND winlog.event_data.targetImage:"*lsass.exe"
	```  

* Lateral movement  
	```
	event.module: "sysmon" AND event.dataset:"registry_value_set" AND winlog.event_data.targetObject:"*Start"
	```  

	```
	event.module: "sysmon" AND process.parent.executable:"WmiPrvSE.exe"
	```  

* Process injection  
Note: add following fields on the left: winlog.event_data.sourceImage and winlog.event_data.targetImage and look for sourceimages like powershell|rundll32  
	```
	event.module: "sysmon" AND event.dataset:"create_remote_thread"
	```  

	```
	(event.module:"sysmon" AND event.dataset:"create_remote_thread" AND winlog.event_data.sourceImage:"powershell.exe") OR (event.module:"sysmon" AND event.dataset:"create_remote_thread" AND winlog.event_data.sourceImage:"rundll32.exe" )
	```  

* Network Events  
* Network SMB executable file transfer  
	```
	rule.name: "ET POLICY SMB Executable File Transfer"
	```  

	```
	event.dataset.keyword: smb_files
	```  

	```
	file.name.keyword: *.exe
	```  

* Remote Service Control Request  
	```
	rule.name: "ET RPC DCERPC SVCCTL - Remote Service Control Manager Access"
	```  

	```
	dce_rpc.operation.keyword: OpenSCManagerA
	```  

* Lateral movement using NTLM (pass-the-hash)  
	```
	event.dataset.keyword: ntlm
	```  

* Lateral movement using WinRM  
	```
	rule.name: "ET POLICY WinRM wsman Access - Possible Lateral Movement"
	```  

	```
	rule.metadata.tag.keyword: WinRM
	```  

	```
	rule.name.keyword: "ET USER_AGENTS WinRM User Agent Detected - Possible Lateral Movement"
	```  

* CobaltStrike C2 communication (not sure how accurate this is, but it returned C2 communication)  
	```
	server.packets >8 AND server.packets <12
	```  

* Finding executable files
	```
	file.mime_type.keyword: application/x-dosexec
	```  

* DNS Queries
	```
	dns.query.name.keyword:* AND dns.query.type_name.keyword: A (This will find all DNS A records, not very usefull but a syntax example)
	```


## End State  
Provide examples of threat hunting in Security onion  


## Notes  
N/A  


## Manual Steps  
N/A  

 
## Running Script
N/A  


## Dependencies  
N/A  


## Other available tools  
N/A  


## References  
[Windows Event Log Examples](https://github.com/sbousseaden/EVTX-ATTACK-SAMPLES)  
[SIGMA Rules Examples](https://github.com/SigmaHQ/sigma/tree/master/rules/windows)  
[RUNDLL32 Connection to the Internet](https://www.cobaltstrike.com/blog/why-is-rundll32-exe-connecting-to-the-internet/)  
[Quick Malware Analysis with Security Onion](https://www.youtube.com/watch?v=KBjr1fdb3jY)  
[Quick Malware Analysis: malware-traffic-analysis.net pcap from 2021-06-18](https://blog.securityonion.net/2021/07/quick-malware-analysis-malware-traffic.html)  


## Revision History  

