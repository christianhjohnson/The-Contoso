#Enter PowerShell Session
Enter-PSSession -VMName "CONT-CLU1"

#Configure new Server
Rename-Computer -NewName "CONT-CLU1"

#Activate Remote Desktop
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0

#Set Firewall Rules
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

#Set IP Address
New-NetIPAddress -InterfaceIndex 2 -IPAddress 192.168.1.160 -PrefixLength 24

#Set DNS Client Address
Set-DnsClientServerAddress -InterfaceIndex 2 -ServerAddresses 192.168.1.152

#Restart Computer
Restart-Computer
