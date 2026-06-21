# update-all-apps.ps1

Write-Host "Starting Windows app update process..." -ForegroundColor Cyan

# Check if winget is installed
if (Get-Command winget -ErrorAction SilentlyContinue) {
    Write-Host "Fetching latest package sources..."
    # Upgrade all apps, automatically accepting agreements to prevent it from pausing
    winget upgrade --all --accept-source-agreements --accept-package-agreements
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Update process completed successfully!" -ForegroundColor Green
    } else {
        Write-Host "Update process finished, but some apps may have required a restart or failed." -ForegroundColor Yellow
    }
} else {
    Write-Host "Error: 'winget' is not recognized. Please ensure you are on Windows 10/11 and have the 'App Installer' updated from the Microsoft Store." -ForegroundColor Red
}

Read-Host "Press Enter to exit"