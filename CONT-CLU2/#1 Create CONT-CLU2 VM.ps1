#Create CONT-CLU2 VM
New-VM -Name "CONT-CLU2" -MemoryStartupBytes 4GB -Generation 2 -NewVHDPath E:\VMs\CONT-CLU2.vhdx -Path E:\VMData -NewVHDSizeBytes 40GB -Switch Extswitch1

#Add DVD Drive
Add-VMDVDDrive -VMName "CONT-CLU2" -Path C:\ISOs\WindowsServer2016.iso 

#Start VM
Start-VM -Name "CONT-CLU2"