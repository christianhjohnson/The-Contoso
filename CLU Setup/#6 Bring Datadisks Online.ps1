Invoke-Command -ComputerName "CONT-CLU1", "CONT-CLU2" -Credential $cred -ScriptBlock {
Get-Disk | Where-Object IsOffline -Eq $True | Set-Disk -IsOffline $False
}