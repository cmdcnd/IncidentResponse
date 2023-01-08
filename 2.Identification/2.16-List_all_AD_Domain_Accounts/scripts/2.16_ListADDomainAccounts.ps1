<#

.Description

ID.TO-3.9 List all AD domain accounts

#>

## Dynamically get current location to avoid hardcoding
$CurrentDirectory = pwd
$OutDirectory = "\CyberSurfers\"

## Logfile will be AD_Domain_Accounts_123456789.txt
$OutputFile = "AD_Domain_Accounts_"

## Does the CyberSurfers directory exist??
if (!(Test-Path ($CurrentDirectory.Path + $OutDirectory)))
{
    New-Item -type Directory -Path ($CurrentDirectory.Path + $OutDirectory) | Out-Null
}

$CurrentDirectory = $CurrentDirectory.Path + $OutDirectory
$OutputFile = $CurrentDirectory + $OutputFile + (Get-Date -UFormat "%s") + ".txt"

## This file shouldnt exist because milliseconds so no need to check
New-Item -Path $OutputFile -ItemType File | Out-Null

## Get current DC name
$dc = Get-ADDomainController
Write-Host ("[+] Current Domain: {0}" -f ($dc.Domain))

<#
https://docs.microsoft.com/en-us/powershell/module/addsadministration/get-aduser?view=win10-ps
-DistinguishedName, $dc.DistinguishedName
-GivenName, $dc.GivenName
-Name, $dc.Name, and so on
-ObjectClass,
-ObjectGUID,
-SamAccountName
-SID
-Surname
-UserPrincipalName
#>

## Save the Get-ADUser object to dcUsers
$dcUsers = Get-ADUser -Filter *

Write-Host("[+] There are {0} users in {1}" -f ($dcUsers.SamAccountName.Length, $dc.Domain))

## Write all users to the logfile
Write-Host("[+] Writing domain users to {0}..." -f ($OutputFile))
$dcUsers | Out-File $OutputFile
Write-Host("[+] Done!")