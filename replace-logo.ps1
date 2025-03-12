# This script helps replace the 1of1Group logo files with your own
# Place your logo files in the same directory as this script

# Check if logo files exist
if (-not (Test-Path -Path "new-logo.png")) {
    Write-Host "Error: new-logo.png not found. Please place your main logo file in the same directory as this script."
    exit 1
}

if (-not (Test-Path -Path "new-logo-sq.png")) {
    Write-Host "Warning: new-logo-sq.png not found. Using new-logo.png for square logo."
    Copy-Item -Path "new-logo.png" -Destination "new-logo-sq.png"
}

# Copy logo files to the container
Write-Host "Copying logo files to the container..."
docker cp new-logo.png icehrm_v3350os-icehrm-1:/var/www/html/web/images/logo.png
docker cp new-logo-sq.png icehrm_v3350os-icehrm-1:/var/www/html/web/images/logo-sq.png
docker cp new-logo.png icehrm_v3350os-icehrm-1:/var/www/html/web/images/syslogo.png

Write-Host "Logo files replaced successfully!"
Write-Host "Please clear your browser cache and refresh the page to see the changes." 