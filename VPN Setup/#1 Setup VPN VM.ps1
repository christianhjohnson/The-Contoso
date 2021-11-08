New-VM -Name CONT-VPN -MemoryStartupBytes 4GB -Generation 2 -NewVHDPath F:\VMs\CONT-VPN.vhdx -NewVHDSizeBytes 80GB -Switch InternalSwitch
    #Add Server 2016 ISO
    Add-VMDVDDrive -VMName CONT-VPN -Path C:\ISOs\WindowsServer2019.iso
    Set-VMProcessor CONT-VPN -Count 4 -ExposeVirtualizationExtensions $true
    #Setup Variables for DVD and Primary Drive for Boot Order
    $DVDDrive = Get-VMDvdDrive CONT-VPN
    $primaryDrive = Get-VMHardDiskDrive -VMName CONT-VPN
    Set-VMFirmware CONT-VPN -BootOrder $primaryDrive, $DVDDrive
    Add-VMNetworkAdapter -VMName CONT-VPN -Name "WAN"
    Connect-VMNetworkAdapter -VMName CONT-VPN -Name WAN -SwitchName ExternalSwitch