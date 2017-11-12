$ErrorActionPreference = "Stop"

# Create sxs directory
Write-Host "Creating C:\sxs directory"
$sxsDir = "C:\sxs"
New-Item -ItemType Directory $sxsDir -Confirm:$false -Force | Out-Null

# Copy sxs from installation media
Write-Host "Copying SxS from installation media"
Copy-Item -Path "D:\sources\sxs\*" -Destination $sxsDir | Out-Null
