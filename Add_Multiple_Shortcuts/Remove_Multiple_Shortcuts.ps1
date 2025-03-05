<#
    .SYNOPSIS
        Removes folder in the Start Menu. 
        .DESCRIPTION
            Author:  Remco van Diermen (https://www.remcovandiermen.nl) 
            Version: 1.0
            Removes folder in the Start Menu. 
    .NOTES
        This script should be run under SYSTEM
    .EXAMPLE
        PowerShell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File "Remove_Multiple_Shortcuts.ps1" 
#>

Remove-Item -Path "$($env:ALLUSERSPROFILE)\Microsoft\Windows\Start Menu\Programs\FOLDER" -Recurse -Force
