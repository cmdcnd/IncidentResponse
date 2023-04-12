## Task Perform Manual Host Analysis – Memory Image File  


## Conditions  
Given a memory image from a suspected compromised system, memory analysis tools, and one or more Indicators of Compromise (IOC).  


## Standards  
* The team member copies the memory image to the incident response workstation.  
* The team member performs a file hash of the memory image and validates it against the hash obtained when the image was captured.  
* Utilizing a memory image analysis tool, obtain or check for the following information and compare against known IOCs (not a comprehensive list)  


## End State  
Processes, files, network connections and/or command history that match one or more IOCs are identified.  


## Notes  
Memory analysis can be done on a live system or with an image file of the suspect computers physical memory. Some tools can do both capture and analysis and can be used for this task. The information sought in this task is representative of that which an incident responder might do to further the creation of IOCs and the understanding of the compromise. Deeper inspection and analysis of the memory image is likely to be done by the forensics team.  
* Tools: There are various several tools that can be used to analyze a memory image. For example:  
  * Volatility – used to analyze memory image files. Required python to be installed on responder’s computer.  
  * Memoryze – Mandiant tool that can analyze memory files on a responder’s computer or the live memory of a compromised computer from running from an external USB drive.  

## Manual Steps  
The command for Volatility is as follows:  

* Windows  
	```bat
	volatility -f <memory dump location> --profile=<machine profile> <command> > <chosen output location.txt>
	```  

* Linux (using python)  
	```python
	python vol.py -f <memory dump location> --profile<machine profile> <command> > <chosen output location>
	```  


## Running Script


## Dependencies


## Other available tools


## References  
[Stuxnet Trojan Memory Forensics](http://www.behindthefirewalls.com/2013/12/stuxnet-trojan-memory-forensics-with_16.html)  
[Volatility Command Reference](https://github.com/volatilityfoundation/volatility/wiki/Command%20Reference#kdbgscan)  


## Revision History  

