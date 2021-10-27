New-VM -Name "CONT-CLU1" -MemoryStartupBytes 4GB -Generation 2 -NewVHDPath E:\VMs\CONT-CLU1.vhdx -NewVHDSizeBytes 40GB -Switch Extswitch1
Add-VMDVDDrive -VMName "CONT-CLU1" -Path C:\ISOs\WindowsServer2016.iso
$DVDDrive = Get-VMDvdDrive "CONT-CLU1"
$primaryDrive = Get-VMHardDiskDrive -VMName "CONT-CLU1"
Set-VMFirmware "CONT-CLU1" -BootOrder $primaryDrive, $DVDDrive
