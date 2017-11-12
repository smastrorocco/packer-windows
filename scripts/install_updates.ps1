$ErrorActionPreference = "Stop"

# Ensure Windows Update service is retarted so we aren't already checking/downloading
Write-Host "Restarting Windows Update service"
Restart-Service -Name "wuauserv" -Confirm:$false -Force -ErrorAction "SilentlyContinue" | Out-Null

# Enable recommended updates
$AutoUpdateSettings = (New-Object -ComObject Microsoft.Update.AutoUpdate).Settings
$AutoUpdateSettings.IncludeRecommendedUpdates = $true | Out-Null
$AutoUpdateSettings.Save() | Out-Null

# Enable Microsoft updates
$UpdateServiceManager = New-Object -ComObject Microsoft.Update.ServiceManager
$UpdateServiceManager.AddService2("7971f918-a847-4430-9279-4a52d1efe18d",7,"") | Out-Null

# Search for missing updates
$UpdateSession = New-Object -ComObject Microsoft.Update.Session
$UpdateSearcher = $UpdateSession.CreateUpdateSearcher()
Write-Host " - Searching for Updates"
$SearchResult = $UpdateSearcher.Search("IsHidden=0 and IsInstalled=0")
Write-Host " - Found [$($SearchResult.Updates.count)] updates."

# Create counter for logging
$counter = 0

# Loop through updates and install
foreach ($Update in $SearchResult.Updates) {
    $counter++

    # Add update to collection
    $UpdatesCollection = New-Object -ComObject Microsoft.Update.UpdateColl

    # Accept EULA if required
    if ($Update.EulaAccepted -eq 0) {
        $Update.AcceptEula()
    }
    
    $UpdatesCollection.Add($Update) | Out-Null

    # Download
    Write-Host " + Installing [$counter of $($SearchResult.Updates.count)] $($Update.Title)"
    $UpdatesDownloader = $UpdateSession.CreateUpdateDownloader()
    $UpdatesDownloader.Updates = $UpdatesCollection
    $UpdatesDownloader.Download() | Out-Null

    # Install
    $UpdatesInstaller = $UpdateSession.CreateUpdateInstaller()
    $UpdatesInstaller.Updates = $UpdatesCollection
    $UpdatesInstaller.Install() | Out-Null
}
