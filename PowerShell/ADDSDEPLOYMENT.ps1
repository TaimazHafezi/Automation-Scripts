# Windows powershell Script for AD DS Deployment

Import Module ADDSDeployment 
install -ADDSForest 
-CreateDnsDelegation:$false 
-DatabasePath "C:\Windows\NTDS" 
-DomainMode "WinThreshold"
-DomainName "taimaz.lab"
-DomainNetbiosName "TAIMAZ"
-ForestMode "WinThreshold"
-InstallDns:$true
-LogPath "C:\Windows\NTDS"
-NoRebootOnCompletion:$false
-sysvolpath "C:\Windows\SYSVOL"
-Force:$true

