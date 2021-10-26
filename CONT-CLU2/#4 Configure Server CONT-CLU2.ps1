$cred = Get-Credential thecontoso.com\Administrator
Invoke-Command -VMName "CONT-CLU2" -Credential $cred -FilePath C:\Code\#5CONT-CLU2.ps1