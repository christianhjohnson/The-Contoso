#Add CONT-CLU1 to THECONTOSO Domain
Enter-PSSession -VMName "CONT-CLU1"
Add-Computer -DomainName THECONTOSO.COM
Restart-Computer
