# Prompt for Name, Number of VMs, and how many data disks are required.
$GBConvert = 1073741824
$VMName = Read-Host -Prompt "Enter the name for the VMs"
$Generation = Read-Host -Prompt "What Generation of VM (1 or 2)"
$VMmax = Read-Host -Prompt "Enter the number of VMs to create (1-10000)"
$OS = Read-Host -Prompt "Enter 1 for Server 2016, 2 for Server 2019, 3 for Lubuntu"
$PrimaryDisk = Read-Host -Prompt "Enter the Drive Letter for the VM Disk (Example C:)"
$Datadisknumber = Read-Host -Prompt "Enter the Number of Datadisks (Up to 4)"
if ($DatadiskNumber -ge 1){
    $1stDataDiskPath = Read-Host -Prompt "Enter the Drive Letter for the 1st Datadisk (Example C:)"
    }
if ($DatadiskNumber -ge 2){
    $2ndDataDiskPath = Read-Host -Prompt "Enter the Drive Letter for the 2nd Datadisk (Example C:)"
    }
if ($DatadiskNumber -ge 3){
        $3rdDataDiskPath = Read-Host -Prompt "Enter the Drive Letter for the 3rd Datadisk (Example C:)"
    }
if ($DatadiskNumber -ge 4){
        $4thDataDiskPath = Read-Host -Prompt "Enter the Drive Letter for the 4st Datadisk (Example C:)"
    }
if ($Datadisknumber -ne 0){
    [Int]$Datadisksize = Read-Host -Prompt "Enter the size of Datadisks in GB"
    [Int64]$DatadisksizeGB = $Datadisksize * $GBConvert
    }
$NumberofCores = Read-Host -Prompt "Enter the Number of Cores for each VM"
$Switch = Read-Host -Prompt "Enter the Name of the Switch for the VM"
# Create the number of VMs
for ($VMNumber = 1; $VMNumber -le $VMmax; $VMNumber++)
    {
        #Create VM's
        New-VM -Name $VMNAME$VMNumber -Generation $Generation -NewVHDPath $PrimaryDisk\VMs\$VMNAME$VMNumber.vhdx -NewVHDSizeBytes 80GB -Switch $Switch
        # Configure VM Memory
        if ($OS -eq 1){
            Add-VMDVDDrive -VMName $VMNAME$VMNumber -Path C:\ISOs\WindowsServer2016.iso
            }
        if ($OS -eq 2){
            Add-VMDVDDrive -VMName $VMNAME$VMNumber -Path C:\ISOs\WindowsServer2019.iso
            }
        if ($OS -eq 3){
            Add-VMDVDDrive -VMName $VMNAME$VMNumber -Path C:\ISOs\Lubuntu.iso
            }
        Set-VMProcessor $VMNAME$VMNumber -Count $NumberofCores -ExposeVirtualizationExtensions $true
        #Setup Variables for DVD and Primary Drive for Boot Order
        if ($Generation -eq 2){
            $DVDDrive = Get-VMDvdDrive $VMNAME$VMNumber
            $primaryDrive = Get-VMHardDiskDrive -VMName $VMNAME$VMNumber -ControllerLocation 0
            Set-VMFirmware $VMNAME$VMNumber -BootOrder $primaryDrive, $DVDDrive
            }
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