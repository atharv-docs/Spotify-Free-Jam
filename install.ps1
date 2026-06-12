$ErrorActionPreference = "Stop"

function Install-IfMissing {
    param($Command, $WingetId)

    if (!(Get-Command $Command -ErrorAction SilentlyContinue)) {
        Write-Host "Installing $Command..."
        winget install --id $WingetId `
            --accept-package-agreements `
            --accept-source-agreements
    }
}

Install-IfMissing "git" "Git.Git"
Install-IfMissing "npm" "OpenJS.NodeJS.LTS"

if (!(Get-Command spicetify -ErrorAction SilentlyContinue)) {
    iwr -useb https://raw.githubusercontent.com/spicetify/cli/main/install.ps1 | iex
}

$repo = "$env:TEMP\spicetify-jam"

if (Test-Path $repo) {
    Remove-Item $repo -Recurse -Force
}

git clone https://github.com/Kyzenkms/spicetify-jam $repo

Set-Location $repo

npm install
npm run build

spicetify config extensions spicetify-jam.js
spicetify apply

Write-Host ""
Write-Host "Installation Complete!"
