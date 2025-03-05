Install-Module -Name Microsoft.Graph.DeviceManagement -Force
Install-Module -Name Microsoft.Graph.Beta.DeviceManagement.Actions -AllowClobber -Force
Import-Module -Name Microsoft.Graph.DeviceManagement
Import-Module -Name Microsoft.Graph.Beta.DeviceManagement.Actions -Force
Connect-MgGraph -Scopes DeviceManagementManagedDevices.PrivilegedOperations.All, DeviceManagementManagedDevices.Read.All, DeviceManagementManagedDevices.ReadWrite.All
# Step 1: Query the devices
$queryFilter = "startswith(deviceName,'W10') and osVersion ge '10.0.2'"
$response = Get-MgDeviceManagementManagedDevice -Filter $queryFilter
# Step 2: Rename Devices
foreach ($device in $response) {
    $oldName = $device.DeviceName
    $serialNumber = $oldName -replace '^W10-', ''
    $newName = "W11-$serialNumber"
    Write-Output "Renaming $oldName -> $newName"
   try {
        # Send the Rename option to the device
        Set-MgBetaDeviceManagementManagedDeviceName -ManagedDeviceId $Device.Id -DeviceName $newName
        Write-Output "Success Renaming $oldName -> $newName" }
        catch {
        Write-Output "Error Renaming $oldName"
    }   
}
