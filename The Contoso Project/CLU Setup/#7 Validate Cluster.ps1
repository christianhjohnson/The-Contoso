$Clusters = "CONT-CLU1","CONT-CLU2"
Test-Cluster –Node $Clusters –Include "Storage Spaces Direct", "Inventory", "Network", "System Configuration"