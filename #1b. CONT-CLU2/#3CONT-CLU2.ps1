$cred = Get-Credential Thecontoso.com\Administrator
New-PSSession -VMName "CONT-CLU2" -Credential $cred
Rename-Computer -NewName "CONT-CLU2"
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
New-NetIPAddress -InterfaceIndex $(Get-NetAdapter | Where-object {$_.Name -like "*Ethernet*" } | Select-Object -ExpandProperty InterfaceIndex) -IPAddress 192.168.1.161 -PrefixLength 24
Set-DnsClientServerAddress -InterfaceIndex $(Get-NetAdapter | Where-object {$_.Name -like "*Ethernet*" } | Select-Object -ExpandProperty InterfaceIndex) -ServerAddresses 192.168.1.152
Add-Computer -DomainName Thecontoso.com -Credential
Restart-Computer -Force