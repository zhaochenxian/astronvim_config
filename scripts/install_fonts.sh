#!/usr/bin/env bash
set -euo pipefail

# Install JetBrainsMono Nerd Font (cross-platform script)
# macOS: uses homebrew cask-fonts
# Linux: downloads Nerd Fonts zip and installs to ~/.local/share/fonts

OS="$(uname -s)"
if [[ "$OS" == "Darwin" ]]; then
  if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew not found. Please install Homebrew first: https://brew.sh/"
    exit 1
  fi
  brew tap homebrew/cask-fonts >/dev/null 2>&1 || true
  brew install --cask font-jetbrains-mono-nerd-font
  echo "Installed JetBrainsMono Nerd Font (macOS)."
  exit 0
fi

# Assume Linux
ZIP_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
TMPDIR="$(mktemp -d)"
ZIPFILE="$TMPDIR/jetbrains.zip"

echo "Downloading JetBrainsMono Nerd Font..."
if command -v curl >/dev/null 2>&1; then
  curl -L "$ZIP_URL" -o "$ZIPFILE"
else
  wget -O "$ZIPFILE" "$ZIP_URL"
fi

DESTDIR="$HOME/.local/share/fonts/JetBrainsMonoNerd"
mkdir -p "$DESTDIR"

echo "Extracting fonts to $DESTDIR..."
unzip -o "$ZIPFILE" -d "$TMPDIR/jetbrains"
find "$TMPDIR/jetbrains" -type f -name "*.ttf" -exec cp -f {} "$DESTDIR/" \;

echo "Refreshing font cache..."
if command -v fc-cache >/dev/null 2>&1; then
  fc-cache -fv "$DESTDIR"
else
  echo "fc-cache not found; you may need to install fontconfig (e.g., apt install fontconfig) and run fc-cache -fv" >&2
fi

echo "Installed JetBrainsMono Nerd Font to $DESTDIR"

# cleanup
rm -rf "$TMPDIR"
exit 0
