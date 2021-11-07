<# Configure CONT-VPN for Remote Desktop
Set Static IP and DNS
Domain Join #>
#Set up variables for Credentials, VMName, Domain Name, then Export Credentials to XML file for use in future scripts
$creddom = Get-Credential Administrator
$VMName = "CONT-VPN"
#Send commands to CONT-VPN
Invoke-Command -VMName $VMName -Credential $creddom -Scriptblock {
    Rename-NetAdapter -Name "E*2" -NewName "WAN"
    # Enabling Remote Desktop via Registry
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0
    #Configure firewall for Remote Desktop
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
    # Set static IP address after locating correct interface
    New-NetIPAddress -InterfaceIndex $(Get-NetAdapter | Where-object{$_.Name -like "*Ethernet*" } | Select-Object -ExpandProperty InterfaceIndex) -IPAddress 192.168.1.162 -PrefixLength 24 -DefaultGateway 192.168.1.152
    New-NetIPAddress -InterfaceIndex $(Get-NetAdapter | Where-object{$_.Name -like "*WAN*" } | Select-Object -ExpandProperty InterfaceIndex) -IPAddress 192.168.1.163 -PrefixLength 24 -DefaultGateway 192.168.1.152
    # Set Network to Private
    Set-NetConnectionProfile -InterfaceIndex $(Get-NetAdapter | Where-object{$_.Name -like "*Ethernet*" } | Select-Object -ExpandProperty InterfaceIndex) -NetworkCategory Private
    Set-NetConnectionProfile -InterfaceIndex $(Get-NetAdapter | Where-object{$_.Name -like "*WAN*" } | Select-Object -ExpandProperty InterfaceIndex) -NetworkCategory Private
    # Set file and print sharing
    Enable-NetAdapterBinding -Name "*Ethernet*" -DisplayName "File and Printer Sharing for Microsoft Networks"
    Enable-NetAdapterBinding -Name "*WAN*" -DisplayName "File and Printer Sharing for Microsoft Networks"
    # Set DNS Settings
    Set-DnsClientServerAddress -InterfaceIndex $(Get-NetAdapter | Where-object { $_.Name -like "*Ethernet*" } | Select-Object -ExpandProperty InterfaceIndex) -ServerAddresses 192.168.1.153
    Set-DnsClientServerAddress -InterfaceIndex $(Get-NetAdapter | Where-object { $_.Name -like "*WAN*" } | Select-Object -ExpandProperty InterfaceIndex) -ServerAddresses 192.168.1.153
    $domain = "thecontoso.com"
    $credential = Get-Credential "$domain\Administrator"
    $hostname = hostname
    Add-Computer -DomainName $domain -ComputerName $hostname -NewName CONT-VPN -Credential $credential -Restart
    }