Enter-PSSession -VMName "CONT-CLU1"
Rename-Computer -NewName "CONT-CLU1"
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
New-NetIPAddress -InterfaceIndex 2 -IPAddress 192.168.1.160 -PrefixLength 24
Set-DnsClientServerAddress -InterfaceIndex 2 -ServerAddresses 192.168.1.152