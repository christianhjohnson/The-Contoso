<# Super VM Creation Script
This scripts assumes that the server 2016, 2019 and lubuntu ISO's are located 
In the C:\ISO\ folder and are named:
WindowsServer2016 or WindowsServer2016 or Lubuntu
#>
# GB Convert is used to convert the input from bytes to GB in question for size of drive
$GBConvert = 1073741824
# Ask for name of VM(s)
$VMName = Read-Host -Prompt "Enter the name for the VMs"
# IF VM is 1st Generation sets up a if command to bypass the VM Firmware options
$Generation = Read-Host -Prompt "What Generation of VM (1 or 2)"
# Asks how many VMs will created, adds the number of the VM after the VM automatically
$VMmax = Read-Host -Prompt "Enter the number of VMs to create (1-10000)"
# Asks where the VM file will be located, creates it own subfolder VMs
$PrimaryDisk = Read-Host -Prompt "Enter the Drive Letter for the VM Disk (Example F:)"
# Asks for the size of the primary hard drive - Int commands server to convert the input from
# a Int32 to Int64 as required by the VM size in the create in bytes command which requires an
# Int64 value
[Int]$VMDrivesize = Read-Host -Prompt "Enter Size of VHD hard drive in GB"
[Int64]$VMDrivesizeGB = $VMDrivesize * $GBConvert
# Sets up OS for installation, presumes all ISO's are in same directory
$OS = Read-Host -Prompt "Enter 1 for Server 2016 OS, 2 for Server 2019 OS, 3 for Lubuntu OS"
# Asks the number of datadisks per VM then which sets up a series of if-then statements below
$Datadisknumber = Read-Host -Prompt "Enter the Number of Datadisks (Up to 4)"

# Sets up if commands to create the number of data disks, and ask for location of each disk.
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
# If Datadisk selection = 0 then bypass the size of datadisk question
if ($Datadisknumber -ne 0){
    [Int]$Datadisksize = Read-Host -Prompt "Enter the size of Datadisks in GB"
    [Int64]$DatadisksizeGB = $Datadisksize * $GBConvert
    }
$NumberofCores = Read-Host -Prompt "Enter the Number of Cores for each VM"
# Prompt for Switch Name
$VMSwitches = Get-VMSwitch | Format-List "Name","SwitchType"
Write-Output $VMSwitches
# Write-Host = "The following VMSwitches are available:" $VMSwitches
$Switch = Read-Host -Prompt "Enter the Name of the Switch for the VM"
# Determines if Switch is Valid, if not prompts for switch creation
$AvailableSwitch = Get-VMSwitch
if ( $AvailableSwitch -notcontains $Switch ){
    $NewSwitch = Read-Host "$Switch does not exist, would you like to create the switch?"
}
# If switch is being created asks for type of switch
if ( $NewSwitch -contains "Y" ){
    $SwitchType = Read-Host "Enter switch type: 1-Private, 2-Internal, 3-External"
    if ( $SwitchType -eq 1 ){
        New-VMSwitch -name $Switch -SwitchType Private
        }
    if ( $SwitchType -eq 2 ){
        New-VMSwitch -name $Switch -SwitchType Internal
        }
    if ( $SwitchType -eq 3){
        $NIC = Get-NetAdapter -Physical | Select-Object Name,InterfaceDescription | Format-List -Property "Name","Interface Description"
        Write-Output "Here is a list of the NIC's available:" $NIC
        $VMExternalInterface = Read-Host "Enter the name of the NIC to attach the external switch (With Spaces)"
        New-VMSwitch -name $Switch -AllowManagementOS $true -NetAdapterName $VMExternalInterface
        }
    }
# If doesn't want to create switch the script stops
if ( $NewSwitch -contains "N"){
    Write-Output "Please configure a virtual switch then restart script"
    Break Script
}
# Create the number of VMs
for ($VMNumber = 1; $VMNumber -le $VMmax; $VMNumber++)
    {
        #Create VM's
        Try { New-VM -Name $VMNAME$VMNumber -Generation $Generation -NewVHDPath $PrimaryDisk\VMs\$VMNAME$VMNumber.vhdx -NewVHDSizeBytes $VMDrivesizeGB -Switch $Switch 
        }
        catch 
        { Write-Output "Switch name not recognized, please check name and re-run script"
        }
        # Configure VM operating systems according to previous question
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
        #Setup Variables for DVD and Primary Drive for Boot Order only if Gen 2
        if ($Generation -eq 2){
            $DVDDrive = Get-VMDvdDrive $VMNAME$VMNumber
            $primaryDrive = Get-VMHardDiskDrive -VMName $VMNAME$VMNumber -ControllerLocation 0
            Set-VMFirmware $VMNAME$VMNumber -BootOrder $primaryDrive, $DVDDrive
            }
        # no longer needed Set-VM $VMNAME$VMNumber -DynamicMemory -MemoryMinimumBytes $MinMemorySizeMB -MemoryMaximumBytes $MaxMemoryMB -MemoryStartupBytes -$StartupMemoryMB 
        Set-VMMemory $VMNAME$VMNumber -DynamicMemoryEnabled $true
    #Create Datadisks according to the number needed.
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