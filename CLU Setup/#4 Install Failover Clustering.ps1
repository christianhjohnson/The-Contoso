$cred = Get-Credential thecontoso.com\administrator
Invoke-Command -ComputerName "CONT-CLU1", "CONT-CLU2" -Credential $cred -scriptblock { Install-WindowsFeature -Name "Failover-Clustering", "Data-Center-Bridging", "RSAT-Clustering-PowerShell", "FS-FileServer", "DHCP" -IncludeManagementTools
Remove-WindowsFeature -Name FS-SMB1 -Verbose -Restart }