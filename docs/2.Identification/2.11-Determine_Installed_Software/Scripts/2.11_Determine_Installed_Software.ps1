Write-Host "Select Enumeration Method: "
Write-Host ""
Write-Host "  1: Single Remote Computer "
Write-Host "  2: List of Computers "
Write-Host "  3: Local Computer"
Write-Host "  4: PSinfo"
Write-Host ""
$choice = Read-Host -Prompt 'Select Action'

if ($choice -eq 1){
    $CN = Read-Host -Prompt 'Input computer name'
    $cred = Get-Credential
    Invoke-Command -cn $CN -Credential $cred -ScriptBlock {
    Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* 
    Get-ItemProperty HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* 
} |
 Select-Object DisplayName,DisplayVersion,Publisher,InstallDate,InstallLocation | Format-Table –AutoSize > C:\$CN'_software'.txt

}elseif ($choice -eq 2) {
    $Path = Read-Host -Prompt 'Enter file location'
    $cred = Get-Credential
    Invoke-Command -cn (Get-Content $Path) -Credential $cred -ScriptBlock {
    Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* 
    Get-ItemProperty HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* 
} |
 Select-Object PsComputerName,DisplayName,DisplayVersion,Publisher,InstallDate,InstallLocation | Format-Table –AutoSize > C:\Multiple_computer_software.txt

}elseif ($choice -eq 3) {
    Invoke-Command -ScriptBlock {
    Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* 
    Get-ItemProperty HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* 
} |
 Select-Object DisplayName,DisplayVersion,Publisher,InstallDate,InstallLocation | Format-Table –AutoSize > C:\localhost_software.txt

}elseif ($choice -eq 4) {
   $Path = Read-Host -Prompt 'Enter Computernames File Location'
   $computersToQuery = get-content $Path
   foreach ($computer in $computersToQuery)
        {Invoke-Command {.\PsInfo.exe -s Applications \\$computer >> C:\PSinfo.txt}}

}else {
    Write-host("Error: Number is not valid selection. Exiting.....")
}