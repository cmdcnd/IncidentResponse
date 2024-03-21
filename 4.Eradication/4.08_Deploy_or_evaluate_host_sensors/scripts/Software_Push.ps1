##Prompts for Privileged User credentials for remote clients
# Function to create IP list
function Get-IpRange {
<#
.SYNOPSIS
    Given a subnet in CIDR format, get all of the valid IP addresses in that range.
.DESCRIPTION
    Given a subnet in CIDR format, get all of the valid IP addresses in that range.
.PARAMETER Subnets
    The subnet written in CIDR format 'a.b.c.d/#' and an example would be '192.168.1.24/27'. Can be a single value, an
    array of values, or values can be taken from the pipeline.
.EXAMPLE
    Get-IpRange -Subnets '192.168.1.24/30'
 
    192.168.1.25
    192.168.1.26
.EXAMPLE
    (Get-IpRange -Subnets '10.100.10.0/24').count
 
    254
.EXAMPLE
    '192.168.1.128/30' | Get-IpRange
 
    192.168.1.129
    192.168.1.130
.NOTES
    Inspired by https://gallery.technet.microsoft.com/PowerShell-Subnet-db45ec74
 
    * Added comment help
#>

    [CmdletBinding(ConfirmImpact = 'None')]
    Param(
        [Parameter(Mandatory, HelpMessage = 'Please enter a subnet in the form a.b.c.d/#', ValueFromPipeline, Position = 0)]
        [string[]] $Subnets
    )

    begin {
        Write-Verbose -Message "Starting [$($MyInvocation.Mycommand)]"
    }

    process {
        foreach ($subnet in $subnets) {
            if ($subnet -match '^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/\d{1,2}$') {
                #Split IP and subnet
                $IP = ($Subnet -split '\/')[0]
                [int] $SubnetBits = ($Subnet -split '\/')[1]
                if ($SubnetBits -lt 7 -or $SubnetBits -gt 30) {
                    Write-Error -Message 'The number following the / must be between 7 and 30'
                    break
                }
                #Convert IP into binary
                #Split IP into different octects and for each one, figure out the binary with leading zeros and add to the total
                $Octets = $IP -split '\.'
                $IPInBinary = @()
                foreach ($Octet in $Octets) {
                    #convert to binary
                    $OctetInBinary = [convert]::ToString($Octet, 2)
                    #get length of binary string add leading zeros to make octet
                    $OctetInBinary = ('0' * (8 - ($OctetInBinary).Length) + $OctetInBinary)
                    $IPInBinary = $IPInBinary + $OctetInBinary
                }
                $IPInBinary = $IPInBinary -join ''
                #Get network ID by subtracting subnet mask
                $HostBits = 32 - $SubnetBits
                $NetworkIDInBinary = $IPInBinary.Substring(0, $SubnetBits)
                #Get host ID and get the first host ID by converting all 1s into 0s
                $HostIDInBinary = $IPInBinary.Substring($SubnetBits, $HostBits)
                $HostIDInBinary = $HostIDInBinary -replace '1', '0'
                #Work out all the host IDs in that subnet by cycling through $i from 1 up to max $HostIDInBinary (i.e. 1s stringed up to $HostBits)
                #Work out max $HostIDInBinary
                $imax = [convert]::ToInt32(('1' * $HostBits), 2) - 1
                $IPs = @()
                #Next ID is first network ID converted to decimal plus $i then converted to binary
                For ($i = 1 ; $i -le $imax ; $i++) {
                    #Convert to decimal and add $i
                    $NextHostIDInDecimal = ([convert]::ToInt32($HostIDInBinary, 2) + $i)
                    #Convert back to binary
                    $NextHostIDInBinary = [convert]::ToString($NextHostIDInDecimal, 2)
                    #Add leading zeros
                    #Number of zeros to add
                    $NoOfZerosToAdd = $HostIDInBinary.Length - $NextHostIDInBinary.Length
                    $NextHostIDInBinary = ('0' * $NoOfZerosToAdd) + $NextHostIDInBinary
                    #Work out next IP
                    #Add networkID to hostID
                    $NextIPInBinary = $NetworkIDInBinary + $NextHostIDInBinary
                    #Split into octets and separate by . then join
                    $IP = @()
                    For ($x = 1 ; $x -le 4 ; $x++) {
                        #Work out start character position
                        $StartCharNumber = ($x - 1) * 8
                        #Get octet in binary
                        $IPOctetInBinary = $NextIPInBinary.Substring($StartCharNumber, 8)
                        #Convert octet into decimal
                        $IPOctetInDecimal = [convert]::ToInt32($IPOctetInBinary, 2)
                        #Add octet to IP
                        $IP += $IPOctetInDecimal
                    }
                    #Separate by .
                    $IP = $IP -join '.'
                    $IPs += $IP
                }
                Write-Output -InputObject $IPs
            } else {
                Write-Error -Message "Subnet [$subnet] is not in a valid format"
            }
        }
    }

    end {
        Write-Verbose -Message "Ending [$($MyInvocation.Mycommand)]"
    }
}



