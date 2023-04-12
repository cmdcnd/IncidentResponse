## Task Enable Account Usage Auditing  


## Conditions    
Given a user account with necessary rights to modify audit policies and a target computer    


## Standards  
* Team member enables of the following auditing  
  * Credential validation - Success  
  * Logon events - Success and Failure  
  * Logoff events - Success  
  * Computer account management - Success and Failure etc  
* Team member checks Windows Security event logs to ensure expected log entries are present        


## End State    
System is configured to log account usage events in support of operational and forensic auditing that are compliant with the system owner's needs and meet regulatory compliance requirements for the enclave.   


## Notes  
Mission Element lead ought to request this capability of the business owner in order to secure accounts and organizational units  


## Manual Steps    
* Set log auditing on for success and/or failure on subcategories. This will be for all subcategories    
  ```bat
  auditpol /set /subcategory:"Logon" /success:enable /failure:enable    
  The command was successfully executed.     
  ```    

* View the available log files, size, and retention limit    
  ```powershell
  Get-EventLog -List
    Max(K) Retain OverflowAction        Entries Log                                                                              
    ------ ------ --------------        ------- ---                                                                              
  --snipped--                                                        
    20,480      0 OverwriteAsNeeded      16,209 Security                                                                         
    20,480      0 OverwriteAsNeeded       2,722 System                                                                           
  --snipped--
  ```    

* Partial list of Key Security Log Auditing events to monitor    
  ```powershell
  Get-EventLog -Newest 3 -LogName Security 

    Index Time          EntryType   Source                 InstanceID Message                                                   
    ----- ----          ---------   ------                 ---------- -------                                                   
    407734 Aug 15 10:36  SuccessA... Microsoft-Windows...         4703 A token right was adjusted....                            
    407733 Aug 15 10:36  SuccessA... Microsoft-Windows...         4703 A token right was adjusted....                            
    407732 Aug 15 10:36  SuccessA... Microsoft-Windows...         4703 A token right was adjusted....
  ```     

* After running the script, you will see the following output:    
	```
	--snipped--
	[+] There are 59 categories/subcategories.
	[+] Enabling logs for success and failure for: Security System Extension
	[+] Enabling logs for success and failure for: System Integrity
	--snipped--
	[+] There are 7 available logs:
		--> Information for Application
				OverflowAction: OverwriteAsNeeded
		--> Information for HardwareEvents
				OverflowAction: OverwriteAsNeeded
	--snipped--
	```


## References    
[Windows Commands AuditPol](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/auditpol-get)  


## Revision History    
 