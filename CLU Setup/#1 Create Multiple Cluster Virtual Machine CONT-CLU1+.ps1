#Create Failover Cluster Nodes with Data Disks + add the disks to each VM
for ($VMNumber = 1; $VMNumber -lt 3; $VMNumber++)
    {
    New-VM -Name CONT-CLU$VMNumber -MemoryStartupBytes 4GB -Generation 2 -NewVHDPath F:\VMs\CONT-CLU$VMNumber.vhdx -NewVHDSizeBytes 80GB -Switch InternalSwitch
    #Add Server 2016 ISO
    Add-VMDVDDrive -VMName CONT-CLU$VMNumber -Path C:\ISOs\WindowsServer2019.iso
    Set-VMProcessor CONT-CLU$VMNumber -Count 4 -ExposeVirtualizationExtensions $true
    #Setup Variables for DVD and Primary Drive for Boot Order
    $DVDDrive = Get-VMDvdDrive CONT-CLU$VMNumber
    $primaryDrive = Get-VMHardDiskDrive -VMName CONT-CLU$VMNumber
    Set-VMFirmware CONT-CLU$VMNumber -BootOrder $primaryDrive, $DVDDrive
    #Create Witness and Data disk for Failover Cluter
    New-VHD -Path "C:\Clusterdisk0\CLU$VMNumber\Clusterdisk0.vhdx" -Fixed -SizeBytes 5GB
    New-VHD -Path "D:\ClusterDisk1\CLU$VMNumber\Clusterdisk1.vhdx" -Dynamic -SizeBytes 10GB 
    New-VHD -Path "E:\ClusterDisk2\CLU$VMNumber\Clusterdisk2.vhdx" -Dynamic -SizeBytes 10GB 
    # Add disks to VM
    Add-VMHardDiskDrive -VMName CONT-CLU$VMNumber -Path "C:\Clusterdisk0\CLU$VMNumber\Clusterdisk0.vhdx"
    Add-VMHardDiskDrive -VMName CONT-CLU$VMNumber -Path "D:\ClusterDisk1\CLU$VMNumber\Clusterdisk1.vhdx"
    Add-VMHardDiskDrive -VMName CONT-CLU$VMNumber -Path "E:\ClusterDisk2\CLU$VMNumber\Clusterdisk2.vhdx"
    }

