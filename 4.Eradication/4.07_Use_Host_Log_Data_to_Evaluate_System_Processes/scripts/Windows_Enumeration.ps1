##Prompts for Privileged User credentials for remote clients
##initial information gathering for script.
$dir1 = pwd
$dir = $dir1.ToString();

Write-Host
do { 
    wait
    cls
    Write-Host "Welcome, Please select an option"
    Write-host "Press 1 to gather System Information"
    write-host "Press 2 to gather AutoRun information from Registry"
    write-host "Press 3 to gather event logs"
    write-host "Press 4 to view installed software"
    write-host "Press 5 to view network connections"
    write-host "Press 6 to gather processes"
    write-host "Press 7 to gather USB device inforamtion"
    write-host "Press 8 to gather DNS Cache"
    write-host "Press 9 to gather Local Accounts and group membership"
    write-host "Press 10 to scan computer for executables and get file hash"
    write-host "Press 11 to input specific file path to get hash"
    write-host "press 12 to gather loaded Driver information"
    write-host "Press q to exit"
    $input = Read-Host
        switch ($Input) {
        '1' {
                systeminfo > $dir\compinfo.txt
            }
        '2' {
                Get-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run > $dir\reginfo.txt
                Get-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce >> $dir\reginfo.txt -Append
                Get-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run >> $dir\reginfo.txt -Append
                Get-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce >> $dir\reginfo.txt -Append
            }
        '3' {
                Get-EventLog -Newest 1000 -LogName Security | ft -AutoSize -wrap > $dir\seuritylog.txt
                Get-EventLog -Newest 1000 -LogName System | ft -AutoSize -wrap > $dir\SystemLog.txt
                Get-EventLog -Newest 1000 -LogName Application | ft -AutoSize -wrap > $dir\ApplicationLog.txt
            }
        '4' {
                Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table –AutoSize -wrap > $dir\InstalledSoftwareList.txt
            }
        '5' {
                netstat -nvb > $dir\NetConnections.txt
            }
        '6' {
                get-process | ft -AutoSize > $dir\Processlist.txt
            }
        '7' {
                reg query HKLM\SYSTEM\CurrentControlSet\Control\DeviceClasses /s /f FriendlyName > $dir\USBList.txt
            }
        '8' {
                ipconfig /displaydns > $dir\DNSCache.txt
            }
        '9' {
                $LocalGroup = Get-LocalGroup
                foreach ($member in $LocalGroup)
                {
                    $LocalGroupMember = Get-LocalGroupMember $member.Name
                    $member.Name | Out-File $dir\localgroup.txt -Append
                    $LocalGroupMember | Out-File $dir\localgroup.txt -Append
                }
            }
        '10'{
                Get-Childitem C:\ -File -Recurse -include *.exe, *.msi -ErrorAction Ignore | Get-FileHash -Algorithm MD5 -ErrorAction SilentlyContinue | FL | Out-File $dir\All_file_MDF_hash.txt
                #Get-Childitem C:\ -File -Recurse -Filter *.exe, *.msi -ErrorAction ignore | Get-FileHash -Algorithm SHA256 -ErrorAction SilentlyContinue | FL | Out-File $dir\All_file_SHA256_hash.txt
            }
        '11'{
                #work in progress
            }
        '12'{
                #work in progress
            }
        }
   }
 until ($input -eq 'q') 
 {
 }
