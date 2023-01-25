##Prompts for Privileged User credentials for remote clients
##initial information gathering for script.
$dir1 = Get-Location
$dir = $dir1.ToString();
$wazuh = Get-ChildItem -path $dir -Include wazuh-agent*.msi -Recurse | Select-Object -expand Name
$SOserver = Read-Host "Type ip of Security Onion Server: "

<#this portion is modifying the local files install-sysmon.bat and ossec.conf#>
(Get-Content "$dir\install-wazuh.bat").Replace('x.x.x.x',"$SOserver") | Out-File "$dir\install-wazuh.bat" -Encoding ascii
sleep 1
(Get-Content "$dir\install-wazuh.bat").Replace('<change>',"$wazuh") | Out-File "$dir\install-wazuh.bat" -Encoding ascii
sleep 1
write-host "Completed modifying uninstall-wazuh.bat"
(Get-Content "$dir\uninstall-wazuh.bat").Replace('<change>',"$wazuh") | Out-File "$dir\uninstall-wazuh.bat" -Encoding ascii
sleep 1
write-host "Completed modifying uninstall-wazuh.bat"
(Get-Content "$dir\ossec.conf").Replace('x.x.x.x',"$SOserver") | Out-File "$dir\ossec.conf" -Encoding utf8
sleep 1
Write-Host "Completed modifying ossec.conf"

<# ------variables used for testing below, uncomment to use and re-comment in production
$ip = "x.x.x.x"
$pass = "somepassword"
$domain = "domain.name" 
#>
<# Gathering IP address for local system then setting that IP to $ip variable #>
<#
$ip = (
 Get-NetIPConfiguration |
 Where-Object {
    $_.IPv4DefaultGateway -ne $null -and
    $_.NetAdapter.Status -ne "Disconnected"
    }
).IPv4Address.IPAddress
#>
Write-Host "Run the following command on SecurityOnion to enable client autoregistration: /var/ossec/bin/ossec-agentd -f"
pause
$domainuser = Read-Host 'Enter Domain Admin Username'
$pass = Read-Host 'Enter Domain Admin password'
$domain = Read-Host 'Enter Domain name'


##***must create ips.txt file with ipaddress for all hosts in network that you want to push too.
$clients = "$dir\ips.txt"
$psexec = "$dir\PsExec.exe" #(Note: Ensure psexec.exe is Unblocked)

Write-Host
do { 
    Write-Host "Welcome, Please select an option"
    Write-host "Press 1 to make current Directory an SMB Share(*Optional for workstations that fail to copy otherwise)"
    write-host "Press 2 to copy files to the workstations"
    write-host "Press 3 to install sysmon"
	write-host "press 4 to install wazuh"
    write-host "Press 5 to uninstall sysmon (under construction)"
    write-host "Press 6 to uninstall wazuh agents"
    write-host "Press 7 to push modified ossec configuration file"
    write-host "Press 8 to install velociraptor client"
    Write-Host "Press 9 to run GPUPDATE /FORCE"
    Write-Host "Press 10 to check Sysmon services"
    Write-Host "Press 11 to check Wazuh services"
    Write-Host "Press 12 to check Velociraptor services"
    write-host "Press q to exit"
    $input = Read-Host
    switch ($Input) {
    '1' {
        Write-Host "Creating new SMB Share"
        #SMB Share - making an smb share of the current directory so workstations will have access to copy files from.
        New-SmbShare -Name "Tools" -Path "$dir" -FullAccess "users" -ErrorAction SilentlyContinue
    }
    '2' {
        ##For every IP in the Client IP list, psexec will make a remote connection and execute the .bat script.
        ##Execution will complete in order according to the Client IP list.
        Write-Host "Copying files to systems"
        ForEach ($client in Get-Content $clients) {
            New-Item -Path \\$client\C$\Tools -type directory -Force;
            Copy-Item -Path $dir\* -Destination \\$client\c$\Tools;
            Write-Host "$client copy of files completed successfully";
        }
    }
    '3' {
        ##psexec install sysmon
        Write-Host "Installing Sysmon and Wazuh Agents"
        Start-Process -filepath $psexec "-h @$dir\ips.txt -u $domain\$domainuser -p $pass c:\Tools\install-sysmon.bat -accepteula" -wait;
    }
	'4' {
        ##psexec install wazzuh
        Write-Host "Installing Sysmon and Wazuh Agents"
        Start-Process -filepath $psexec "-h @$dir\ips.txt -u $domain\$domainuser -p $pass c:\Tools\install-wazuh.bat -accepteula" -wait;
    }
    '5' {
        ##psexec delete wazzuh - uncomment the line below and run the line individually
        Write-Host "Uninstalling Sysmon"
        Start-Process -FilePath $psexec "-h @$dir\ips.txt -u $domain\$domainuser -p $pass c:\Tools\uninstall-sysmon64.bat -accepteula";
        sleep 20
    }
    '6' {
        ##psexec delete wazzuh - uncomment the line below and run the line individually
        Write-Host "Uninstalling Wazuh"
        Start-Process -FilePath $psexec "-h @$dir\ips.txt -u $domain\$domainuser -p $pass c:\Tools\uninstall-wazuh.bat -accepteula";
        sleep 20
    }
    '7' {
        
        #push config for ossecon.conf then restart the service.
        Write-Host "Copying Ossec.conf file to all workstations and restarting service"
        ForEach ($client in Get-Content $clients) {
            Copy-Item -Path $dir\ossec.conf -Destination "\\$client\c$\Program Files (x86)\ossec-agent\ossec.conf"
            Get-Service -ComputerName $client -Name Wazuh | Restart-Service
            Write-Host "$client osssec.conf copied  completed successfully";
        } 
    }
    '8' {
        ##psexec to install Velociraptor on client machines
        Write-Host "Installing Velociraptor Clients"
        Start-Process -filepath $psexec "-h @$dir\ips.txt -u $domain\$domainuser -p $pass c:\Tools\install-velociraptor.bat";
    }
    '9' {
        ##psexec to run gpupdate /force
        Write-Host "running GP Update"
        Start-Process -filepath $psexec "-h @$dir\ips.txt -u $domain\$domainuser -p $pass gpupdate /force";
    }
    '10' {
        ##psexec to check windows computers for wazuh service
        Write-Host "checking Sysmon services"
        ForEach ($client in Get-Content $clients) {
            write-host "checking" $client
            Get-Service Sysmon -ComputerName $client | ft -HideTableHeaders
            Get-Service Sysmon -ComputerName $client | Where-Object {$_.Status -eq "Stopped"} | Start-Service
            Write-Host "$client is completed";
            write-host "-------------------"
        }
    }
    '11' {
        ##psexec to check windows computers for wazuh service
        Write-Host "checking Wazuh services"
        ForEach ($client in Get-Content $clients) {
            write-host "checking" $client
            Get-Service Wazuh -ComputerName $client | ft -HideTableHeaders
            Get-Service Wazuh -ComputerName $client | Where-Object {$_.Status -eq "Stopped"} | Start-Service
            Write-Host "$client is completed";
            write-host "-------------------"
        }
    }
    '12' {
        ##psexec to check windows computers for wazuh service
        Write-Host "checking Velociraptor services"
        ForEach ($client in Get-Content $clients) {
            write-host "checking" $client
            Get-Service Velociraptor -ComputerName $client | ft -HideTableHeaders
            Get-Service Velociraptor -ComputerName $client | Where-Object {$_.Status -eq "Stopped"} | Start-Service
            Write-Host "$client is completed";
            write-host "-------------------"
        }
    }
   }
 }
 until ($input -eq 'q') {
 }
