$VMName = "CONT-CLU1"
Add-VMHardDiskDrive -VMName $VMName -Path 'E:\VMs\CONT-CLU1\ Wintessdisk.vhdx'
for ($DiskNumber = 2; $DiskNumber -lt 5; $DiskNumber++)
{
Add-VMHardDiskDrive -VMName $VMName -Path "E:\VMs\CONT-CLU1\ Datadisk$Disknumber.vhdx"
}