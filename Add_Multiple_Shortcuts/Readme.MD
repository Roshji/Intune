# Add_Multiple_Shortcuts

This script contains the code for adding multiple shortcuts to a Windows 10/11 device via Intune.

## Add_Multiple_Shortcuts.ps1

* Creates "YOURFOLDERHERE" Folder in the start menu   
* Removes all existing shortcuts in the Folder
* Imports the XML file 
* Copies ICO files if set-up in the XML file
* Creates Shortcuts for every record


## Usage

To use this script in Intune follow these steps:

1. Edit the `Shortcuts.xml` to add or remove shortcuts
2. Copy the `Add_Multiple_Shortcuts.ps1` , `Shortcuts.XML` and `icon files` to a single folder
2. Package the folder with the `IntuneWinAppUtil.exe`
3. Add the `.IntuneWin` file as a Win32 app in Intune
4. Installer: `PowerShell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File "Add_Multiple_Shortcuts.ps1" -XMLFile ".\YOURXMLFILE.XML" -Scriptversion 1.0`
5. Deploy the `Win32 app` to a `Device Group`

## Usage

Once the script is installed, end-users can access several shortcuts by navigating to the Windows Start Menu.


## Remove_Multiple_Shortcuts.ps1

* Removes the folder `<YOURFOLDERHERE>` from the Start Menu


## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.

