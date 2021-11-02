$local = Get-Credential Administrator
New-PSSession -VMName "CONT-CLU1" -Credential $local
$creddc = Get-Credential thecontoso.com\administrator
Add-Computer -DomainName Thecontoso.com -Credential $creddc
Restart-Computer -Force
