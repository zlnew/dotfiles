#!/usr/bin/env bash
# install-themes.sh
# Purpose: Install Graphite GTK Theme, Papirus Icon Theme, and Bibata Cursor Theme
# Location: ~/.local/share/{themes,icons}

set -euo pipefail

# ─────────────────────────────────────────────
# Variables
# ─────────────────────────────────────────────
THEME_DIR="$HOME/.local/share/themes"
ICON_DIR="$HOME/.local/share/icons"
TMP_DIR="/tmp/install-themes"

mkdir -p "$THEME_DIR" "$ICON_DIR" "$TMP_DIR"

# ─────────────────────────────────────────────
# Colors
# ─────────────────────────────────────────────
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
CYAN="\033[1;36m"
NC="\033[0m" # No Color

# ─────────────────────────────────────────────
# Flags
# ─────────────────────────────────────────────
FORCE=false
if [[ "${1:-}" == "--force" ]]; then
  FORCE=true
  echo -e "${YELLOW}⚠ Forcing reinstallation of all themes...${NC}"
fi

# ─────────────────────────────────────────────
# Cleanup on exit
# ─────────────────────────────────────────────
trap 'rm -rf "$TMP_DIR"' EXIT

# ─────────────────────────────────────────────
# Graphite GTK Theme
# ─────────────────────────────────────────────
echo -e "${CYAN}Installing Graphite GTK Theme...${NC}"
if $FORCE || [ ! -d "$THEME_DIR/Graphite-compact" ]; then
  rm -rf /tmp/Graphite-gtk-theme
  git clone --depth=1 https://github.com/vinceliuice/Graphite-gtk-theme.git "$TMP_DIR/Graphite-gtk-theme"
  cd "$TMP_DIR/Graphite-gtk-theme"
  ./install.sh --dest "$THEME_DIR" --size compact --tweaks black normal --round 8px
  cd - >/dev/null
else
  echo "Graphite already installed."
fi

# ─────────────────────────────────────────────
# Papirus Icon Theme
# ─────────────────────────────────────────────
echo -e "${CYAN}Installing Papirus Icon Theme...${NC}"
if $FORCE || [ ! -d "$ICON_DIR/Papirus" ]; then
  echo "→ Fetching and running official Papirus installer..."
  wget -qO- https://git.io/papirus-icon-theme-install | env DESTDIR="$ICON_DIR" sh
else
  echo "Papirus already installed."
fi

# ─────────────────────────────────────────────
# Bibata Cursor Theme
# ─────────────────────────────────────────────
echo -e "${CYAN}Installing Bibata Cursor Theme...${NC}"
if $FORCE || [ ! -d "$ICON_DIR/Bibata-Modern-Ice" ]; then
  BIBATA_URL="https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.7/Bibata-Modern-Ice.tar.xz"
  TMP_FILE="$TMP_DIR/Bibata-Modern-Ice.tar.xz"

  echo "→ Downloading Bibata Modern Ice..."
  curl -sSL -o "$TMP_FILE" "$BIBATA_URL"

  echo "→ Extracting to $ICON_DIR..."
  tar -xf "$TMP_FILE" -C "$ICON_DIR/"
else
  echo "Bibata already installed."
fi

# ─────────────────────────────────────────────
# Summary
# ─────────────────────────────────────────────
echo ""
echo -e "${GREEN}✓ Done!${NC} Apply themes with:"
echo "  GTK Theme:   Graphite"
echo "  Icon Theme:  Papirus"
echo "  Cursor:      Bibata-Modern-Ice"
echo ""
echo -e "${YELLOW}Tip:${NC} Re-run with '--force' to reinstall all themes."

