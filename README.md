# The Contoso
During my MSSA course there has been a lot of information about the roles of a Windows server and Azure cloud administrator.  The purpose of this project is to build my skills in perfecting the process behind doing research, troubleshooting, and applying the knowledge in server and cloud administration.  I am noting some of the issues I have been working through, but my code is evolving more and more as my skill in PowerShell continues to grow.  As my skill grows the process to build these resources using PowerShell scripting becomes more efficient.

https://www.thecontoso.com

Issues so far:
When creating reference images with MDT always mount the ISO's as a DVD on the local computer.  DO NOT try to use the boot USB drive.
Was using wrong command to send commands to VM's.  Used Enter-PSSession instead of New-PSSession.
Had a problem pinpointing the correct interface index to setup static IP address, was able to find a variable script to automatically locate the correct interface index for ethernet NIC.
Cannot use S2D because my server uses a raid controller, and it can not be disabled unless I perform an crazy configuration to have it boot from a special SD Card.
Workaround for S2D turns out to be just a regedit.  See https://docs.microsoft.com/en-us/troubleshoot/windows-server/high-availability/enable-support-using-raid-controllers

