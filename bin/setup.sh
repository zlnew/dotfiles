#!/usr/bin/env bash
set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

# --- backup ------------------------------------------------------------------
backup() {
  local dest=$1
  local backup_dir="$HOME/.dotfiles_backup"

  mkdir -p "$backup_dir"

  if [[ -e "$dest" && ! -L "$dest" ]]; then
    echo "backing up: $dest -> $backup_dir"
    mv "$dest" "$backup_dir/"
  fi
}

# --- link --------------------------------------------------------------------
link() {
  local src=$1
  local dest=$2

  if [[ -e "$dest" && ! -L "$dest" ]]; then
    backup "$dest"
  elif [[ -L "$dest" && "$(readlink "$dest")" != "$src" ]]; then
    echo "cleanup: $dest"
    rm -rf "$dest"
  elif [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    echo "keeping: $dest"
    return 0
  fi

  if [[ -e "$dest" || -L "$dest" ]]; then
    echo "override: $dest"
    rm -rf "$dest"
  fi

  echo "linking: $src"
  ln -s "$src" "$dest"
}

# --- section -----------------------------------------------------------------
section() {
  local label=$1
  printf '\n===== %s =====\n' "$label"
}

# --- setup_global_configs ----------------------------------------------------
setup_global_configs() {
  section "Global configs"
  for dir in .config/*; do
    link "$(pwd)/$dir" "$HOME/.config/$(basename "$dir")"
  done
}

# --- setup_git_configs --------------------------------------------------------
setup_git_configs() {
  section "Git configs"
  link "$(pwd)/.gitconfig" "$HOME/.gitconfig"
  link "$(pwd)/.gitmessage.txt" "$HOME/.gitmessage.txt"
}

# --- setup_local_bin ----------------------------------------------------------
setup_local_bin() {
  section "~/.local/bin"
  # echo "🚀 Linking helper binaries into \$HOME/.local/bin..."
  mkdir -p "$HOME/.local/bin"
  for file in .local/bin/*; do
    link "$(pwd)/$file" "$HOME/.local/bin/$(basename "$file")"
  done
}

# --- setup_local_share --------------------------------------------------------
setup_local_share() {
  section "~/.local/share"
  # echo "🖼️ Linking shared assets into \$HOME/.local/share..."
  mkdir -p "$HOME/.local/share"
  for dir in .local/share/*; do
    link "$(pwd)/$dir" "$HOME/.local/share/$(basename "$dir")"
  done
}

# --- setup_aliases ------------------------------------------------------------
setup_aliases() {
  section "Shell aliases"
  link "$(pwd)/.aliases" "$HOME/.aliases"
}

# --- setup_bashrc -------------------------------------------------------------
setup_bashrc() {
  section ".bashrc"
  link "$(pwd)/.bashrc" "$HOME/.bashrc"
}

# --- setup_zshrc --------------------------------------------------------------
setup_zshrc() {
  section ".zshrc"
  link "$(pwd)/.zshrc" "$HOME/.zshrc"
}

# --- choose_colorscheme -------------------------------------------------------
choose_colorscheme() {
  section "Theme assets"
  echo " 1) Gruvbox Material (dark)"
  echo " 2) TokyoNight (night)"
  local colorscheme_choice
  read -rp "Select colorscheme [1-2, default 1]: " colorscheme_choice

  local theme
  case $colorscheme_choice in
  1 | "")
    theme="gruvbox"
    ;;
  2)
    theme="tokyonight"
    ;;
  *)
    echo "Invalid choice. Falling back to Gruvbox Material."
    theme="gruvbox"
    ;;
  esac

  echo "Generating $theme assets..."
  "$REPO_ROOT/.config/colors/generate.sh" "$theme"
}

# --- setup_device_specific ----------------------------------------------------
setup_device_specific() {
  section "Desktop overlays"
  echo " 1) Hyprland (Wayland tiling)"
  echo " 2) Niri (Wayland tiling)"
  echo " 3) Plasma (KDE)"
  echo " 4) None (skip overlays)"
  read -rp "Select overlay [1-4, type 4 to skip]: " device_choice

  case $device_choice in
  1)
    for dir in hyprland/.config/*; do
      link "$(pwd)/$dir" "$HOME/.config/$(basename "$dir")"
    done
    reload_hyprland
    ;;
  2)
    for dir in niri/.config/*; do
      link "$(pwd)/$dir" "$HOME/.config/$(basename "$dir")"
    done
    ;;
  3)
    for dir in plasma/.config/*; do
      link "$(pwd)/$dir" "$HOME/.config/$(basename "$dir")"
    done
    ;;
  4)
    echo "ℹ️ Skipping device-specific overlays."
    ;;
  *)
    echo "Invalid selection. Skipping device-specific overlays."
    ;;
  esac
}

# --- reload_hyprland ----------------------------------------------------------
reload_hyprland() {
  if command -v hyprctl >/dev/null 2>&1; then
    section "Hyprland reload"
    hyprctl reload || echo "⚠️ Failed to reload Hyprland"
  fi
}

# --- refresh_session ----------------------------------------------------------
refresh_session() {
  section "Session refresh"
  if [[ -x "$REPO_ROOT/bin/refresh-session.sh" ]]; then
    echo "Refreshing Wayland session helpers..."
    "$REPO_ROOT/bin/refresh-session.sh" || echo "⚠️ Failed to refresh desktop session"
  else
    echo "ℹ️ refresh-session script not found. Skipping desktop refresh."
  fi
}

# === MENU ===

echo "Dotfiles Setup Wizard"
echo " 1) Full setup"
echo " 2) Partial setup"
read -rp "Select mode [1-2]: " choice

case $choice in
1)
  setup_global_configs
  setup_git_configs
  setup_local_bin
  setup_local_share
  setup_aliases
  setup_zshrc
  setup_bashrc
  choose_colorscheme
  setup_device_specific
  ;;
2)
  echo "Partial setup selected. Choose what to apply:"
  read -rp "Setup global configurations? [y/N]: " configs_choice
  [[ $configs_choice =~ ^[Yy]$ ]] && setup_global_configs

  read -rp "Link git configs (.gitconfig, .gitmessage)? [y/N]: " git_configs_choice
  [[ $git_configs_choice =~ ^[Yy]$ ]] && setup_git_configs

  read -rp "Link helper binaries into ~/.local/bin? [y/N]: " local_bin_choice
  [[ $local_bin_choice =~ ^[Yy]$ ]] && setup_local_bin

  read -rp "Link shared assets into ~/.local/share? [y/N]: " local_share_choice
  [[ $local_share_choice =~ ^[Yy]$ ]] && setup_local_share

  read -rp "Link shell aliases? [y/N]: " aliases_choice
  [[ $aliases_choice =~ ^[Yy]$ ]] && setup_aliases

  read -rp "Link .zshrc? [y/N]: " zshrc_choice
  [[ $zshrc_choice =~ ^[Yy]$ ]] && setup_zshrc

  read -rp "Link .bashrc? [y/N]: " bashrc_choice
  [[ $bashrc_choice =~ ^[Yy]$ ]] && setup_bashrc

  read -rp "Regenerate themed assets? [y/N]: " colorscheme_choice
  [[ $colorscheme_choice =~ ^[Yy]$ ]] && choose_colorscheme

  read -rp "Apply device overlay (Hyprland/Niri/Plasma)? [y/N]: " device_choice
  [[ $device_choice =~ ^[Yy]$ ]] && setup_device_specific
  ;;
*)
  echo "Invalid choice. Exiting."
  exit 1
  ;;
esac

refresh_session

echo "Dotfiles setup complete"
