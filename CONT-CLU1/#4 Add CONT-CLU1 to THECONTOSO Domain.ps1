$cred = Get-Credential thecontoso.com\administrator
$local = Get-Credential CONT-CLU1\Administrator
New-PSSession -VMName "CONT-CLU1" -Credential $cred
Add-Computer -ComputerName CONT-CLU1 -LocalCredential $local -DomainName Thecontoso.com -Credential $cred
Restart-Computer
Remove-PSSession