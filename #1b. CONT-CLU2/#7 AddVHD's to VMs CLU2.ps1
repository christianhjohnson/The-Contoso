$VMName = "CONT-CLU2"
Add-VMHardDiskDrive -VMName $VMName -Path 'E:\VMs\CONT-CLU2\ Wintessdisk.vhdx'
for ($DiskNumber = 2; $DiskNumber -lt 5; $DiskNumber++)
{
Add-VMHardDiskDrive -VMName $VMName -Path "E:\VMs\CONT-CLU2\ Datadisk$Disknumber.vhdx"
}