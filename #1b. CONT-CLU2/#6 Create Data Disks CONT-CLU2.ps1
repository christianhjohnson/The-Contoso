$Folder = "E:\VMs\CONT-CLU2\"
New-VHD -Path “$Folder Wintessdisk.vhdx” -Dynamic -SizeBytes 1GB
for ($DiskNumber = 2; $DiskNumber -lt 5; $DiskNumber++)
{
New-VHD -Path “$Folder Datadisk$DiskNumber.vhdx” -Dynamic -SizeBytes 40GB
}