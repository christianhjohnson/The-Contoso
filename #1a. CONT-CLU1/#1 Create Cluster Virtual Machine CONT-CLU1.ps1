#Create Failover Cluster Nodes with Data Disks + add the disks to each VM
for ($VMNumber = 1; $VMNumber -lt 3; $VMNumber++)
{
    New-VM -Name CONT-CLU$VMNumber -MemoryStartupBytes 4GB -Generation 2 -NewVHDPath E:\VMs\CONT-CLU$VMNumber.vhdx -NewVHDSizeBytes 40GB -Switch InternalSwitch
    Add-VMDVDDrive -VMName CONT-CLU$VMNumber -Path C:\ISOs\WindowsServer2016.iso
    $DVDDrive = Get-VMDvdDrive CONT-CLU$VMNumber
    $primaryDrive = Get-VMHardDiskDrive -VMName CONT-CLU$VMNumber
    Set-VMFirmware CONT-CLU$VMNumber -BootOrder $primaryDrive, $DVDDrive
    New-VHD -Path "C:\WitnessDisk\CLU$VMNumber\Witnessdisk.vhdx" -Fixed -SizeBytes 1GB
    New-VHD -Path "F:\ClusterDisk\CLU$VMNumber\Clusterdisk1.vhdx" -Dynamic -SizeBytes 40GB 
    New-VHD -Path "H:\ClusterDisk\CLU$VMNumber\Clusterdisk2.vhdx" -Dynamic -SizeBytes 40GB 
    Add-VMHardDiskDrive -VMName CONT-CLU$VMNumber -Path "C:\WitnessDisk\CLU$VMNumber\Witnessdisk.vhdx"
    Add-VMHardDiskDrive -VMName CONT-CLU$VMNumber -Path "F:\ClusterDisk\CLU$VMNumber\Clusterdisk1.vhdx"
    Add-VMHardDiskDrive -VMName CONT-CLU$VMNumber -Path "H:\ClusterDisk\CLU$VMNumber\Clusterdisk2.vhdx"
}