##initial information gathering for script.
$dir1 = Get-Location
$dir = $dir1.ToString();
$winlogbeat = Get-ChildItem -path $dir\software -Include winlogbeat*.msi -Recurse | Select-Object -expand Name
Write-Host ""
Write-Host "Type ip of Security Onion Server: " -ForegroundColor Green
$SOserver = Read-Host
Write-Host ""

# Declare variables so are they are empty
$varIPSubnets = $null
$varCIDR = $null
$varIPSubnets = $null
$varAllIPs = $null
$varIP = $null
$varISWindows = $null
$varWindowsSystem = $null
$varIPOutputFile = "$dir\ips.txt"

<#this portion is modifying the local files install-sysmon.bat and ossec.conf#>
(Get-Content "$dir\software\winlogbeat.yml").Replace('x.x.x.x',"$SOserver") | Out-File "$dir\software\winlogbeat.yml" -Encoding ascii
sleep 1
Write-Host "Completed modifying winlogbeat.yml"
Write-Host ""

Write-Host "Enter Domain Admin Username" -ForegroundColor Green
$domainuser = Read-Host
Write-Host ""
Write-Host "Enter Domain Admin password" -ForegroundColor Green
$pass = Read-Host
Write-Host ""
Write-Host "Enter Domain Name" -ForegroundColor Green
$domain = Read-Host
Write-Host ""


