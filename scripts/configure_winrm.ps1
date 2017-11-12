$ErrorActionPreference = "Stop"

# Generate a certificate for WinRM over HTTPS
$dnsName = "vagrantbox.local"
$Cert = New-SelfSignedCertificate -CertstoreLocation "Cert:\LocalMachine\My" `
    -DnsName $dnsName -Confirm:$false

# Bind certificate to WinRM HTTPS transport address
winrm create winrm/config/Listener?Address=*+Transport=HTTPS `
"@{Hostname=`"$($dnsName)`";CertificateThumbprint=`"$($Cert.Thumbprint)`"}" | Out-Null

# Allow Vagrant user to connect over WinRM
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" `
    -Name "LocalAccountTokenFilterPolicy" -PropertyType DWORD -Value 1 `
    -Confirm:$false -Force | Out-Null

# Restart WinRM service
Restart-Service -Name "winrm" -Confirm:$false -Force | Out-Null

# Open TCP port 5986 for WinRM over HTTPS
New-NetFirewallRule -DisplayName "Allow WinRM over HTTPS" -Direction Inbound `
    -LocalPort 5986 -Protocol TCP -Action Allow -Confirm:$false | Out-Null
