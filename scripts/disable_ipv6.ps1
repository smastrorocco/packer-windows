$ErrorActionPreference = "Stop"

# Add registry key to disable IPv6
Write-Host "Disabling IPv6"
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" `
    -Name "DisabledComponents" -PropertyType "DWord" -Value "0xff" -Confirm:$false `
    -Force | Out-Null
