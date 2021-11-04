#Create Failover Cluster Nodes with Data Disks + add the disks to each VM
for ($VMNumber = 1; $VMNumber -lt 3; $VMNumber++)
    {
    New-VM -Name CONT-CLU$VMNumber -MemoryStartupBytes 4GB -Generation 2 -NewVHDPath E:\VMs\CONT-CLU$VMNumber.vhdx -NewVHDSizeBytes 40GB -Switch InternalSwitch
    #Add Server 2016 ISO
    Add-VMDVDDrive -VMName CONT-CLU$VMNumber -Path C:\ISOs\WindowsServer2016.iso
    #Setup Variables for DVD and Primary Drive for Boot Order
    $DVDDrive = Get-VMDvdDrive CONT-CLU$VMNumber
    $primaryDrive = Get-VMHardDiskDrive -VMName CONT-CLU$VMNumber
    Set-VMFirmware CONT-CLU$VMNumber -BootOrder $primaryDrive, $DVDDrive
    #Create Witness and Data disk for Failover Cluter
    New-VHD -Path "C:\WitnessDisk\CLU$VMNumber\Witnessdisk.vhdx" -Fixed -SizeBytes 1GB
    New-VHD -Path "F:\ClusterDisk1\CLU$VMNumber\Clusterdisk1.vhdx" -Dynamic -SizeBytes 40GB 
    New-VHD -Path "H:\ClusterDisk2\CLU$VMNumber\Clusterdisk2.vhdx" -Dynamic -SizeBytes 40GB 
    # Add disks to VM
    Add-VMHardDiskDrive -VMName CONT-CLU$VMNumber -Path "C:\WitnessDisk\CLU$VMNumber\Witnessdisk.vhdx"
    Add-VMHardDiskDrive -VMName CONT-CLU$VMNumber -Path "F:\ClusterDisk1\CLU$VMNumber\Clusterdisk1.vhdx"
    Add-VMHardDiskDrive -VMName CONT-CLU$VMNumber -Path "H:\ClusterDisk2\CLU$VMNumber\Clusterdisk2.vhdx"
    }

