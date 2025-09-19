#!/usr/bin/env bash

echo "🧹 Cleaning old Neovim data..."

# Check if Neovim is running
if pgrep nvim > /dev/null; then
    echo "Warning: Neovim processes are currently running. Please close all Neovim instances before cleaning."
    read -p "Do you still want to proceed? (y/N): " confirm
    if [[ ! "$confirm" =~ ^[yY]$ ]]; then
        echo "Cleaning aborted."
        exit 0
    fi
fi

read -p "This will remove all Neovim data. Are you sure? (y/N): " confirm
if [[ "$confirm" =~ ^[yY]$ ]]; then
    echo "Removing ~/.local/share/nvim..."
    rm -rf "$HOME/.local/share/nvim"
    echo "Removing ~/.local/state/nvim..."
    rm -rf "$HOME/.local/state/nvim"
    echo "Removing ~/.cache/nvim..."
    rm -rf "$HOME/.cache/nvim"
    echo "Neovim data cleaned."
else
    echo "Cleaning aborted."
fi
