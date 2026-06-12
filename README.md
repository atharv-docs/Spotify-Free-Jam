# Spicetify Jam Installer

![Windows](https://img.shields.io/badge/Windows-10%2F11-blue)
![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue)
![License](https://img.shields.io/github/license/YOUR_USERNAME/spicetify-jam-installer)

A one-command installer for Spicetify Jam.

The installer automatically:

- Installs Git (if missing)
- Installs Node.js (if missing)
- Installs Spicetify (if missing)
- Clones the latest Spicetify Jam repository
- Installs dependencies
- Builds the extension
- Applies it to Spotify

## Requirements

- Windows 10/11
- Spotify Desktop
- PowerShell 5.1+
- Winget

## Installation

Open PowerShell and run:

```powershell
irm https://raw.githubusercontent.com/YOUR_USERNAME/spicetify-jam-installer/main/install.ps1 | iex
```

## What the installer does

1. Checks for Git
2. Checks for Node.js and npm
3. Checks for Spicetify
4. Installs missing dependencies automatically
5. Downloads the latest Spicetify Jam source code
6. Builds the extension
7. Applies the extension

## Updating

Run the installation command again:

```powershell
irm https://raw.githubusercontent.com/YOUR_USERNAME/spicetify-jam-installer/main/install.ps1 | iex
```

## Troubleshooting

### Winget not found

Install App Installer from Microsoft Store:

https://apps.microsoft.com/detail/9NBLGGH4NNS1

### Spotify not detected

Make sure Spotify Desktop is installed and launched at least once.

### Spicetify command not found

Run:

```powershell
iwr -useb https://raw.githubusercontent.com/spicetify/cli/main/install.ps1 | iex
```

Then restart PowerShell and try again.

## Uninstall

Open PowerShell and run:

```powershell
spicetify config extensions
spicetify apply
```

Or remove the extension manually from your Spicetify extensions directory.

## Disclaimer

This project is not affiliated with Spotify or Spicetify.

Use at your own risk. The installer executes PowerShell commands and installs software automatically. In other words, exactly the sort of thing security teams stare at nervously while drinking coffee.
