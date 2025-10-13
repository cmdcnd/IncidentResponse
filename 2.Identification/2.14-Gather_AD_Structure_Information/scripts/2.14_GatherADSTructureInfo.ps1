<#

.Description

ID.AM-2.2 Gathering AD Structure information

#>

## This recurses the OU of the AD
function Recurse-OU ([string]$dn, $level = 1)
{
    if ($level -eq 1)
    {
        ## Get the head of the structure
        $dn | Out-File -Append $OutputFile
    }

    ## Get the domain with Get-ADOrganizationalUnit
    Get-ADOrganizationalUnit -Filter * -SearchBase $dn -SearchScope OneLevel |
        
        Sort-Object -Property distinguishedName |
        ForEach-Object {
            
            ## Print out OUs of the AD for it's structure
            $components = ($_.distinguishedname).split(',')
            
            "$('--' * $level + ">") $($components[0])" | Out-File -Append $OutputFile
            Recurse-OU -dn $_.distinguishedname -level ($level+1)
        }
}

## Dynamically get current location to avoid hardcoding
$CurrentDirectory = pwd
$OutDirectory = "\\CyberSurfers\\"

## Logfile will be CyberSurfers_ACL_1234567890.12345.txt
$OutputFile = "CyberSurfers_ACL_"

## Does the CyberSurfers directory exist??
if (!(Test-Path ($CurrentDirectory.Path + $OutDirectory)))
{
    New-Item -type Directory -Path ($CurrentDirectory.Path + $OutDirectory) | Out-Null
}

$CurrentDirectory = $CurrentDirectory.Path + $OutDirectory
$OutputFile = $CurrentDirectory + $OutputFile + (Get-Date -UFormat "%s") + ".txt"

## This file shouldn't exist because milliseconds, so no need to check
New-Item -Path $OutputFile -ItemType File | Out-Null

## TODO: Get Acls of OU?
## (Get-Acl -Path "AD:\$($addomain.distinguishedName)").Access

## Get current domain
$addomain = Get-ADDomain

## Write to logfile
Write-Output("[+] Domain's infrastructure master: {0}" -f ($addomain.InfrastructureMaster)) | Out-File -Append $OutputFile

Write-Host("[+] Getting Active Directory structure to {0}..." -f ($OutputFile))
"[+] The Active Directory strucure as follows:" | Out-File -Append $OutputFile

## Write the domain structure to logfile
Recurse-OU -dn $addomain.distinguishedName
Write-Host("[+] Done!")