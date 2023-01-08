## Task Stop data exfiltration  


## Conditions  
* Given a network with sensitive data  
* Harden host nodes against data exfiltration  


## Standards  


## End State  
Prevention or mitigation on the exfiltration of information from a network is accomplished when the following conditions are met:  
* Prevention of information from being transfered/burned to CD/DVD.  
* Prevention of information from being transfered to Removable or Additional Storage drives.  
* Education on Social Engineering and Phishing Attacks that lead to data exfiltration.  
* Minimize size of data allowed to be e-mailed.  
* Minimize size of data allowed to be sent out of the network.  


## Notes  
The methods described in this document help prevent data exfiltration on a host machine by a user. There are other methods that are network-centric but turns complicated quickly. Some considerations for a network-centric implementation include: FTP ports, SFTP ports, SCP ports, Email attachments, access to cloud storage, etc… This can become quite the rabbit hole and requires deep understanding and strong requirements gathering before implementation.  


## Manual Steps  
* Disable USB ports  
	* In the Windows environment, there are two places to prevent the use of USB ports  
	* Disable the installation of USB storage devices on the computer  
		* Start Windows Explorer, and then locate the %SystemRoot%\Inf folder.  
		* Right-click the Usbstor.pnf file, and then click Properties.  
		* Click the Security tab.  
		* In the Group or user names list, add the user or group that you want to set Deny permissions for.  
		* In the Permissions for UserName or GroupName list, click to select the Deny check box next to Full Control. Note * Also add the System account to the Deny list.  
		* In the Group or user names list, select the SYSTEM account.  
		* In the Permissions for UserName or GroupName list, click to select the Deny check box next to Full Control, and then click OK.  
		* Right-click the Usbstor.inf file, and then click Properties. ix. Click the Security tab.  
		* In the Group or user names list, add the user or group that you want to set Deny permissions for.  
		* In the Permissions for UserName or GroupName list, click to select the Deny check box next to Full Control.  
		* In the Group or user names list, select the SYSTEM account.  
		* In the Permissions for UserName or GroupName list, click to select the Deny check box next to Full Control, and then click OK.  
	* Disable the use of USB devices through the registry  
		* Click Start, and then click Run.  
		* In the Open box, type regedit, and then click OK.  
		* Locate and then click the following registry key: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UsbStor  
		* In the details pane, double-click Start.  
		* In the Value data box, type 4, click Hexadecimal (if it is not already selected), and then click OK.  
		* Exit Registry Editor.  
* Disable CD/DVD drive burning  
	* In the Windows environment, there are two places to prevent the use of CD/DVD devices for burning  
	* Implement a Group Policy   
		* Open the “all users”, “specific users or groups”, or “all users except administrators” Local Group Policy Editor for how you want this policy applied.  
		* In the left pane navigate through the tree to: User Configuration > Administrative Templates > Windows Components > Windows Explorer (Windows 7) or File Explorer (Windows 8 and newer)   
		* In the right pane, double click/tap on Remove CD Burning features to edit it  
		* Select the dot to enable this feature  
		* Click OK  
		* Close the Local Group Policy Editor  
	* Disable through Registry  
		* Open Regedit  
		* Navigate to HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer  
		* Modify/create the dword “NoCDBurning” and set it to 00000001  
		* Exit Regedit  
* Employee training  
	* Develop a training that covers the following  
		* How to identify sensitive material  
		* Define the risk of releasing sensitive material  
		* Describe known sensitive material  
	* Distribute the training material  
    
    
## Running Script  
The following scripts disable the functionality of USB ports for data exfiltration on user machines:  

* WINDOWS 10 - PowerShell:  
	```powershell
	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\USBSTOR\" -Name "start" -Value 4
	```  


* MAC OS X - Terminal:  
	* Disable:  
		```bash
		sudo kextunload /System/Library/Extensions/IOUSBMassStorageClass.kext
		```  
    

	* Enable:  
		```bash
		sudo kextload /System/Library/Extensions/IOUSBMassStorageClass.kext
		```  


## Dependencies  


## Other available tools  


## References  
[Windows Disable USB Storage Devices](https://support.microsoft.com/en-us/help/823732/how-can-i-prevent-users-from-connecting-to-a-usb-storage-device)  
[Windows Disable burning DVD/CD](https://www.sevenforums.com/tutorials/5942-burning-cd-dvd-enable-disable.html)  


## Revision History  
