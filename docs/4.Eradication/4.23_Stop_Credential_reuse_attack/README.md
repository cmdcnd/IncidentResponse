## Task Stop Credential Re-use Attack   


## Conditions  
* Compromised credentials. Can be any authentication credentials that provides access to internal network, hardware, software.  
* Insider and external threats.  


## Standards  
Identified/alerted on compromised credentials.  Identify what the compromised credentials has access to.  Alert appropriate personnel/groups of compromised credentials.  Disable Account a. Active Directory / User account Management Application b. Shared accounts / administrator accounts (domain, server, workstation, local) c. Known servers and databases that are not linked to Active Directory d. Known applications that are LDAP and non-LDAP authenticated e. Email Exchange account and credentials. f. Mobile / MDM g. Physical Access: keyfobs, access cards h. Externally facing websites i. Inactive / Infrequently used accounts j. Emergency or temporary accounts k. PLCs/SCADA l. Misc devices: tablets  Degrade host(s) access via host port a. Active layer switch ACL b. Boundary Firewall GPO c. Remote/VPN Disable d. Remote wipe, if lost device (if available)  Alerting a. If possible, monitor and alert for attempted future attempts with compromised credentials.  


## End State  
Compromised credentials are disabled and/or changed in all areas. Appropriate hosts are restricted or disabled. Attacker cannot re-use credentials to access any internal network area, hosts, hardware, or software.  


## Notes  
There may be other areas to disable accounts, dependent on the network environment.  


## Manual Steps  


## Running Script  


## Dependencies  


## Other available tools  


## References  
[NIST 800-53 Credential Controls](https://nvd.nist.gov/800-53/Rev4/control/AC-2)  


## Revision History  
