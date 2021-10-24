#Create Virtual Machine Switch
New-VMSwitch -name Extswitch1  -NetAdapterName LAN -AllowManagementOS $true

#Create Cluster Virtual Machines
New-VM -Name "CONT-CLU1" -MemoryStartupBytes 4GB -Generation 2 -NewVHDPath E:\VMs\CONT-CLU1.vhdx -Path E:\VMData -NewVHDSizeBytes 40GB -Switch Extswitch1
New-VM -Name "CONT-CLU2" -MemoryStartupBytes 4GB -Generation 2 -NewVHDPath E:\VMs\CONT-CLU2.vhdx -Path E:\VMData -NewVHDSizeBytes 40GB -Switch Extswitch1


#Add DVD Drives
Add-VMDVDDrive -VMName "CONT-CLU1" -Path C:\ISOs\WindowsServer2016.iso 
Add-VMDVDDrive -VMName "CONT-CLU2" -Path C:\ISOs\WindowsServer2016.iso 


#Start VMs
Start-VM -Name "CONT-CLU1"
Start-VM -Name "CONT-CLU2"