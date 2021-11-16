$Computers = "CONT-CLU1","CONT-CLU2"
$Cred = Get-Credential Administrator
Invoke-Command -ComputerName $Computers -Credential $Cred -Scriptblock { Enable-ClusterStorageSpacesDirect -PoolFriendlyName "Clusterpool" }