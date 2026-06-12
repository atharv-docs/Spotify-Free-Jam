$ErrorActionPreference = "Stop"

function Install-IfMissing {
    param(
        [string]$Command,
        [string]$WingetId
    )

    if (!(Get-Command $Command -ErrorAction SilentlyContinue)) {
        Write-Host "Installing $Command..." -ForegroundColor Yellow

        winget install --id $WingetId `
            --accept-package-agreements `
            --accept-source-agreements `
            --silent
    }
}

Write-Host ""
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "     Spicetify Jam Installer" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

if (!(Get-Command winget -ErrorAction SilentlyContinue)) {
    throw "Winget is required but is not installed."
}

Write-Host "Checking dependencies..." -ForegroundColor Cyan

Install-IfMissing "git" "Git.Git"
Install-IfMissing "npm" "OpenJS.NodeJS.LTS"

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" +
            [System.Environment]::GetEnvironmentVariable("Path","User")

if (!(Get-Command git -ErrorAction SilentlyContinue)) {
    throw "Git installation failed. Please restart PowerShell and try again."
}

if (!(Get-Command npm -ErrorAction SilentlyContinue)) {
    throw "Node.js installation failed. Please restart PowerShell and try again."
}


if (!(Get-Command spicetify -ErrorAction SilentlyContinue)) {

    Write-Host "Installing Spicetify..." -ForegroundColor Yellow

    iwr -useb https://raw.githubusercontent.com/spicetify/cli/main/install.ps1 | iex

    Start-Sleep -Seconds 2

    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" +
                [System.Environment]::GetEnvironmentVariable("Path","User")
}

if (!(Get-Command spicetify -ErrorAction SilentlyContinue)) {
    throw "Spicetify installation failed."
}

Write-Host ""
Write-Host "Downloading Spicetify Jam..." -ForegroundColor Cyan

$repo = "$env:TEMP\spicetify-jam"

if (Test-Path $repo) {
    try {
        Remove-Item $repo -Recurse -Force
    }
    catch {
        $repo = "$env:TEMP\spicetify-jam-" + (Get-Random)
    }
}

git clone https://github.com/Kyzenkms/spicetify-jam $repo

Set-Location $repo

Write-Host ""
Write-Host "Installing packages..." -ForegroundColor Cyan
npm install --force

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
Write-Host " Spicetify Jam Installed Successfully!" -ForegroundColor Green
Write-Host "======================================" -ForegroundColor Green
Write-Host ""

pause
