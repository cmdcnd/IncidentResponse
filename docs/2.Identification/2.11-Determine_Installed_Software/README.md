## Task  ID.AM-3.1 Determine Installed Software  


## Conditions  
Given a responder’s computer, a network host (workstation or server), and proper access credentials  

## Standards  
* Team member verifies access to the network host  
* Team member selects a method of listing installed applications on the network host and a storage location for the output file  
* Team member runs the necessary script and verifies the data collected with the system owner upon
completion  


## End State  
The list of installed software for the selected host has been collected and validated as correct by the system owner  


## Manual Steps  
* PowerShell: as Administrator - (Local computer -  Run both commands to get both 32- and 64-bit installed software output to a file)  
	```powershell
	Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName,DisplayVersion, Publisher, InstallDate | Format-Table -AutoSize > C:\software.txt  
	```  

	```  
	Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table -AutoSize >> C:\software.txt  
	```  

* PowerShell: as Administrator (Remote computer - Run both commands to get both 32- and 64-bit installed software output to a file)  
	```powershell
	Invoke-command -cn <computername> -Scriptblock {Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table -AutoSize} > C:\software.txt  
	```  

	```powershell
	Invoke-command -cn <computername> -Scriptblock {Get-ItemProperty HKLM:\Software\\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table -AutoSize} >> C:\software.txt  
	```  

* WMIC: as Administrator (Run with cmd, used for localhost)  
	```bat
	wmic /output:"C:\software.txt" product get name,version /format:"C:\Windows\System32\wbem\en-us\csv"  
	```  

	```bat
	wmic /output:"C:\%Computername%_software.txt" product get name,version /format:"C:\Windows\System32\wbem\en-us\csv"  
	```  

* WMIC: as Administrator (Run with cmd. Use for remote computers)  
	```bat
	wmic /node:"computername" product get name,version /format:csv > c:\ software.txt  
	```  
  
* PSInfo (Sysinternals) run command from the directory where PSInfo is installed/located  
	```bat
	psinfo \\computername -u username -p password -s > c:\software.txt  
	```  

Output should be in the format identified in `output_format_template.csv` and named [mm/dd/yyyy_hh:mm:ss_Installed_Software_(computer name)]  

Notify mission element lead and intelligence analyst of completion of this battle drill  


## Running Script  
* Download script from ./script/determine_installed_software.ps1  

* Run script  
	```powershell
	./determine_installed_software.ps1  
	```  

* Select method of emumeration (1 - 4)  
  * for all input full pathname is required (i.e. C:\textfile.txt)  
	
* Retrieve output file  


## Dependencies  
* Download PStools for option 4  


## References  
[PowerShell find installed software](https://blogs.technet.microsoft.com/heyscriptingguy/2013/11/15/use-powershell-to-find-installed-software/)  
[PowerShell list installed programs](http://adriank.org/list-addremove-programs-on-a-remote-machine/)  
[Sysinternals Psinfo](https://technet.microsoft.com/en-us/sysinternals/psinfo.aspx)  


## Revision History  
