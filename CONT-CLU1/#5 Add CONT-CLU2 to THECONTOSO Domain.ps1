#Add CONT-CLU2 to THECONTOSO Domain
Enter-PSSession -VMName "CONT-CLU2"
Add-Computer -DomainName THECONTOSO.COM
Restart-Computer
