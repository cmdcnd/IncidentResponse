## Task Change or Disable Workstation Local Administrator Account  


## Conditions  
Given domain credentials with the appropriate permissions, and an incident response workstation with necessary tools and accounts.  


## Standards  
The built-in administrator account is a well-known account subject to attack. It also provides no accountability to individual administrators on a system.  
* Team member coordinates the requirement of Disabling the Local Workstation Administrator Account.  
* Team member creates Group Policy Object (GPO) in Group Policy Management Console (GPMC) to disable the Local Workstation Local Administrator account  
* Team member links Group Policy Object (GPO) to workstation Organizational Unit (OU) in Active Directory  

## End State  


## Manual Steps  
Group Policy Object (GPO) is the recommend course of action to complete this task. GPO can be created by using the Computer Policy -> Windows Settings -> Security Settings -> Local Policies -> Security Options and then Accounts:Administrator account settings to Disabled Once GPO is created it should be linked to all Workstation Objects in the Domain. Once this GPO is linked it will effectively disable all Local Administrator Account where it is linked  

OR  

Use the net user command to disable the Administrator account  
	```bat
	net user administrator /active:no
	```  

## Running Script  


## Dependencies  


## Other available tools  


## References  
[Windows 7 Security Technical Implementation Guide](https://iase.disa.mil/stigs/)  
[Enable / Disable Administrator account](https://technet.microsoft.com/en-us/library/dd744293(v=ws.10).aspx)  
[Creating Group Policy Object](https://technet.microsoft.com/en-us/library/cc754740(v=ws.11).aspx)  


## Revision History  
