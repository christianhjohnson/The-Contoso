#Create Witness and Datadisks for Failover Cluster
New-VHD -Path C:\WitnessDisk\CONT-CLU1\Witnessdisk.vhdx -Fixed SIzeBytes 1GB
New-VHD -Path F:\ClusterDisk\CONT-CLU1\Clusterdisk1.vhdx -Dynamic SIzeBytes 40GB
New-VHD -Path C:\ClusterDisk\CONT-CLU1\Clusterdisk2.vhdx -Dynamic SIzeBytes 40GB
New-VHD -Path C:\WitnessDisk\CONT-CLU2\Witnessdisk.vhdx -Fixed SIzeBytes 1GB
New-VHD -Path F:\ClusterDisk\CONT-CLU2\Clusterdisk1.vhdx -Dynamic SIzeBytes 40GB
New-VHD -Path C:\ClusterDisk\CONT-CLU2\Clusterdisk2.vhdx -Dynamic SIzeBytes 40GB