#!/usr/bin/env bash
set -e

# Backup Helper
backup() {
  local dest=$1
  local backup_dir="$HOME/.dotfiles_backup"

  mkdir -p "$backup_dir"

  if [[ -e "$dest" && ! -L "$dest" ]]; then
    echo "📦 Backing up existing: $dest to $backup_dir"
    mv "$dest" "$backup_dir/"
  fi
}

# Symlink Overwrite Helper
link() {
  local src=$1
  local dest=$2

  # Check if the destination exists and is not already a symlink to the source
  if [[ -e "$dest" && ! -L "$dest" ]]; then
    backup "$dest"
  elif [[ -L "$dest" && "$(readlink "$dest")" != "$src" ]]; then
    echo "⚠️  Removing existing symlink (not ours): $dest"
    rm -rf "$dest"
  elif [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    echo "✅ Already linked: $dest -> $src"
    return 0 # Already correctly linked, nothing to do
  fi

  if [[ -e "$dest" || -L "$dest" ]]; then
    echo "⚠️  Removing existing file or directory: $dest"
    rm -rf "$dest"
  fi

  echo "🔗 Linking $src -> $dest"
  ln -s "$src" "$dest"
}

# === FUNCTIONS ===
setup_global_configs() {
  echo "🔗 Linking common configurations..."
  for dir in .config/*; do
    link "$(pwd)/$dir" "$HOME/.config/$(basename "$dir")"
  done
}

setup_git_configs() {
  echo "🔗 Linking .gitconfig..."
  link "$(pwd)/.gitconfig" "$HOME/.gitconfig"

  echo "🔗 Linking .gitmessage.txt..."
  link "$(pwd)/.gitmessage.txt" "$HOME/.gitmessage.txt"
}

setup_local_bin() {
  echo "📦 Setting up global bin..."
  mkdir -p "$HOME/.local/bin"
  for file in .local/bin/*; do
    link "$(pwd)/$file" "$HOME/.local/bin/$(basename "$file")"
  done
}

setup_local_share() {
  echo "🖼️ Setting up local share..."
  mkdir -p "$HOME/.local/share"
  for dir in .local/share/*; do
    link "$(pwd)/$dir" "$HOME/.local/share/$(basename "$dir")"
  done
}

setup_aliases() {
  echo "🔗 Linking .aliases..."
  link "$(pwd)/.aliases" "$HOME/.aliases"
}

setup_bashrc() {
  echo "🔗 Linking .bashrc..."
  link "$(pwd)/.bashrc" "$HOME/.bashrc"
}

setup_zshrc() {
  echo "🔗 Linking .zshrc..."
  link "$(pwd)/.zshrc" "$HOME/.zshrc"
}

setup_device_specific() {
  echo "💻 Setting up device-specific configs..."
  echo "1) Hyprland"
  echo "2) Niri"
  echo "3) Plasma"
  echo "4) None"
  read -rp "Choose a device-specific configuration [1-4]: " device_choice

  case $device_choice in
  1)
    echo "Setting up for Hyprland..."
    for dir in hyprland/.config/*; do
      link "$(pwd)/$dir" "$HOME/.config/$(basename "$dir")"
    done
    reload_hyprland
    ;;
  2)
    echo "Setting up for Niri..."
    for dir in niri/.config/*; do
      link "$(pwd)/$dir" "$HOME/.config/$(basename "$dir")"
    done
    ;;
  3)
    echo "Setting up for Plasma..."
    for dir in plasma/.config/*; do
      link "$(pwd)/$dir" "$HOME/.config/$(basename "$dir")"
    done
    ;;
  4)
    echo "Skipping device-specific configs."
    ;;
  *)
    echo "⚠️ Invalid choice. Skipping device-specific configs."
    ;;
  esac
}

reload_hyprland() {
  if command -v hyprctl >/dev/null 2>&1; then
    echo "🔄 Reloading Hyprland..."
    hyprctl reload || echo "⚠️ Failed to reload Hyprland"
  fi
}

# === MENU ===

echo "🔧 Dotfiles Setup"
echo "1) Full setup"
echo "2) Partial setup"
read -rp "Choose an option [1-2]: " choice

case $choice in
1)
  setup_global_configs
  setup_git_configs
  setup_local_bin
  setup_local_share
  setup_aliases
  setup_zshrc
  setup_bashrc
  setup_device_specific
  ;;
2)
  echo "Partial setup selected. Choose what to apply:"
  read -rp "Setup global configurations? [y/N]: " configs_choice
  [[ $configs_choice =~ ^[Yy]$ ]] && setup_global_configs

  read -rp "Setup git configs? [y/N]: " git_configs_choice
  [[ $git_configs_choice =~ ^[Yy]$ ]] && setup_git_configs

  read -rp "Setup local bin? [y/N]: " local_bin_choice
  [[ $local_bin_choice =~ ^[Yy]$ ]] && setup_local_bin

  read -rp "Setup local share? [y/N]: " local_share_choice
  [[ $local_share_choice =~ ^[Yy]$ ]] && setup_local_share

  read -rp "Setup aliases? [y/N]: " aliases_choice
  [[ $aliases_choice =~ ^[Yy]$ ]] && setup_aliases

  read -rp "Setup .zshrc? [y/N]: " zshrc_choice
  [[ $zshrc_choice =~ ^[Yy]$ ]] && setup_zshrc

  read -rp "Setup .bashrc? [y/N]: " bashrc_choice
  [[ $bashrc_choice =~ ^[Yy]$ ]] && setup_bashrc

  read -rp "Setup device-specific configs? [y/N]: " device_choice
  [[ $device_choice =~ ^[Yy]$ ]] && setup_device_specific
  ;;
*)
  echo "❌ Invalid choice. Exiting."
  exit 1
  ;;
esac

echo "✅ Dotfiles applied"
