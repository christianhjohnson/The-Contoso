$creddc = Get-Credential thecontoso.com\administrator
$local = Get-Credential Administrator
New-PSSession -VMName "CONT-CLU1" -Credential $local
Add-Computer -DomainName Thecontoso.com -Credential $creddc
Restart-Computer -Force