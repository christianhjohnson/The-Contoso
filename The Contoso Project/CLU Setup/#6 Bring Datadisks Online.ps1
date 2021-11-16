$cred = Get-Credential thecontoso.com\administrator
Invoke-Command -ComputerName "CONT-CLU1", "CONT-CLU2" -Credential $cred -ScriptBlock {
Initialize-Disk -Number 1
Initialize-Disk -Number 2
Initialize-Disk -Number 3
New-Volume -DiskNumber 1 -FileSystem NTFS -DriveLetter E -FriendlyName "ClusterDisk0"
New-Volume -DiskNumber 2 -FileSystem NTFS -DriveLetter F -FriendlyName "ClusterDisk1"
New-Volume -DiskNumber 3 -FileSystem NTFS -DriveLetter G -FriendlyName "ClusterDisk2"
}