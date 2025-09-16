#!/usr/bin/env bash

LINK_PATH="$HOME/.config/nvim"

echo "🧹 Cleaning old Neovim data..."
rm -rf "$LINK_PATH"
rm -rf "$HOME/.local/share/nvim"
rm -rf "$HOME/.local/state/nvim"
rm -rf "$HOME/.cache/nvim"
