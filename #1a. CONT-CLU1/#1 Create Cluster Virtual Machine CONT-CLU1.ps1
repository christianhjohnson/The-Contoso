#Create Failover Cluster Nodes with Data Disks
for ($VMName = 1; $VMName -lt 3; $VMName++)
{
    New-VM -Name CONT-CLU$VMName -MemoryStartupBytes 4GB -Generation 2 -NewVHDPath E:\VMs\CONT-CLU$VMName.vhdx -NewVHDSizeBytes 40GB -Switch InternalSwitch
    Add-VMDVDDrive -VMName CONT-CLU$VMName -Path C:\ISOs\WindowsServer2016.iso
    $DVDDrive = Get-VMDvdDrive CONT-CLU$VMName
    $primaryDrive = Get-VMHardDiskDrive -VMName $VMName
    Set-VMFirmware CONT-CLU$VMName -BootOrder $primaryDrive, $DVDDrive
    New-VHD -Path C:\WitnessDisk\CLU$VMName\Witnessdisk.vhdx -Fixed SizeBytes 1GB
    New-VHD -Path F:\ClusterDisk\CLU$VMName\Clusterdisk1.vhdx -Dynamic SizeBytes 40GB
    New-VHD -Path H:\ClusterDisk\CLU$VMName\Clusterdisk2.vhdx -Dynamic SizeBytes 40GB
    Add-VMHardDiskDrive -VMName CONT-CLU$VMName -Path C:\WitnessDisk\CLU$VMName\Witnessdisk.vhdx
    Add-VMHardDiskDrive -VMName CONT-CLU$VMName -Path F:\ClusterDisk\CLU$VMName\Clusterdisk1.vhdx
    Add-VMHardDiskDrive -VMName CONT-CLU$VMName -Path H:\ClusterDisk\CLU$VMName\Clusterdisk2.vhdx
}

