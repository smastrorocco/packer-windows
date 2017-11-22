$ErrorActionPreference = "Stop"

# Create Packer temporary working directory
Write-Host "Creating temporary working directory"
New-Item -ItemType Directory -Path "C:\PackerTemp" -Force | Out-Null

# Enable RDP
Write-Host "Enabling RDP"
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" `
    -Name "fDenyTSConnections" -PropertyType "DWord" -Value 0 -Confirm:$false `
    -Force | Out-Null

# Open RDP port in firewall
Write-Host "Enable Remote Desktop firewall rule"
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
