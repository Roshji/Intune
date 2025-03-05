<#
    .SYNOPSIS
        Creates a folder in the Start Menu and add shortcuts. 
        .DESCRIPTION
            Author:  Remco van Diermen (https://www.remcovandiermen.nl) 
            Version: 1.3
            Creates a folder in the Start Menu and add shortcuts. Reads from a XML file 
    .PARAMETER ShortcutName
        Display Name of the shortcut.
    .PARAMETER ShortcutUrl
        URL of UNC Path for the shortcut.
    .PARAMETER StartIn
        Location if it's an UNC Path to be started in.
    .PARAMETER ShortcutIcon
        Location of the icon file for the shortcut.
    .NOTES
        This script can either run in SYSTEM (for all users) or USER (current user only) context.
    .EXAMPLE
        PowerShell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File "Add_Multiple_Shortcuts.ps1" -XMLFile ".\Shortcuts.XML" -Scriptversion 1.0
#>
          
       
        param(
            [Parameter(Mandatory = $true)]
            [string]$XMLFile,
            [Parameter(Mandatory = $true)]
            [string]$Scriptversion
        )

        # Check if the Icons folder exists in the Programdata Menu
        if (-not (Test-Path "$($env:ProgramData)\Icons")) {
            New-Item -Path "$($env:ProgramData)\Icons" -ItemType Directory
        }
        # Check if the folder exists in the Start Menu
        if (-not (Test-Path "$($env:ALLUSERSPROFILE)\Microsoft\Windows\Start Menu\Programs\FOLDER")) {
            New-Item -Path "$($env:ALLUSERSPROFILE)\Microsoft\Windows\Start Menu\Programs\FOLDER" -ItemType Directory
        }
        # Check if there are any shortcuts in the folder and remove them
        else {
            Remove-Item -Path "$($env:ALLUSERSPROFILE)\Microsoft\Windows\Start Menu\Programs\FOLDER\*" -Recurse -Force
        }

        # Check if the registry key exists
        if (-not (Test-Path "HKLM:\Software\YOURCOMPANY")) {
            # Create the registry key
            New-Item -Path "HKLM:\Software\YOURCOMPANY" -ItemType Directory -Force
        }
        
        # Check if the registry key exists
        if (-not (Test-Path "HKLM:\Software\YOURCOMPANY\FOLDER")) {
            # Create the registry key
            New-Item -Path "HKLM:\Software\YOURCOMPANY\FOLDER" -ItemType Directory -Force
        }

        # Set registry value with Scriptversion
        Set-ItemProperty -Path "HKLM:\Software\YOURCOMPANY\FOLDER" -Name "Scriptversion" -Value $Scriptversion -Type String -Force


        # Read information from XML file
        $ImportXMLFile = Get-Content -Path $XMLFile
        [xml]$XMLImport = $ImportXMLFile
        $webdiensten = $XMLImport.root.webdiensten.webdienst
        
        # Copy the Edge icon to the Icons folder
        Copy-Item ".\Edge.ico" "$($env:ProgramData)\Icons\" -Force   

        # Loop through each webdienst in the XML file
        foreach ($webdienst in $webdiensten) {
            $ShortcutName = $webdienst.ShortcutName
            $ShortcutUrl = $webdienst.ShortcutUrl
            $ShortcutStartIn = $webdienst.StartIn
            $ShortcutIcon = $webdienst.ShortcutIcon

            # Check if the there's an icon location in the XML file
            if ($webdienst.ShortcutIcon -ne "NONE") {
                $ShortcutIcon = $webdienst.ShortcutIcon
                Copy-Item ".\$ShortcutIcon.ico" "$($env:ProgramData)\Icons\" -Force      
                $ShortcutIconLocation = "$($env:ProgramData)\Icons\$ShortcutIcon.ico"
            }
            else {
                $ShortcutIconLocation = "$($env:ProgramData)\Icons\Edge.ico"
            }

            # Check if the there's a StartIn location in the XML file
            if ($null -ne $webdienst.StartIn) {
                $ShortcutStartIn = $webdienst.StartIn
                
            }
            else {
                $ShortcutStartIn = $null
            }

            # Create the shell object and save the shortcut
            $WScriptShell = New-Object -ComObject WScript.Shell
            $Shortcut = $WScriptShell.CreateShortcut("$env:ALLUSERSPROFILE\Microsoft\Windows\Start Menu\Programs\FOLDER\$ShortcutName.lnk") 
            $Shortcut.TargetPath = $ShortcutUrl
            if ($ShortcutStartIn) {
                $Shortcut.WorkingDirectory = $ShortcutStartIn 
            }    
            if ($ShortcutIconLocation) {
                $Shortcut.IconLocation = $ShortcutIconLocation
            }
            $Shortcut.Save()
            
        }
