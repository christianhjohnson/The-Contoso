$cred = Get-Credential Administrator
Invoke-Command -VMName "CONT-CLU2" -Credential $cred -FilePath C:\Code\#3CONT-CLU2.ps1
