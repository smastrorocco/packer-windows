$ErrorActionPreference = "Stop"

# Packer temporary working directory
$packerTempDir = "C:\PackerTemp"

# Configure the LCM for chef-client support
Write-Host "Configuring LCM for chef-client"

configuration LCM
{
    Node "localhost"
    {
        LocalConfigurationManager {
            ConfigurationMode  = "ApplyOnly"
            RebootNodeIfNeeded = $false
        }
    }
}

# Export DSC config and run it
LCM -OutputPath "$($packerTempDir)\LCM" | Out-Null
Set-DscLocalConfigurationManager -Path "$($packerTempDir)\LCM" | Out-Null
