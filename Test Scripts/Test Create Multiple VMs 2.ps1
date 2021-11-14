# Prompt for Name, Number of VMs, and how many data disks are required.
$VMName = Read-Host -Prompt "Enter the name for the VMs"
$VMmax = Read-Host -Prompt "Enter the number of VMs to create"
$Datadisknumber = Read-Host -Prompt "Enter the Number of Datadisks (Up to 3)"
$DatadisksizeGB = Read-Host -Prompt "Enter the size of Datadisks"
$NumberofCores = Read-Host -Prompt "Enter the Number of Cores for the VM"
$Switch = Read-Host -Prompt "Enter the Name of the Switch for the VM"
# Create the number of VMs
for ($VMNumber = 1; $VMNumber -lt $VMmax; $VMNumber++)
    {
    New-VM -Name $VMNAME$VMNumber -MemoryStartupBytes 4GB -Generation 2 -NewVHDPath F:\VMs\$VMNAME$VMNumber.vhdx -NewVHDSizeBytes 80GB -Switch $Switch
    Add-VMDVDDrive -VMName $VMNAME$VMNumber -Path C:\ISOs\WindowsServer2019.iso
    Set-VMProcessor $VMNAME$VMNumber -Count $NumberofCores -ExposeVirtualizationExtensions $true
    #Setup Variables for DVD and Primary Drive for Boot Order
    $DVDDrive = Get-VMDvdDrive $VMNAME$VMNumber
    $primaryDrive = Get-VMHardDiskDrive -VMName $VMNAME$VMNumber
    Set-VMFirmware $VMNAME$VMNumber -BootOrder $primaryDrive, $DVDDrive
    #Create Witness and Data disk for Failover Cluter
    if ($Datadisknumber -ge 1)
        {
        New-VHD -Path "C:\$VMNAME$VMNumber\Datadisk1.vhdx" -Dynamic -SizeBytes $DatadisksizeGB
        Add-VMHardDiskDrive -VMName $VMNAME$VMNumber -Path "C:\$VMNAME$VMNumber\Datadisk1.vhdx"
        }
    if ($Datadisknumber -ge 2)
        {
        New-VHD -Path "D:\$VMNAME$VMNumber\Datadisk2.vhdx" -Dynamic -SizeBytes $DatadisksizeGB
        Add-VMHardDiskDrive -VMName $VMNAME$VMNumber -Path "D:\$VMNAME$VMNumber\Datadisk2.vhdx"
        }
    if ($Datadisknumber -eq 3)
        {
         New-VHD -Path "E:\$VMNAME$VMNumber\Datadisk3.vhdx" -Dynamic -SizeBytes $DatadisksizeGB
         Add-VMHardDiskDrive -VMName $VMNAME$VMNumber -Path "E:\$VMNAME$VMNumber\Datadisk3.vhdx"
        }
    }
 
   


