#!/usr/bin/env bash

set -e

echo ""
echo "======================================"
echo "     Spicetify Jam Installer"
echo "======================================"
echo ""

if ! command -v git >/dev/null 2>&1; then
    echo "Git is not installed."

    if command -v apt >/dev/null 2>&1; then
        sudo apt update
        sudo apt install -y git
    elif command -v dnf >/dev/null 2>&1; then
        sudo dnf install -y git
    elif command -v pacman >/dev/null 2>&1; then
        sudo pacman -S --noconfirm git
    elif command -v brew >/dev/null 2>&1; then
        brew install git
    else
        echo "Unsupported package manager."
        exit 1
    fi
fi

if ! command -v npm >/dev/null 2>&1; then
    echo "Node.js is not installed."

    if command -v apt >/dev/null 2>&1; then
        sudo apt install -y nodejs npm
    elif command -v dnf >/dev/null 2>&1; then
        sudo dnf install -y nodejs npm
    elif command -v pacman >/dev/null 2>&1; then
        sudo pacman -S --noconfirm nodejs npm
    elif command -v brew >/dev/null 2>&1; then
        brew install node
    else
        echo "Unsupported package manager."
        exit 1
    fi
fi

if ! command -v spicetify >/dev/null 2>&1; then
    echo "Installing Spicetify..."
    curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh
fi

REPO="/tmp/spicetify-jam"

rm -rf "$REPO"

git clone --depth 1 https://github.com/Kyzenkms/spicetify-jam "$REPO"

cd "$REPO"

npm install --force
npm run build --if-present

spicetify backup apply || true

spicetify config extensions spicetify-jam.js
spicetify apply

echo ""
echo "======================================"
echo " Spicetify Jam Installed Successfully!"
echo "======================================"
echo ""
