$i = 1 

do{ 

$pcpath = "C:\pc\" 

$pcfile = "pc_list.txt" 

$pcs = get-content $pcpath$pcfile 

$procentrydate = get-date -f "yyyy-MM-dd HH:mm:ss" 

foreach($pc in $pcs){ 

$procs = cmd /c wmic /node:$pc process get name,description,commandline,processid,parentprocessid /format:csv | convertfrom-csv 

    foreach($proc in $procs){ 

        [string]$pcname = $pc 

        $pname = $proc.name 

        #if($proc.name -match "0x1b0"){write-host "Chrome"} 

        $pcl = $proc.commandline.Replace(",","") 

        $pcpid = $proc.processid 

        $pcpar = $proc.parentprocessid 

        $pdes = $proc.Description 

         

        $procxml = @{ 

        "procentrydate" = $procentrydate 

        "node"= $pcname 

        "processname"= $pname 

        "commandline"= $pcl 

        "processid"= $pcpid 

        "parentprocessid"= $pcpar 

        "description"= $pdes 

        } 

        $procjson = $procxml | ConvertTo-Json 

        #write-host "" 

        #write-host $proc}} 

        invoke-restmethod -Method POST -Uri "SEC_ONION_IP_CHANGE_THIS:9200/response_process/process_entry" -Body $procjson -ContentType 'application/json'}} 

sleep 180  #180 seconds = 3 minutes; change according to your requirements. 

$i++ 

} 

while($i -gt 0) 