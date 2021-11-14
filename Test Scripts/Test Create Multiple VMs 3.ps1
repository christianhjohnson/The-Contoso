# Prompt for Name, Number of VMs, and how many data disks are required.
$VMName = Read-Host -Prompt "Enter the name for the VMs"
$VMmax = Read-Host -Prompt "Enter the number of VMs to create (1-10000)"
$PrimaryDisk = Read-Host -Prompt "Enter the Drive Letter for the VM Disk (Example C:)"
$Datadisknumber = Read-Host -Prompt "Enter the Number of Datadisks (Up to 4)"
$1stDataDiskPath = Read-Host -Prompt "Enter the Drive Letter for the 1st Datadisk (Example C:)"
$2ndDataDiskPath = Read-Host -Prompt "Enter the Drive Letter for the 2st Datadisk (Example C:)"
$3rdDataDiskPath = Read-Host -Prompt "Enter the Drive Letter for the 3st Datadisk (Example D:)"
$4thDataDiskPath = Read-Host -Prompt "Enter the Drive Letter for the 4st Datadisk (Example E:)"
#$MBConvert = 100000
$GBConvert = 1073741824
[Int]$Datadisksize = Read-Host -Prompt "Enter the size of Datadisks in GB"
[Int64]$DatadisksizeGB = $Datadisksize * $GBConvert
$NumberofCores = Read-Host -Prompt "Enter the Number of Cores for each VM"
#[Int64]$MinMemorySizeMB = Read-Host -Prompt "Enter the Minimum Size of Memory in MB (Examples 1024, 4096, 8182)"
#[Int64]$MinMemorySizeMB = $MinMemorySizeKB * $MBConvert
#[Int64]$StartupMemoryMB = Read-Host -Prompt "Enter the Startup Memory in MB"
#[Int64]$StartupMemoryMB = $StartupMemoryKB * $MBConvert
#[Int64]$MaxMemoryMB = Read-Host -Prompt "Enter the Maximum Size of Memory in MB"
#[Int64]$MaxMemoryMB = $MaxMemoryKB * $MBConvert
$Switch = Read-Host -Prompt "Enter the Name of the Switch for the VM"
# Create the number of VMs
for ($VMNumber = 1; $VMNumber -le $VMmax; $VMNumber++)
    {
        #Create VM's
        New-VM -Name $VMNAME$VMNumber -Generation 2 -NewVHDPath $PrimaryDisk\VMs\$VMNAME$VMNumber.vhdx -NewVHDSizeBytes 80GB -Switch $Switch
        # Configure VM Memory
        Add-VMDVDDrive -VMName $VMNAME$VMNumber -Path C:\ISOs\WindowsServer2019.iso
        Set-VMProcessor $VMNAME$VMNumber -Count $NumberofCores -ExposeVirtualizationExtensions $true
        #Setup Variables for DVD and Primary Drive for Boot Order
        $DVDDrive = Get-VMDvdDrive $VMNAME$VMNumber
        $primaryDrive = Get-VMHardDiskDrive -VMName $VMNAME$VMNumber -ControllerLocation
        Set-VMFirmware $VMNAME$VMNumber -BootOrder $primaryDrive, $DVDDrive
        #Set-VM $VMNAME$VMNumber -DynamicMemory -MemoryMinimumBytes $MinMemorySizeMB -MemoryMaximumBytes $MaxMemoryMB -MemoryStartupBytes -$StartupMemoryMB 
        Set-VMMemory $VMNAME$VMNumber -DynamicMemoryEnabled $true
    #Create Datadisks
    if ($Datadisknumber -ge 1)
            {
            New-VHD -Path "$1stDataDiskPath\VMDataDisks\$VMNAME$VMNumber\Datadisk1.vhdx" -Dynamic -SizeBytes $DatadisksizeGB
            Add-VMHardDiskDrive -VMName $VMNAME$VMNumber -Path "$1stDataDiskPath\VMDataDisks\$VMNAME$VMNumber\Datadisk1.vhdx"
            }
    if ($Datadisknumber -ge 2)
            {
            New-VHD -Path "$2ndDataDiskPath\VMDataDisks\$VMNAME$VMNumber\Datadisk2.vhdx" -Dynamic -SizeBytes $DatadisksizeGB
            Add-VMHardDiskDrive -VMName $VMNAME$VMNumber -Path "$2ndDataDiskPath\VMDataDisks\$VMNAME$VMNumber\Datadisk2.vhdx"
            }
    if ($Datadisknumber -ge 3)
            {
            New-VHD -Path "$3rdDataDiskPath\VMDataDisks\$VMNAME$VMNumber\Datadisk3.vhdx" -Dynamic -SizeBytes $DatadisksizeGB
            Add-VMHardDiskDrive -VMName $VMNAME$VMNumber -Path "$3rdDataDiskPath\VMDataDisks\$VMNAME$VMNumber\Datadisk3.vhdx"
            }
     if ($Datadisknumber -eq 4)
            {
            New-VHD -Path "$4thDataDiskPath\VMDataDisks\$VMNAME$VMNumber\Datadisk4.vhdx" -Dynamic -SizeBytes $DatadisksizeGB
            Add-VMHardDiskDrive -VMName $VMNAME$VMNumber -Path "$4thDataDiskPath\VMDataDisks\$VMNAME$VMNumber\Datadisk4.vhdx"
            }
    }


