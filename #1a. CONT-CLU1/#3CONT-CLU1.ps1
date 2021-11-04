<# Configure CONT-CLU1 for Remote Desktop
Set Static IP and DNS
Domain Join #>
#Set up variables for Credentials, VMName, Domain Name, then Export Credentials to XML file for use in future scripts
$creddom = Get-Credential Thecontoso.com\Administrator
$creddom | Export-Climxl C:\code\creddom.xml
$VMName = "CONT-CLU1"
$DomainName = "Thecontoso.com"
#Send commands to CONT-CLU1
Invoke-Command -VMName $VMName -Credential $creddom {
    #Set up variables that cross over from DC-1 to CONT-CLU1
    #X parameter = VMName , Y parameter = Domain Name
    Param ($x, $y)
    $creddom = Get-Credential Thecontoso.com\Administrator
    $creddom | Export-Climxl C:\code\creddom.xml
    #Rename Computer
    Rename-Computer -NewName "$x"
    # Enabling Remote Desktop via Registry
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0
    #Configure firewall for Remote Desktop
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
    # Set static IP address after locating correct interface
    New-NetIPAddress -InterfaceIndex $(Get-NetAdapter | Where-object {$_.Name -like "*Ethernet*" } | Select-Object -ExpandProperty InterfaceIndex) -IPAddress 192.168.1.160 -PrefixLength 24
    # Set DNS address to Domain Controller after locating correct interface
    Set-DnsClientServerAddress -InterfaceIndex $(Get-NetAdapter | Where-object {$_.Name -like "*Ethernet*" } | Select-Object -ExpandProperty InterfaceIndex) -ServerAddresses 192.168.1.152
    # Join Computer to Domain 
    Add-Computer -DomainName $y -Credential $creddom
    Restart-Computer -Force
}
#Variables that cross over from DC_1 to CONT-CLU1
-ArgumentList $VMName, $DomainName