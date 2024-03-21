Get-NetFirewallRule -All | Export-Csv -path $env:HOMEPATH\Desktop\$((Get-Date).ToString('MM-dd-yy_hh_mm_ss')).csv
