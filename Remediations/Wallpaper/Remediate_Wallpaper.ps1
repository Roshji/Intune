$Logfile = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\Remediate_Backgroundkey.log"
$path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP"
Write-Output "Remediation in place removing keykeys...." | Out-File $Logfile -Append
Remove-ItemProperty -Path $path -Name "DesktopImagePath" -Force
Remove-ItemProperty -Path $path -Name "LockScreenImagePath" -Force
