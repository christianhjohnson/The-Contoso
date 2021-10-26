# The Contoso
Building a windows server environment and connecting with Azure.

Issues so far:
When creating reference images with MDT always mount the ISO's as a DVD on the local computer.  DO NOT try to use the boot USB drive.
Was using wrong command to send commands to VM's.  Used Enter-PSSession instead of New-PSSession.
Had a problem pinpointing the correct interface index to setup static IP address, was able to find a variable script to automatically locate the correct interface index for ethernet NIC.



