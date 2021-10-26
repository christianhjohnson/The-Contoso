$cred = Get-Credential Administrator
Invoke-Command -VMName "CONT-CLU1" -Credential $cred -FilePath C:\Code\#5CONT-CLU1.ps1