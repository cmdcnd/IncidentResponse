$i = 1 

do{ 

$pcpath = "C:\pc\" 

$pcfile = "pc_list.txt" 

$pcs = get-content $pcpath$pcfile 

$serventrydate = get-date -f "yyyy-MM-dd HH:mm:ss" 

foreach($pc in $pcs){ 

$svcfile = $pc + "_services.csv" 

$svcs = cmd /c wmic /node:$pc service get caption,displayname,installdate,name,pathname,processid,servicetype,started,startmode,startname,state,status /format:csv | convertfrom-csv 

foreach($svc in $svcs){ 

    $snode = $svc.node 

    $scap = $svc.caption 

    $sdisp = $svc.displayname 

    [string]$sinst = $svc.installdate 

    $sname = $svc.name 

    $spath = $svc.pathname 

    $sprocid = $svc.processid 

    $stype = $svc.ServiceType 

    $start = $svc.Started 

    $smode = $svc.StartMode 

    $starnm = $svc.StartName 

    $sstate = $svc.State 

    $sstatus = $svc.Status 

    $svcxml = @{ 

        "serviceentrydate" = $serventrydate 

        "node" = $snode 

        "caption" = $scap 

        "displayname" = $sdisp 

        "installdate" = $sinst 

        "servicename" = $sname 

        "pathname" = $spath 

        "processid" = $sprocid 

        "servicetype" = $stype 

        "started" = $start 

        "startmode" = $smode 

        "startname" = $starnm 

        "state" = $sstate 

        "status" = $sstatus 

        } 

    $svcjson = $svcxml | convertto-json 

    invoke-restmethod -Method POST -Uri "SEC_ONION_IP_CHANGE_THIS:9200/baz19_service/service_entry" -Body $svcjson -ContentType 'application/json'}} 

    sleep 180 

$i++ 

} 

while($i -gt 0) 