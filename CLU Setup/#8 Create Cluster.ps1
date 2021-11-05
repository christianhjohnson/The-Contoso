$Clusters = "CONT-CLU1","CONT-CLU2"
New-Cluster –Name "Cluster" –Node $Clusters -StaticAddress 192.168.1.170 –NoStorage