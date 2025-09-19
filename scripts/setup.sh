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

# === FUNCTIONS ===

setup_global_bin() {
  echo "📦 Setting up global bin..."
  mkdir -p "$HOME/.local/bin"
  for file in .local/bin/*; do
    link "$(pwd)/$file" "$HOME/.local/bin/$(basename "$file")"
  done
}

setup_global_configs() {
  echo "🔗 Linking universal configs..."
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

setup_aliases() {
  echo "🔗 Linking .aliases..."
  link "$(pwd)/.aliases" "$HOME/.aliases"
}

setup_bashrc() {
  echo "🔗 Linking .bashrc..."
  link "$(pwd)/.bashrc" "$HOME/.bashrc"
}

setup_device_specific() {
  echo "💻 Setting up device-specific configs for $HOST..."
  if [[ $HOST == "cachyos-pc" ]]; then
    for dir in cachyos/.config/*; do
      link "$(pwd)/$dir" "$HOME/.config/$(basename "$dir")"
    done
  elif [[ $HOST == "kubuntu-laptop" ]]; then
    for dir in kubuntu/.config/*; do
      link "$(pwd)/$dir" "$HOME/.config/$(basename "$dir")"
    done
  else
    echo "⚠️ Unknown host: $HOST. Skipping device-specific configs."
  fi
}

reload_hyprland() {
  if command -v hyprctl >/dev/null 2>&1; then
    echo "🔄 Reloading Hyprland..."
    hyprctl reload || echo "⚠️ Failed to reload Hyprland"
  fi
}

# === MENU ===

echo "🔧 Dotfiles Setup for $HOST"
echo "1) Full setup"
echo "2) Partial setup"
read -rp "Choose an option [1-2]: " choice

case $choice in
1)
  setup_global_bin
  setup_global_configs
  setup_git_configs
  setup_aliases
  setup_bashrc
  setup_device_specific
  ;;
2)
  echo "Partial setup selected. Choose what to apply:"
  read -rp "Setup global bin? [y/N]: " bin_choice
  [[ $bin_choice =~ ^[Yy]$ ]] && setup_global_bin

  read -rp "Setup global configs? [y/N]: " configs_choice
  [[ $configs_choice =~ ^[Yy]$ ]] && setup_global_configs

  read -rp "Setup git configs? [y/N]: " git_configs_choice
  [[ $git_configs_choice =~ ^[Yy]$ ]] && setup_git_configs

  read -rp "Setup aliases? [y/N]: " aliases_choice
  [[ $aliases_choice =~ ^[Yy]$ ]] && setup_aliases

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

echo "✅ Dotfiles applied for $HOST"
reload_hyprland
