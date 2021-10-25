New-VM -Name "CONT-CLU2" -MemoryStartupBytes 4GB -Generation 2 -NewVHDPath E:\VMs\CONT-CLU2.vhdx -NewVHDSizeBytes 40GB -Switch Extswitch1
Add-VMDVDDrive -VMName "CONT-CLU2" -Path C:\ISOs\WindowsServer2016.iso
$DVDDrive = Get-VMDvdDrive "CONT-CLU2"
$primaryDrive = Get-VMHardDiskDrive -VMName "CONT-CLU2"
Set-VMFirmware "CONT-CLU2" -BootOrder $primaryDrive, $DVDDrive