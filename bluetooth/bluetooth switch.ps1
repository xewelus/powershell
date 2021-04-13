using namespace System
using namespace System.IO
Set-Location $PSScriptRoot
[System.Environment]::CurrentDirectory = $PSScriptRoot

$date = [datetime]::Now
$file = "bluetooth_on"
If ((Get-Service bthserv).Status -eq 'Stopped' -or ![File]::Exists($file))
{
    Write-Host "Turning On..." -ForegroundColor Green
    .\bluetooth.ps1 -BluetoothStatus On 
    Write-Host "Done" -ForegroundColor Green 
    $file = [File]::Create($file)
    $file.Close()
    New-BurntToastNotification -Text "Bluetooth On" -ExpirationTime $date
}
else 
{ 
    Write-Host "Turning Off..." -ForegroundColor Gray
    .\bluetooth.ps1 -BluetoothStatus Off 
    Write-Host "Done" -ForegroundColor Gray
    [File]::Delete($file)
    New-BurntToastNotification -Text "Bluetooth Off" -ExpirationTime $date
}