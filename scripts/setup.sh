#!/usr/bin/env bash
set -e

HOST=$(hostname)

# Symlink Overwrite Helper
link() {
  local src=$1
  local dest=$2

  if [[ -e "$dest" || -L "$dest" ]]; then
    echo "⚠️  Removing existing: $dest"
    rm -rf "$dest"
  fi

  echo "🔗 Linking $src -> $dest"
  ln -s "$src" "$dest"
}

# === Global bin ===
mkdir -p "$HOME/.local/bin"
for file in $(ls -1 .local/bin); do
  link "$(pwd)/.local/bin/$file" "$HOME/.local/bin/$file"
done

# === Global configs ===
echo "🔗 Linking universal configs..."
for dir in $(ls -1 .config); do
  link "$(pwd)/.config/$dir" "$HOME/.config/$dir"
done

# Link .bashrc from repo
link "$(pwd)/.bashrc" "$HOME/.bashrc"

# === Device-specific ===
if [[ $HOST == "cachyos-pc" ]]; then
  echo "⚠️  Linking CachyOS-specific configs..."
  for dir in $(ls -1 cachyos/.config); do
    link "$(pwd)/cachyos/.config/$dir" "$HOME/.config/$dir"
  done

elif [[ $HOST == "kubuntu-laptop" ]]; then
  echo "⚠️  Linking Kubuntu-specific configs..."
  for dir in $(ls -1 kubuntu/.config); do
    link "$(pwd)/kubuntu/.config/$dir" "$HOME/.config/$dir"
  done

else
  echo "⚠️ Unknown host: $HOST. Skipping device-specific configs."
fi

echo "✅ Dotfiles applied for $HOST"

# Reload Hyprland if available
if command -v hyprctl >/dev/null 2>&1; then
  echo "🔄 Reloading Hyprland..."
  hyprctl reload || echo "⚠️ Failed to reload Hyprland"
fi
