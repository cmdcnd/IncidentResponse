#Scan for available hosts on the subnet
$subnet = Read-host "Which subnet to scan? eg. 10.10.10"
$range = Read-host "How many hosts to scan?"
$creds = Get-Credential
$online = @()
$targets = @()
$MyIPs = (Get-NetIPAddress).IPv4Address

$hosts = 2.."$range" | foreach {"$subnet.$_"}
#Remove self IPs from hosts list
$hosts = $hosts | ?{$MyIPs -notcontains $_}

$hosts | foreach{
Write-Progress "Scanning $_ now";
if(ping -n 1 -w 1 $_ | findstr Reply)
{
$psonline = New-Object PSObject -Property @{
IPv4 = $_
}
$online += $psonline
Write-host "$_ is online" -ForegroundColor Yellow
}
}

Write-Host "There are "$online.count" hosts on the subnet" -ForegroundColor Yellow
Write-Host "Testing for PSSession port 5985"
$online.IPv4 | foreach{
if(Test-NetConnection $_ -Port 5985 | Select -Property TCPTestSucceeded |findstr True)
{
Write-host "Port open on "$_", remote session possible" -ForegroundColor Green
$targets += $_
$targetobj = New-Object PSObject -Property @{
IPv4 = $_
}
$targets += $targetobj
}
}
Write-Host "Adding potential sessions to TrustedHosts"
$targets.IPv4 | foreach{set-item WSMan:\localhost\Client\TrustedHosts -Value "$_" -Force -Concatenate}

#Attempt session with provided creds
$connected = $targets.IPv4 | foreach{New-PSSession -ComputerName "$_" -credential $creds -ErrorAction SilentlyContinue}

#Create a section for installing GRR on the remote system. This will allow it to be skipped if used in a function.
$GRRUpdate = Read-host "Would you like to install GRR on the remote systems? (Y/N)"
if($GRRUpdate -like "Y"){
Write-Host "Pushing the installer to the remote hosts" -ForegroundColor Green
$connected.ComputerName | foreach{
Write-host "Copying installer to: " $_
Copy-Item -ToSession (New-PSSession -ComputerName $_ -Credential $creds) -Path C:\GRR_3.1.0.2_amd64.exe -Destination C:\GRR_Installer.exe -Force
}
#Execute the installer on each remote system
Write-host "Executing installers on remote hosts" -ForegroundColor Green
Invoke-Command -ComputerName $connected.ComputerName -Credential $creds -ScriptBlock{&start 'C:\GRR_Installer.exe'}
sleep 10
#Check to see if GRR is running on the remote system
Invoke-Command -ComputerName $connected.ComputerName -Credential $creds -ScriptBlock{Get-process GRR*}

}

New-Alias psexec -Value C:\PsExec.exe
$connected.ComputerName | foreach{

psexec \\$_ -u Administrator -P P@ssw0rd -c C:\GRR_3.1.0.2_amd64.exe -accepteula

}

Invoke-Command -ComputerName $connected.ComputerName -Credential $creds -ScriptBlock{Get-Process GRR*}


Invoke-Command -ComputerName $connected.ComputerName -Credential $creds -ScriptBlock{Get-ChildItem -Path C:\* -Include wdboot.sys -Recurse -Force -ErrorAction SilentlyContinue | Get-filehash -Algorithm MD5 | select -Property PSComputerName,Path,Hash}

Invoke-Command -ComputerName $connected.ComputerName -Credential $creds -ScriptBlock{Get-LocalUser}