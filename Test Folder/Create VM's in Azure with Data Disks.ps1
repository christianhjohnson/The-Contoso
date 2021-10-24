#Username and Password string
$cred = Get-Credential -Message "Enter a username and password for the virtual machine."

#Create new resource group
New-AzResourceGroup -Name TheContosoProject -Location eastus

#Set up openports parameter
$openports = "3389"

#Create New VM
New-AzVM -ResourceGroupName TheContosoProject -Name ContosoFS1 -Location eastus -Credential $cred -OpenPorts $openports

#Add Data disks
$VirtualMachine = Get-AzVM -ResourceGroupName "TheContosoProject" -Name "ContosoFS1"
Add-AzVMDataDisk -VM $VirtualMachine -Name "FS1Datadisk1" -LUN 0 -Caching ReadOnly -DiskSizeinGB 5 -CreateOption Empty
Add-AzVMDataDisk -VM $VirtualMachine -Name "FS1Datadisk2" -LUN 1 -Caching ReadOnly -DiskSizeinGB 5 -CreateOption Empty
Add-AzVMDataDisk -VM $VirtualMachine -Name "FS1Datadisk3" -LUN 2 -Caching ReadOnly -DiskSizeinGB 5 -CreateOption Empty
Update-AzVM -ResourceGroupName "TheContosoProject" -VM $VirtualMachine

#Create additional VM in existing subnet
New-AzVM -ResourceGroupName TheContosoProject -Name ContosoFS2 -Location eastus -Credential $cred -OpenPorts $openports

#Add Data disks
$VirtualMachine = Get-AzVM -ResourceGroupName "TheContosoProject" -Name "ContosoFS2"
Add-AzVMDataDisk -VM $VirtualMachine -Name "FS2Datadisk4" -LUN 0 -Caching ReadOnly -DiskSizeinGB 5 -CreateOption Empty
Add-AzVMDataDisk -VM $VirtualMachine -Name "FS2Datadisk5" -LUN 1 -Caching ReadOnly -DiskSizeinGB 5 -CreateOption Empty
Add-AzVMDataDisk -VM $VirtualMachine -Name "FS2Datadisk6" -LUN 2 -Caching ReadOnly -DiskSizeinGB 5 -CreateOption Empty
Update-AzVM -ResourceGroupName "TheContosoProject" -VM $VirtualMachine

#Connection info via Remote Desktop
$publicIp = Get-AzPublicIpAddress -Name ContosoFS1 -ResourceGroupName TheContosoProject
$publicIp | Select-Object Name,IpAddress,@{label='FQDN';expression={$_.DnsSettings.Fqdn}}

#Connection info via Remote Desktop
$publicIp = Get-AzPublicIpAddress -Name ContosoFS2 -ResourceGroupName TheContosoProject
$publicIp | Select-Object Name,IpAddress,@{label='FQDN';expression={$_.DnsSettings.Fqdn}}

#Get Status of all VM's in Resource Group
Get-AzureRmVM -ResourceGroupName "TheContosoProject"


