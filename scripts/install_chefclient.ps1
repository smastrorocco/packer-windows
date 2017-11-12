$ErrorActionPreference = "Stop"

# Packer temporary working directory
$packerTempDir = "C:\PackerTemp"

# Download installation files and execute (latest version)
Write-Host "Downloading and installing chef-client"
Invoke-WebRequest -UseBasicParsing "https://omnitruck.chef.io/install.ps1" | Invoke-Expression | Out-Null
install -download_directory $packerTempDir -daemon "task" | Out-Null
