$cred = Get-Credential thecontoso.com\administrator
$local = Get-Credential CONT-CLU2\Administrator
New-PSSession -VMName "CONT-CLU2" -Credential $cred
Add-Computer -ComputerName CONT-CLU2 -LocalCredential $local -DomainName Thecontoso.com -Credential $cred
Restart-Computer
Remove-PSSession