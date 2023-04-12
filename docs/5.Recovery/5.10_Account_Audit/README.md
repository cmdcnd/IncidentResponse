# Task Account Audit  


## Conditions  
Review standard and privilege accounts to identify and remediate users with access beyond daily operations.  


## Standards  
In accordance with Principle of Least Permissions, privileged roles and standard roles must to reviewed on regular basis.    

Privileged and Standard roles(accounts) should have minimum permissions to allow daily operations.  
All privilege accounts should be separate per roles.  (i.e.  Domain Admins - DA-username, Servers - svc-username,   DNS - dns-username)  

* Privilege roles (100% Check monthly)  
	* Enterprise administrators  
	* Domain Administrators  
	* Power Users  
	* HelpDesk  
	* Service Accounts  
	* DNS Administrators  
	* Other  
	
* Standard Roles (20% Check quarterly)  
	* All standard role accounts with separate privilege role accounts should be checked montly.  


## End State  
Agency free of standard users accounts with privilege roles.  
Separation of privilege roles (DNS, DA, Enterprise, etc)  


## Notes  


## Manual Steps  


## Running Scripts  


## Dependencies  


## References  
[NIST 800-53 AC-6](https://csrc.nist.gov/Projects/risk-management/sp800-53-controls/release-search#!/control?version=4.0&number=AC-6)  
[NIST 800-171 (3.1.5)](https://nvlpubs.nist.gov/nistpubs/hb/2017/nist.hb.162.pdf)  


## Revision History  
