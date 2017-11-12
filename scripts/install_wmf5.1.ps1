$ErrorActionPreference = "Stop"

# Packer temporary working directory
$packerTempDir = "C:\PackerTemp"

# Download installation files and execute
Write-Host "Downloading and installing Windows Management Framework 5.1"
Invoke-WebRequest -Uri "https://download.microsoft.com/download/6/F/5/6F5FF66C-6775-42B0-86C4-47D41F2DA187/Win8.1AndW2K12R2-KB3191564-x64.msu" `
    -OutFile "$($packerTempDir)\Win8.1AndW2K12R2-KB3191564-x64.msu"
$wmfInstall = Start-Process -FilePath "$($env:windir)\System32\wusa.exe" `
    -ArgumentList @("$($packerTempDir)\Win8.1AndW2K12R2-KB3191564-x64.msu", "/quiet", "/norestart") `
    -Wait `
    -PassThru

# Exit with install exit code
exit $wmfInstall.ExitCode