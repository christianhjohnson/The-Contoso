<# Configure CONT-CLU1 for Remote Desktop
Set Static IP and DNS
Domain Join #>
#Set up variables for Credentials, VMName, Domain Name, then Export Credentials to XML file for use in future scripts
$creddom = Get-Credential Administrator
#Send commands to CONT-CLU1
for ($VMNumber = 1; $VMNumber -lt 3; $VMNumber++)
{Invoke-Command -VMName CONT-CLU$VMNumber -Credential $creddom -Scriptblock { Param ($x)
    # Enabling Remote Desktop via Registry
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0
    #Configure firewall for Remote Desktop
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
    # Set static IP address after locating correct interface
    New-NetIPAddress -InterfaceIndex $(Get-NetAdapter | Where-object{$_.Name -like "*Ethernet*" } | Select-Object -ExpandProperty InterfaceIndex) -IPAddress 192.168.1.16$x -PrefixLength 24 -DefaultGateway 192.168.1.153
    # Set Network to Private
    Set-NetConnectionProfile -InterfaceIndex $(Get-NetAdapter | Where-object{$_.Name -like "*Ethernet*" } | Select-Object -ExpandProperty InterfaceIndex) -NetworkCategory Private
    # Set file and print sharing
    Enable-NetAdapterBinding -Name "Ethernet" -DisplayName "File and Printer Sharing for Microsoft Networks"
    # Set DNS Settings
    Set-DnsClientServerAddress -InterfaceIndex $(Get-NetAdapter | Where-object { $_.Name -like "*Ethernet*" } | Select-Object -ExpandProperty InterfaceIndex) -ServerAddresses 192.168.1.153
    $domain = "thecontoso.com"
    $credential = Get-Credential "$domain\Administrator"
    $hostname = hostname
    Add-Computer -DomainName $domain -ComputerName $hostname -NewName CONT-CLU$x -Credential $credential -Restart
    }} -Argumentlist $VMNumber