$ErrorActionPreference = "Stop"

# Packer temporary working directory
Write-Host "Cleaning up teporary working directory"
$packerTempDir = "C:\PackerTemp"
Remove-Item -Path $packerTempDir -Recurse -Force -Confirm:$false | Out-Null

# Cleanup SxS
Write-Host "Cleaning Windows SxS"
Dism.exe /Online /Cleanup-Image /StartComponentCleanup /ResetBase | Out-Null

# Defrag
Write-Host "Defragmenting C: drive"
Defrag.exe /C /H /V | Out-Null
