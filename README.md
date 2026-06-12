# Spotify Free Jam Installer

![Windows](https://img.shields.io/badge/Windows-10%2F11-blue)
![Linux](https://img.shields.io/badge/Linux-Supported-green)
![macOS](https://img.shields.io/badge/macOS-Supported-lightgrey)
![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue)

One-command installer for Spicetify Jam.

The installer automatically:

- Installs Git (if missing)
- Installs Node.js (if missing)
- Installs Spicetify (if missing)
- Downloads the latest Spicetify Jam source code
- Installs dependencies
- Builds the extension
- Applies it to Spotify

---

# Quick Install

## Windows

Open PowerShell and run:

```powershell
irm https://raw.githubusercontent.com/atharv-docs/Spotify-Free-Jam/main/install.ps1 | iex
```

## Linux

Open a terminal and run:

```bash
curl -fsSL https://raw.githubusercontent.com/atharv-docs/Spotify-Free-Jam/main/install.sh | bash
```

## macOS

Open Terminal and run:

```bash
curl -fsSL https://raw.githubusercontent.com/atharv-docs/Spotify-Free-Jam/main/install.sh | bash
```

---

# Requirements

## Windows

- Windows 10 or newer
- Spotify Desktop
- PowerShell 5.1+
- Winget

## Linux

- Spotify installed
- Bash
- Internet connection

## macOS

- Spotify installed
- Bash/Zsh
- Internet connection

---

# What the Installer Does

1. Checks for Git
2. Checks for Node.js and npm
3. Checks for Spicetify
4. Installs missing dependencies automatically
5. Downloads the latest Spicetify Jam source code
6. Builds the extension
7. Applies it to Spotify

---

# Updating

Simply run the installation command again for your platform.

The installer always downloads the latest version.

---

# Troubleshooting

## Winget not found (Windows)

Install App Installer from the Microsoft Store and try again.

## Git installation failed

Restart PowerShell and rerun the installer.

## Node.js installation failed

Restart PowerShell and rerun the installer.

## Spicetify installation failed

Install Spicetify manually:

### Windows

```powershell
iwr -useb https://raw.githubusercontent.com/spicetify/cli/main/install.ps1 | iex
```

### Linux/macOS

```bash
curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh
```

Then rerun the installer.

---

# Uninstall

Remove the extension and reapply Spicetify:

```bash
spicetify apply
```

You may also manually delete the extension from your Spicetify extensions directory.

---

# Disclaimer

This project is not affiliated with Spotify or Spicetify.

Use at your own risk.

The installer automatically downloads and executes software from external sources. Review the source code before running if you have security concerns.

---

# License

This project follows the license terms of the original Spicetify Jam project and its dependencies.
