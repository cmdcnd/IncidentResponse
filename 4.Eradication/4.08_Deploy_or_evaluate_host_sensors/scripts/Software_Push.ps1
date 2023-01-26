##Prompts for Privileged User credentials for remote clients
##initial information gathering for script.
$dir1 = Get-Location
$dir = $dir1.ToString();
$winlogbeat = Get-ChildItem -path $dir\software -Include winlogbeat*.msi -Recurse | Select-Object -expand Name
$SOserver = Read-Host "Type ip of Security Onion Server: "

<#this portion is modifying the local files install-sysmon.bat and ossec.conf#>
(Get-Content "$dir\software\winlogbeat.yml").Replace('x.x.x.x',"$SOserver") | Out-File "$dir\software\winlogbeat.yml" -Encoding ascii
sleep 1
Write-Host "Completed modifying winlogbeat.yml"

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
	write-host "press 4 to install winlogbeat"
    write-host "Press 5 to uninstall sysmon (under construction)"
    write-host "Press 6 to uninstall winlogbeat agents"
    write-host "Press 7 to push modified winlogbeat configuration file"
    write-host "Press 8 to install velociraptor client"
    Write-Host "Press 9 to run GPUPDATE /FORCE"
    Write-Host "Press 10 to check Sysmon services"
    Write-Host "Press 11 to check Winlogbeat services"
    Write-Host "Press 12 to check Velociraptor services"
    write-host "Press q to exit"
    $input = Read-Host
    switch ($Input) {
    '1' {
        Write-Host "Creating new SMB Share"
        #SMB Share - making an smb share of the current directory so workstations will have access to copy files from.
        New-SmbShare -Name "SoftwareTools" -Path "$dir" -FullAccess "users" -ErrorAction SilentlyContinue
    }
    '2' {
        ##For every IP in the Client IP list, psexec will make a remote connection and execute the .bat script.
        ##Execution will complete in order according to the Client IP list.
        Write-Host "Copying files to systems"
        ForEach ($client in Get-Content $clients) {
            New-Item -Path \\$client\C$\SoftwareTools -type directory -Force;
            Copy-Item -Path $dir\software\* -Destination \\$client\c$\SoftwareTools;
            Write-Host "$client copy of files completed successfully";
        }
    }
    '3' {
        ##psexec install sysmon
        Write-Host "Installing Sysmon"
        Start-Process -filepath $psexec "-h @$dir\ips.txt -u $domain\$domainuser -p $pass c:\SoftwareTools\install-sysmon.bat -accepteula" -wait;
    }
	'4' {
        ##psexec install wazzuh
        Write-Host "Installing Winlogbeat Agents"
        Start-Process -filepath $psexec "-h @$dir\ips.txt -u $domain\$domainuser -p $pass c:\SoftwareTools\install-winlogbeat.bat -accepteula" -wait;
    }
    '5' {
        ##psexec delete sysmon - uncomment the line below and run the line individually
        Write-Host "Uninstalling Sysmon"
        Start-Process -FilePath $psexec "-h @$dir\ips.txt -u $domain\$domainuser -p $pass c:\SoftwareTools\uninstall-sysmon64.bat -accepteula";
        sleep 20
    }
    '6' {
        ##psexec delete winlogbeat - uncomment the line below and run the line individually
        Write-Host "Uninstalling Wazuh"
        Start-Process -FilePath $psexec "-h @$dir\ips.txt -u $domain\$domainuser -p $pass c:\SoftwareTools\uninstall-winlogbeat.bat -accepteula";
        sleep 20
    }
    '7' {
        
        #push config for winlogbeat.yml then restart the service.
        Write-Host "Copying winlogbeat.yml file to all workstations and restarting service"
        ForEach ($client in Get-Content $clients) {
            Copy-Item -Path $dir\software\winlogbeat.yml -Destination "\\$client\c$\ProgramData\Elastic\Beats\winlogbeat\winlogbeat.yml"
            Get-Service -ComputerName $client -Name winlogbeat | Restart-Service
            Write-Host "$client winlogbeat.yml copied  completed successfully";
        } 
    }
    '8' {
        ##psexec to install Velociraptor on client machines
        Write-Host "Installing Velociraptor Clients"
        Start-Process -filepath $psexec "-h @$dir\ips.txt -u $domain\$domainuser -p $pass c:\SoftwareTools\install-velociraptor.bat";
    }
    '9' {
        ##psexec to run gpupdate /force
        Write-Host "running GP Update"
        Start-Process -filepath $psexec "-h @$dir\ips.txt -u $domain\$domainuser -p $pass gpupdate /force";
    }
    '10' {
        ##psexec to check windows computers for sysmon service
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
        ##psexec to check windows computers for winlogbeat service
        Write-Host "checking Winlogbeat services"
        ForEach ($client in Get-Content $clients) {
            write-host "checking" $client
            Get-Service winlogbeat -ComputerName $client | ft -HideTableHeaders
            Get-Service winlogbeat -ComputerName $client | Where-Object {$_.Status -eq "Stopped"} | Start-Service
            Write-Host "$client is completed";
            write-host "-------------------"
        }
    }
    '12' {
        ##psexec to check windows computers for velociraptor service
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
