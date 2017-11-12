$ErrorActionPreference = "Stop"

# Change location to certs directory
$certDir = Set-Location -Path "E:\cert" -PassThru

# Install code signing certificates
Write-Host "Installing code signing certificates for Guest Additions"
Start-Process -FilePath "$($certDir.Path)\VBoxCertUtil.exe" `
    -ArgumentList @("add-trusted-publisher", "--root vbox*.cer", "vbox*.cer") `
    -Wait -PassThru | Out-Null

# Install guest additions
Write-Host "Installing Guest Additions"
$install = Start-Process -FilePath "E:\VBoxWindowsAdditions.exe" `
    -ArgumentList @("/S") -Wait -PassThru

# Exit with install exit code
exit $install.ExitCode
