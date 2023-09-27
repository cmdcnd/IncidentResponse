<#

.Synopsis

Given an incident response workstation with PowerShell configured, Domain Administrator-level credentials, and a target Domain. Must have knowledge of domain given from network owner. 

.Description 

ID.AM-4.6 Evaluate AD Configurations using Powershell. All work will be done inside CyberSurfer directory. If the directory doesn't exist, it will be created with relevant log files inside. 

#>
param(
    [parameter(HelpMessage= "The host to connect to")][string] $Target,
    [parameter(HelpMessage= "File to the list of servers")][string] $FileScope
)

## Globals
$TargetArray = [System.Collections.ArrayList]@()
$CurrentDirectory = pwd
$OutputDirectory = "\CyberSurfers\"
$OutputFile = "CyberSurfers-ID.AM-4.6-"
$OutputErrorLog = "CyberSurfers-ID.AM-4.6-ErrorLog.log"

$CurrentDirectory = $CurrentDirectory.Path + $OutputDirectory

## Start the WinRmService
Start-Service winrm

## Add all host to trusted host winrm
Set-Item WSMan:\localhost\Client\TrustedHosts -Value '*' -Force

function GetHostsFromFile([string]$FileName)
{
    $Targets = Get-Content -Path $FileName

    Foreach ($x in $Targets)
    {
        $x = $x.Trim()
        
        $TargetArray.Add($x) | Out-Null
    }
}

## Where any arguments supplied?
if ($PSBoundParameters.Values.Count -eq 0)
{
    Get-Help $MyInvocation.MyCommand.Definition
    return
}

## Prompt for domain credentials
$cred = Get-Credential

## Set the working directory
if (! (Test-Path ($CurrentDirectory)))
{
    New-Item -type Directory -Path ($CurrentDirectory) | Out-Null
}

## If a scope is specified, throw it in an array
if ($FileScope)
{
    ## Does the user's file exist?
    if (! (Test-Path $FileScope -PathType Leaf))
    {
        Write-Error ("{0} does not exist!" -f ($FileScope))
        exit 1 
    }

    ## Populate the array list with the scope
    GetHostsFromFile($FileScope)
}

## If a target is specified as well, throw it in the array too
if ($Target)
{
    $TargetArray.Add($Target) | Out-Null
}

## Iterate through everything 
Foreach($x in $TargetArray)
{
    try {
        $FQDN = [System.Net.Dns]::GetHostByName($x).HostName
    } catch {
        Write-Error("{0}: {1}" -f ($x, $_))
        "$($x): $($_)" | Out-File -Append ($CurrentDirectory + $OutputErrorLog)
        continue
    }

    ## Create the string for the logfile
    $LogFileName = $CurrentDirectory + $OutputFile
    $LogFileName += $FQDN.Split(".")[0] + "_"
    $LogFileName += (Get-Date -UFormat "%s") + ".log"

    Write-Host("[+] Querying {0}" -f ($FQDN))
    Write-Host("[+] Writing to {0}" -f ($LogFileName))

    ## Extract domain from FQDN
    $Domain = $FQDN.Substring($FQDN.IndexOf(".") + 1)
    
    ## Now to the meat of the script
    "-------- Domain Controllers -------" | Out-File -Append $LogFileName
    nltest /dclist:$Domain | Out-File -Append $LogFileName

    "`n`n-------- Domain Groups ------------" | Out-File -Append $LogFileName
    $DomainObject = Get-ADGroup -Filter *
    $DomainObject | Select Name,DistinguishedName | ft | Out-File -Append $LogFileName

    "`n`n-------- Domain OU Structure ------" | Out-File -Append $LogFileName
    Get-ADOrganizationalUnit -Filter * | ft Name,DistinguishedName -AutoSize | Out-File -Append $LogFileName

    "`n`n-------- Domain Servers -----------" | Out-File -Append $LogFileName
    Get-ADComputer -Filter 'operatingsystem -like "*server*" -and enabled -eq "true"' -Properties Name,OperatingSystem,OperatingSystemVersion,IPv4Address | Select-Object -Property Name,Operatingsystem,OperatingSystemVersion,IPv4address | ft | Out-File -Append $LogFileName

    "`n`n-------- Domain Computers ---------" | Out-File -Append $LogFileName
    Get-ADComputer -Filter 'operatingsystem -notlike "*server*" -and enabled -eq "true"' -Properties Name,OperatingSystem,OperatingSystemVersion,IPv4Address | Select-Object -Property Name,OperatingSystem,OperatingSystemVersion,IPv4Address | ft | Out-File -Append $LogFileName

    "`n`n-------- Domain Users -------------" | Out-File -Append $LogFileName
    Get-ADUser -Filter {Enabled -eq "True"} -Properties * | where {$_.GivenName -ne $NULL} | Select-Object Name,SamAccountName,Modified,MemberOf,DistinguishedName | Out-File -Append $LogFileName
}

Write-Host("[+] Done!")