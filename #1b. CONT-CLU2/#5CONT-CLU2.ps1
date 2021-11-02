$local = Get-Credential Administrator
New-PSSession -ComputerName "CONT-CLU1" -Credential $local
$creddc = Get-Credential thecontoso.com\administrator
Add-Computer -DomainName Thecontoso.com -Credential $creddc
Restart-Computer -Force
