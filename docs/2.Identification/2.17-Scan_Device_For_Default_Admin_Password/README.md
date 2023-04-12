## Task Scan Device For Default Admin Passwords  


## Conditions  
Given a suspected compromised network segment(s), access to a system that can access and scan the identified network devices, and scanning software included in the team’s incident response kit.  


## Standards  
Team Member Scans network for devices with default passwords  
Idenitfy devices and notify network owner  


## End State  
All devices on nework with weak or default passwords will be identified.  


## Manual Steps  
First thing you want to do is log into nessus via the IP of the nessus server with the port 8834.  
example https://x.x.x.x:8834  

Once Logged in, verify you have the correct plugins enabled:  
* Scans > New Scan > Advanced Scan  
* Click the Plugins tab > Click Filter at the top toolbar  
* Change the drop down to "Default/Known accounts" and click apply  
* The list of 'Enabled' plugins will switch to just the filtered plugins  


If there were some that were not enabled for default/known account filter just enable them.  

* Once verified create a new scan  
	* Create advanced Scan  
	* Add the title or name (weak & Known password scan)  
	* Type in the IP range i.e. x.x.x.x/24  

* Leave all other settings default  
* Save  
* Launch Scan  


## Dependencies  
* Nessus Server  


## Other available tools  
N/A  


## References  
[Nessus Plugins](https://community.tenable.com/s/article/What-are-the-plugins-that-test-for-default-accounts)  
[Nessus Default Credentials](https://www.tenable.com/blog/scanning-for-default-common-credentials-using-nessus)  


## Revision History  
