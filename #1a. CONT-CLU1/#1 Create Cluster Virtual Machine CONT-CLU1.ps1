$VMNames = "CONT-CLU1","CONT-CLU2"
New-VM -Name $VMNames -MemoryStartupBytes 4GB -Generation 2 -NewVHDPath E:\VMs\$VMNames.vhdx -NewVHDSizeBytes 40GB -Switch Extswitch1
Add-VMDVDDrive -VMName $VMNames -Path C:\ISOs\WindowsServer2016.iso
$DVDDrive = Get-VMDvdDrive $VMNames
$primaryDrive = Get-VMHardDiskDrive -VMName $VMNames
Set-VMFirmware $VMNames -BootOrder $primaryDrive, $DVDDrive
