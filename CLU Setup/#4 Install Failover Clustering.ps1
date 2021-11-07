$cred = Get-Credential thecontoso.com\administrator
$CompName = "CONT-CLU1"."CONT-CLU2"
Invoke-Command -ComputerName $CompName -Credential $cred -scriptblock { Install-WindowsFeature -Name "Failover-Clustering", "Data-Center-Bridging", "RSAT-Clustering-PowerShell", "FS-FileServer", "DHCP" -IncludeManagementTools Remove-WindowsFeature -Name FS-SMB1 -Verbose -Restart }