$ErrorActionPreference = "Stop"

function Install-IfMissing {
param(
[string]$Command,
[string]$WingetId
)

```
if (!(Get-Command $Command -ErrorAction SilentlyContinue)) {
    Write-Host "Installing $Command..." -ForegroundColor Yellow

    winget install --id $WingetId `
        --accept-package-agreements `
        --accept-source-agreements `
        --silent
}
```

}

Write-Host ""
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "     Spicetify Jam Installer" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

# Check Winget

if (!(Get-Command winget -ErrorAction SilentlyContinue)) {
throw "Winget is required but is not installed."
}

Write-Host "Checking dependencies..." -ForegroundColor Cyan

# Git

Install-IfMissing "git" "Git.Git"

# Node.js

Install-IfMissing "npm" "OpenJS.NodeJS.LTS"

# Refresh PATH

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" +
[System.Environment]::GetEnvironmentVariable("Path","User")

# Spicetify

if (!(Get-Command spicetify -ErrorAction SilentlyContinue)) {

```
Write-Host "Installing Spicetify..." -ForegroundColor Yellow

iwr -useb https://raw.githubusercontent.com/spicetify/cli/main/install.ps1 | iex

# Refresh PATH
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" +
            [System.Environment]::GetEnvironmentVariable("Path","User")
```

}

if (!(Get-Command spicetify -ErrorAction SilentlyContinue)) {
throw "Spicetify installation failed."
}

Write-Host ""
Write-Host "Downloading Spicetify Jam..." -ForegroundColor Cyan

$repo = "$env:TEMP\spicetify-jam"

if (Test-Path $repo) {
Remove-Item $repo -Recurse -Force
}

git clone https://github.com/Kyzenkms/spicetify-jam $repo

Set-Location $repo

Write-Host ""
Write-Host "Installing packages..." -ForegroundColor Cyan
npm install

Write-Host ""
Write-Host "Building extension..." -ForegroundColor Cyan
npm run build

Write-Host ""
Write-Host "Applying extension..." -ForegroundColor Cyan

try {
spicetify backup apply
}
catch {
Write-Host "Backup step skipped." -ForegroundColor DarkYellow
}

spicetify config extensions spicetify-jam.js
spicetify apply

Write-Host ""
Write-Host "======================================" -ForegroundColor Green
Write-Host " Installation Complete!" -ForegroundColor Green
Write-Host "======================================" -ForegroundColor Green
Write-Host ""

pause
