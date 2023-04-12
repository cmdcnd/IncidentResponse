## Task Create Hard Disk Image  


## Conditions  
Given a Windows or Linux machine, hard drive acquisition tools, and a network device with one or more indicators of compromise (IOC).  


## Standards  
The team member connects to and creates an image from a remote machine using Linux or Windows. (the team member can choose how to create the image from the given tools so long as he/she can provide a log file with a good hash that can be verified against the created image.)  
* Windows  
	```
	dc3dd.exe if=\\.\c: of=d:\<ATTACHED OR TARGET DRIVE>\<IMAGE NAME>.dd hash=md5 log=d:\<MOUNTED LOCATION>\<LOG NAME>.log
	```  

* Linux  
	```
	dd if=/dev/<INPUT DEVICE> | SSH <USER NAME>@<DESTINATION IP ADDRESS> "DD OF=<DESTINATION PATH>"
	```  

* The team member then verifies that a log file with a hash was created by checking the chosen log file directory.  


## End State  
A raw physical image of a remote machine is created and ready for analysis.  


## Notes  
Imaging can be done on a live or dead system using a myriad of tools. Software and hardware tools can be used and are chosen based on available equipment and time constraints. The key portion of this task is the creation of a log file with a good hash to allow for integrity checks and chain of custody. Some tools will perform a hash verification check, and when these tools are used, this should be done if time allows.  
* Tools  
  * Dc3dd.exe used to create images from linux or windows devices. Dc3dd will create a log and hash if the correct command is given.  
  * dd – linux command that will create an image from a physical device. dd will create a log and hash if the correct command is given  
  * ftk imager – windows program for imaging devices. Ftk imager is a GUI interface that allows for a myriad of options for evidence file formats including E01, dd, raw, etc.  
  * Guymager – Guymager is a linux tool that can be used to create disk images. Guymager is an extremely fast option for imaging and is pre-installed in many linux flavors.  

## Manual Steps  


## Running Script  


## Dependencies  


## Other available tools  


## References  
[Sourceforge DC3DD](https://sourceforge.net/projects/dc3dd/files/dc3dd/7.2%20-%20Windows/)  
[FTX Imager](https://accessdata.com/product-download/ftk-imager-version-3.4.3)  
[Guymager forensic image](http://guymager.sourceforge.net)  


## Revision History  
