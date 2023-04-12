<!--
This is the beginning of your document
* After every line put 2 spaces to tell markdown to put a carriage return
* To create a nested list using the web editor on GitHub or a text editor that uses a monospaced font, like Atom, you can align your list visually. Type tabs in front of your nested list item, until the list marker character (*) lies directly below the first character of the text in the item above it.
-->  

### Get-WinEvent  
View all events in the live system Event Log:  
```powershell
Get-WinEvent -LogName system
```  
View all events in the live security Event Log (requires administrator PowerShell):  
```powershell
Get-WinEvent -LogName security
```  
View all events in the file example.evtx, format list (fl) output:  
```powershell
Get-WinEvent -Path example.evtx | fl
```  
View all events in example.evtx, format GridView output:  
```powershell
Get-WinEvent -Path example.evtx | Out-GridView
```  
Perform long tail analysis of example.evtx:  
```powershell
Get-WinEvent -Path example.evtx | Group-Object id -NoElement | sort count
```  
Pull events 7030 and 7045 from system.evtx:  
```powershell
Get-WinEvent -FilterHashtable @{Path="system.evtx"; ID=7030,7045}
```  
Same as above, but use the live system event log:  
```powershell
Get-WinEvent -FilterHashtable @{logname="system"; id=7030,7045}
```  
Search for events containing the string "USB" in the file system.evtx:  
```powershell
Get-WinEvent -FilterHashtable @{Path="system.evtx"} | Where {$_.Message -like "*USB*"}
```  
'grep'-style search for lines of events containing the case insensitive string "USB" in the file system.evtx:  
```powershell
Get-WinEvent -FilterHashtable @{Path="system.evtx"} | fl | findstr /i USB
```  
Pull all errors (level=2) from application.evtx:  
```powershell
Get-WinEvent -FilterHashtable @{Path="application.evtx"; level=2}
```  
Pull all errors (level=2) from application.evtx and count the number of lines ('wc'-style):  
```powershell
Get-WinEvent -FilterHashtable @{Path="application.evtx"; level=2} | Measure-Object -Line
```  
Export Event Logs to CSV format  
```powershell
# Define the path to the directory where your event log files are stored
$logDirectory = "patch to log files"

# Loop through each event log file in the directory
Get-ChildItem $logDirectory -Filter *.evtx | ForEach-Object {
    $logPath = $_.FullName

    # Define the output path for the CSV file
    $csvPath = "$logDirectory\$($_.BaseName).csv"

    # Export the event log to a CSV file
    Get-WinEvent -Path $logPath | Select-Object * -ExcludeProperty ContainerLog | Export-Csv $csvPath -NoTypeInformation
}
```  

#### AppLocker  
Pull all AppLocker logs from the live AppLocker event log (requires Applocker):  
```powershell
Get-WinEvent -logname "Microsoft-Windows-AppLocker/EXE and DLL"
```  
Search for live AppLocker EXE/MSI block events: "(EXE) was prevented from running":  
```powershell
Get-WinEvent -FilterHashtable @{logname="Microsoft-Windows-Applocker/EXE and DLL"; id=8004}
```  
Search for live AppLocker EXE/MSI audit events: "(EXE) was allowed to run but would have been prevented from running if the AppLocker policy were enforced":  
```powershell
Get-WinEvent -FilterHashtable @{logname="Microsoft-Windows-Applocker/EXE and DLL"; id=8003}
```  

#### EMET  
Pull all EMET logs from the live Application Event log (requires EMET):  
```powershell
Get-WinEvent -FilterHashtable @{logname="application"; providername="EMET"}
 ```  
Pull all EMET logs from a saved Application Event log (requires EMET):  
```powershell
Get-WinEvent -FilterHashtable @{path="application.evtx"; providername="EMET"}
```  

#### Sysmon  
Pull all Sysmon logs from the live Sysmon Event log (requires Sysmon and an admin PowerShell):  
```powershell
Get-WinEvent -LogName "Microsoft-Windows-Sysmon/Operational"
```  
Pull Sysmon event ID 1 from the live Sysmon Event log  
```powershell
Get-WinEvent -FilterHashtable @{logname="Microsoft-Windows-Sysmon/Operational"; id=1}
```  

#### Windows Defender  
Pull all live Windows Defender event logs  
```powershell
Get-WinEvent -FilterHashtable @{logname="Microsoft-Windows-Windows Defender/Operational"}
```  
Pull Windows Defender event logs 1116 and 1117 from the live event log  
```powershell
Get-WinEvent -FilterHashtable @{logname="Microsoft-Windows-Windows Defender/Operational";id=1116,1117}
```  
Pull Windows Defender event logs 1116 (malware detected) and 1117 (malware blocked) from a saved evtx file  
```powershell
Get-WinEvent -FilterHashtable @{path="WindowsDefender.evtx";id=1116,1117}
```

## References  
[SANS PowerShell Reference](https://wiki.sans.blue/#!Tools/Get-WinEvent.md)  
[SANS PowerShell Reference GitHub](https://github.com/sans-blue-team/blue-team-wiki)  

## Revision History  
* 20230127 - Initial creation  

