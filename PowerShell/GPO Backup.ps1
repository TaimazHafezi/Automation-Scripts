New-GPO -Name "Sales GPO" -comment "This is the sales GPO"
backup-GPO -all -path E:\GPOBackup -comment "Powershell backup of GPOs"
DCGPOFix
DCGPOFix /target:Domain
DCGPOFIX /target:DC
New-GPO
New-GPLink
Backup-GPO
Restore-GPO
Copy-GPO
Get-GPO
Import-GPO
Set-GPinheritance
