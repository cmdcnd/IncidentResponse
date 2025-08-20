## Stop the script if something goes wrong rather than continue
$ErrorActionPreference = "Stop"

## Get all the subcategory information to iterate through all and enable them dynamically
$AuditPolicySubcategories = auditpol /get /category:* /r | Where-Object { -not [String]::IsNullOrEmpty($_) } | ConvertFrom-Csv

Write-Host ("`n`t--==[[ DE.AE-1.2 Enable Account Usage Auditing ]]==--`n")
Write-Host ("[+] There are {0} categories/subcategories." -f ($AuditPolicySubcategories.Count))

foreach ($category in $AuditPolicySubcategories)
{
    ## Doing it like this because it doesnt like $category.Subcategory directly??
    ## String requires double quotes for the command
    $PolicyName = '"{0}"' -f $category.Subcategory

    Write-Host ("[+] Enabling logs for success and failure for: {0}" -f ($category.Subcategory))
    Try
    {
        $test = auditpol /set /subcategory:$PolicyName /success:enable /failure:enable | Out-String
    }
    Catch
    {
        Write-Error("{0} Failed at enabling logs for {1}" -f ($_.Exception.Message, $category.Subcategory))
    }
}

####################################
## !!!!!!!! Get-EventLog !!!!!!!! ##
####################################
##
## Get-EventLog uses a Win32 API that is deprecated which may not give accurate results
## https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-eventlog?view=powershell-5.1
## It mentions to use Get-WinEvent cmdlet instead, but does not work on my Windows Server 2019 build 1809 or on 
## the server that is set up on the range
## Unable to test on the range
## Now onto the log information
##
####################################
####################################

$LogInformation = Get-EventLog -List
Write-Host("[+] There are {0} available logs:" -f ($LogInformation.Count))
for ($index = 0; $index -lt $LogInformation.Count; $index++)
{
    Write-Host ("`t--> Information for {0}" -f ($LogInformation[$index].Log))
    Write-Host ("`t`t`tOverflowAction: {0}" -f ($LogInformation[$index].OverflowAction))
}