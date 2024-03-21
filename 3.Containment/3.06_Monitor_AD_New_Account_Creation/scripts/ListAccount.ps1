<#
  This script requires the activedirectory module.
  To use the activedirectory module, you have to install the "RAS Tools" feature in Windows.
  Add roles and features > RSAT: Remote Access Management Tools > Install & Reboot
#>

$BaselineUserFile = "C:\Users\Administrator\Desktop\baseline"
$BaseDN = "DC=TEAM01,DC=TGT"
$ADServer = "Team01-DC01.team01.tgt"

$CurrentUsers = Get-ADUser -Filter * -SearchBase $BaseDN -Server $ADServer

function Create-Baseline {
  param (
    $File
  )

  Write-Output "Creating baseline file @ $File"
  [System.Management.Automation.PSSerializer]::Serialize($(Get-ADUser -Filter * -SearchBase $BaseDN -Server $ADServer)) > $File
}

function Compare-Users {
  param (
    $File
  )
  
  $Baseline = [System.Management.Automation.PSSerializer]::Deserialize($(Get-Content $File))
  $CurrentUsers = $(Get-ADUser -Filter * -SearchBase $BaseDN -Server $ADServer)
  $NEW_USER = $FALSE

  foreach($user in $CurrentUsers){
    if($Baseline.SID -notcontains $user.SID){ $user.Name; $NEW_USER = $TRUE }
  }

  $NEW_USER
}


if (-NOT(Test-Path -Path $BaselineUserFile -PathType Leaf)){
  Create-Baseline -File $BaselineUserFile
} else {
  Compare-Users -File $BaselineUserFile
}