##***must create ips.txt file with ipaddress for all hosts in network that you want to push too.
Function Get-FileName($title="File Picker", $initialDirectory)
{   
 [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
 $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
 $OpenFileDialog.Title = $title
 $OpenFileDialog.initialDirectory = $initialDirectory
 $OpenFileDialog.filter = "Text files (*.txt)|*.txt"
 $OpenFileDialog.ShowDialog() | Out-Null
 $OpenFileDialog.filename
} #end function Get-FileName

$clients = "$dir\ips.txt"
$psexec = "$dir\PsExec.exe" #(Note: Ensure psexec.exe is Unblocked)

Write-Host
do { 
    Clear-Host
    Write-Host "If you already have a list of IPs, you can skip option 1.  Ensure a file with name ips.txt exists in the working directory of this script" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Welcome, Please select an option"
    Write-host "Press 1 to scan subnets for windows systems" -ForegroundColor Green
    write-host "Press 2 to copy files to remote systems" -ForegroundColor Green
    write-host "Press 3 to install sysmon" -ForegroundColor Green
    write-host "press 4 to install winlogbeat" -ForegroundColor Green
    write-host "Press 5 to uninstall sysmon (under construction)" -ForegroundColor Green
    write-host "Press 6 to uninstall winlogbeat agents" -ForegroundColor Green
    write-host "Press 7 to push modified winlogbeat configuration file" -ForegroundColor Green
    write-host "Press 8 to install velociraptor client" -ForegroundColor Green
    Write-Host "Press 9 to run GPUPDATE /FORCE" -ForegroundColor Green
    Write-Host "Press 10 to check Sysmon services" -ForegroundColor Green
    Write-Host "Press 11 to check Winlogbeat services" -ForegroundColor Green
    Write-Host "Press 12 to check Velociraptor services" -ForegroundColor Green
    write-host "Press q to exit"
    $input = Read-Host
    switch ($Input) {
    '1' {
        if ([string]::IsNullOrEmpty($varIPSubnets))
        {
            Write-Host ""
            Write-Host ""
            Write-Host "Please select file that contains a list of IP Subnets/CIDR blocks to scan for Windows Systems" -ForegroundColor Green
            Write-Host "Example: 192.16.0.0/24 one entry per line" -ForegroundColor Green
            pause
            $varIPSubnets = Get-FileName -title "CIDR/IPs (one perline)" -initialDirectory "$([Environment]::GetFolderPath("MyComputer"))"
            Remove-Item -Path $dir\ips.txt -ErrorAction SilentlyContinue
        }
        ForEach ($varCIDR in Get-Content $varIPSubnets) {
        $varAllIPs += (Get-IpRange -Subnets $varCIDR)
        }

        ForEach ($varIP in $varAllIPs) {
            $varIPAlive = Test-Connection -Count 1 -ComputerName $varIP -Quiet
            if ($varIPAlive) {
            Write-Host "$varIP is up"
            $varWindowsSystem = Test-NetConnection -ComputerName $varIP -Port 445
                if ($varWindowsSystem.TcpTestSucceeded) {
                    Write-Host "$varIP is up and listening on 445"
                    $varIP | Out-File $varIPOutputFile -Append
                }
                else {
                    Write-Host "Not listening on 445"
                }
            }
            else {
                Write-Host "$varIP is down"
            }
        }
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
        Foreach ($client in Get-Content $clients) {
        Start-Process -filepath $psexec "-h \\$client -u $domain\$domainuser -p $pass c:\SoftwareTools\install-sysmon.bat -accepteula" -wait;
        }
    }
	'4' {
        ##psexec install winlogbeat
        Write-Host "Installing Winlogbeat Agents"
        Foreach ($client in Get-Content $clients) {
        Start-Process -filepath $psexec "-h \\$client -u $domain\$domainuser -p $pass c:\SoftwareTools\install-winlogbeat.bat -accepteula" -wait;
        }
    }
    '5' {
        ##psexec delete sysmon - uncomment the line below and run the line individually
        Write-Host "Uninstalling Sysmon"
        Foreach ($client in Get-Content $clients) {
        Start-Process -FilePath $psexec "-h \\$client -u $domain\$domainuser -p $pass c:\SoftwareTools\uninstall-sysmon64.bat -accepteula";
        sleep 20
        }
    }
    '6' {
        ##psexec delete winlogbeat - uncomment the line below and run the line individually
        Write-Host "Uninstalling Wazuh"
        Foreach ($client in Get-Content $clients) {
        Start-Process -FilePath $psexec "-h \\$client -u $domain\$domainuser -p $pass c:\SoftwareTools\uninstall-winlogbeat.bat -accepteula";
        sleep 20
        }
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
        Foreach ($client in Get-Content $clients) {
        Start-Process -filepath $psexec "-h \\$client -u $domain\$domainuser -p $pass c:\SoftwareTools\install-velociraptor.bat";
        }
    }
    '9' {
        ##psexec to run gpupdate /force
        Write-Host "running GP Update"
        Foreach ($client in Get-Content $clients) {
        Start-Process -filepath $psexec "-h \\$client -u $domain\$domainuser -p $pass gpupdate /force";
        }
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
