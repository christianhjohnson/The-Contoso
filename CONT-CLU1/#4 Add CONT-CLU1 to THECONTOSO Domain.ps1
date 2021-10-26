$cred = Get-Credential thecontoso.com\administrator
New-PSSession -VMName "CONT-CLU1" -Credential $cred
Add-Computer -DomainName THECONTOSO.COM
Restart-Computer
Remove-PSSession