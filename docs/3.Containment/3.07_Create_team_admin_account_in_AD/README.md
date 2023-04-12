## Task Create Team Admin Account in Active Directory (AD)  


## Conditions  
Given a target Domain, a Domain Controller (DC), a user account with appropriate rights and privileges to modify user accounts, and a workstation with the Windows Remote Server Administration Tools (RSAT) installed.  


## Standards  
* Team member coordinates the requirement to modify the Administrator Group on the Domain  
* Team member creates User Account in Active Directory on target Domain  
* Team member opens the Active Directory Users and Computers (ADUC) console on the workstation or Server and locates the Domain Admins Group account within the Organizational Unit (OU) structure  
* Team member resets the password and closes ADUC  

OR  

* Team member coordinates the requirement to modify the creation of Team Accounts and addition of accounts to Domain Admin Group with enclave administrators.  
* Team member utilizes Active Directory Users and Computers (ADUC) or PowerShell cmdlets to create user accounts and modification of Domain Group membership  


## End State  
New user account is created in Active Directory with Domain Admin credentials that the Team can utilize to carry out protection tasks.  


## Notes  
Mission Element lead ought to request this capability of the business owner in order to secure accounts and organizational units  


## Manual Steps  
* Create Active Directory User  
* Click Start, click Administrative Tools, and then click Active Directory Users and Computers. The Active Directory Users and Computers MMC opens. If it is not already selected, click the node for your domain. For example, if your domain is example.com, click example.com.  
* In the details pane, right-click the folder in which you want to add a user account.  
  * Active Directory Users and Computers/domain node/folder  
* Point to New, and then click User.  
* In First name, type the user's first name.  
* In Initials, type the user's initials.  
* In Last name, type the user's last name.  
* Modify Full name to add initials or reverse the order of first and last names.  
* In User logon name, type the name that will be used to log on to the Active Directory domain. Click Next.  
* In the New Object - User window, in Password and Confirm password, type the user's password, and then select the appropriate password options.  
* Click Next. The last window allows you to review the parameters provided by on the previous steps. If you wish to modify any parameters, click Back; otherwise, click Finish to create the domain administrator account.  

* Assign Group Membership  
* Click Start, click Administrative Tools, and then click Active Directory Users and Computers. The Active Directory Users and Computers MMC opens. If it is not already selected, click the node for your domain. For example, if your domain is example.com, click example.com.  
* In the details pane, double-click the folder that contains the group to which you want to add a member.  
  * Active Directory Users and Computers/domain node/folder that contains the group  
* In the details pane, right-click the group to which you want to add a member, and then click Properties. The group Properties dialog box opens.  
* Select the Members of tab, then click Add.  
* In Enter the object names to select, type the name of the user, group, or computer that you want to add, and then click OK.  
* To assign group membership to other users, groups or computers, repeat steps 4 and 5 of this procedure.  


## Running Script  


## Dependencies  


## Other available tools  


## References  
[Create user in Active Directory](https://technet.microsoft.com/en-us/library/dd894463(v=ws.10).aspx)  
[Assign Group Membership](https://technet.microsoft.com/en-us/library/dd894436(v=ws.10).aspx)  


## Revision History  
