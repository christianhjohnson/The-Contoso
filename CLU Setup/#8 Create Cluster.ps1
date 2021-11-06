$Clusters = "CONT-CLU1","CONT-CLU2"
$Clutername = "Cluster"
New-Cluster –Name $Clutername –Node $Clusters -StaticAddress 192.168.1.170 –NoStorage -Verbose
Set-ClusterQuorum -DiskWitness "Witness Disk 1"
Enable-ClusterS2D -Verbose