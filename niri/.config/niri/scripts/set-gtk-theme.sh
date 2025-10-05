#!/usr/bin/env bash
# ~/.config/niri/scripts/set-theme.sh
# Apply consistent GTK and Qt themes on login

# ---- GTK THEMES ----
gsettings set org.gnome.desktop.interface gtk-theme 'Gruvbox-Material-Dark'
gsettings set org.gnome.desktop.interface icon-theme 'Gruvbox-Material-Dark'
gsettings set org.gnome.desktop.interface cursor-theme 'capitaine-cursors'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# ---- QT THEMES ----
export QT_QPA_PLATFORMTHEME=gtk2

# ---- OPTIONAL: LOGGING ----
echo "[set-theme] $(date): Themes applied (Gruvbox-Material-Dark, QT=$QT_QPA_PLATFORMTHEME)" >> ~/.local/share/niri-theme.log

