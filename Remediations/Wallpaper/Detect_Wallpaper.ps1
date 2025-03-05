$Logfile = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\Detect_Backgroundkey.log"
try
{
    $path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP"
    $Desktopimage = Get-ItemProperty $path -Name "DesktopImagePath" -ErrorAction SilentlyContinue
    $Lockscreenimage = Get-ItemProperty $path -Name "LockScreenImagePath" -ErrorAction SilentlyContinue
    if ((!$null -eq $Desktopimage) -or (!$null -eq $Lockscreenimage)) {
        # Remediate
        Write-Output "regkeys found, remediate" | Out-File $Logfile -Append
        exit 1
    }
    else{
        # Regkeys already gone. Do nothing      
        exit 0
    }   
}
catch{
    $errMsg = $_.Exception.Message
    Write-Error $errMsg | Out-File $Logfile -Append
    exit 1
}
