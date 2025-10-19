# 🧰 Fresh Install Guide

Opinionated checklist for rebuilding a CachyOS/Arch workstation that matches the dotfiles in this repo. Adjust package manager commands if you are on another distro, but keep the tooling selections aligned so the configs behave as expected.

## 0. Pre-flight
- Finish the base CachyOS install, create your user, and sync the system:
  ```bash
  sudo pacman -Syu
  ```
- Enable multilib and CachyOS repos as desired, then reboot before proceeding.
- Install `git` and configure SSH keys so you can clone private repositories later.
- Install an AUR helper (e.g. `paru`):
  ```bash
  sudo pacman -S --needed rustup
  rustup default stable
  git clone https://aur.archlinux.org/paru.git ~/build/paru
  (cd ~/build/paru && makepkg -si)
  ```

## 1. System Packages

### Core CLI & Shell
```bash
sudo pacman -S --needed \
  base-devel git curl wget unzip fish zellij zoxide eza bat ripgrep fd fastfetch \
  fzf python-pip starship lazygit neovim tree-sitter ripgrep-all
```
- Switch the login shell when you are ready: `chsh -s /usr/bin/fish`.

### Wayland Stack
```bash
sudo pacman -S --needed \
  hyprland niri waybar mako fuzzel alacritty swaybg swww wl-clipboard \
  brightnessctl playerctl pipewire wireplumber pavucontrol blueberry \
  grim slurp wl-screenrec imagemagick qt5ct qt6ct kvantum
```
- Install xdg portals: `sudo pacman -S xdg-desktop-portal-hyprland xdg-desktop-portal-gtk`.
- Optional screen locker: `sudo pacman -S swaylock-effects`.

### Hardware & System Utilities
```bash
sudo pacman -S --needed keyd tlp lm_sensors acpi acpid powertop upower \
  bluez bluez-utils networkmanager nm-connection-editor
```
- Enable services:
  ```bash
  sudo systemctl enable --now NetworkManager bluetoothd acpid
  ```

### Optional Minimal Plasma Layer
Install only if you plan to use the Plasma overlay from this repo:
```bash
sudo pacman -S --needed plasma-desktop dolphin kwalletmanager plasma-nm plasma-pa kscreen
```

## 2. Development Tooling

### PHP Stack
```bash
paru -S --needed phpenv
sudo pacman -S --needed composer php-pear nginx redis postgresql pgcli
```
- Initialize PostgreSQL: `sudo -iu postgres initdb -D /var/lib/postgres/data && sudo systemctl enable --now postgresql`.
- Install desired PHP versions with PostgreSQL support:
  ```bash
  export PHP_BUILD_CONFIGURE_OPTS="--with-pgsql --with-pdo-pgsql --with-pear"
  phpenv install 8.2.29
  phpenv global 8.2.29
  ```
- Enable the bundled user service after cloning the dotfiles:
  ```bash
  systemctl --user enable --now php-fpm-phpenv.service
  ```

### Node, Bun, and Frontend Tooling
- Install `nvm` (official install script) and add the latest LTS Node:
  ```bash
  curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  nvm install --lts
  ```
- Install Bun:
  ```bash
  curl -fsSL https://bun.sh/install | bash
  ```

### Language Servers & Formatters
```bash
npm install -g \
  vue-language-server @vtsls/language-server @tailwindcss/language-server \
  eslint_d @fsouza/prettierd intelephense
```
- Tree-sitter CLI is already installed via pacman above; update grammars in Neovim after running `:Lazy sync`.

### Databases & Services
- Start Redis (or Valkey if you install it from the AUR): `sudo systemctl enable --now redis`.
- Optional: `paru -S valkey` if you need the drop-in alternative to Redis.
- Optional: `paru -S mysql` if MySQL/MariaDB work is needed (not covered by these dotfiles).

## 3. System Configuration Files
- Copy system-level helpers from the repo once it is cloned:
  ```bash
  sudo cp -r ~/dotfiles/etc/keyd /etc/
  sudo cp ~/dotfiles/etc/battery-limit.conf /etc/
  sudo cp ~/dotfiles/etc/systemd/system/batterylimitctl@.service /etc/systemd/system/
  ```
- Enable services:
  ```bash
  sudo systemctl enable --now keyd
  sudo systemctl enable --now batterylimitctl@BAT0.service
  ```
- Adjust `/etc/battery-limit.conf` to the desired default (60, 80, or 100) and apply with `batterylimitctl set 80`.

### Disable Plymouth Splash on CachyOS (Optional)
1. Edit `/etc/sdboot-manage.conf` and update `LINUX_OPTIONS`:
   - Add: `plymouth.enable=0 disablehooks=plymouth`
   - Remove: `splash`
   - Regenerate entries: `sudo sdboot-manage gen`
2. Remove `plymouth` from `/etc/mkinitcpio.conf` `HOOKS`, then rebuild: `sudo mkinitcpio -P`.

## 4. Dotfiles Bootstrap
```bash
git clone git@github.com:zlnew/dotfiles.git ~/dotfiles
cd ~/dotfiles
./bin/setup.sh
```
- Choose Gruvbox or TokyoNight when prompted; rerun `.config/colors/generate.sh <theme>` to switch later.
- Use partial mode to re-link only the sections you need during maintenance.
- After linking, run `bin/refresh-session.sh` to restart wallpapers, Waybar, and mako with the new theme.

## 5. Desktop-Specific Notes
- **Hyprland**: install `xdg-desktop-portal-hyprland`, `hypridle`, and `hyprpaper` if you extend the setup; reload with `hyprctl reload`.
- **Niri**: validate config updates before applying: `niri --validate ~/.config/niri/config.kdl` then `niri msg reload-config`.
- **Waybar/Mako**: the configs expect `wl-clipboard`, `playerctl`, `brightnessctl`, `wireplumber`, and `pavucontrol`.
- **Wallpaper tools**: `swww` is preferred, but the scripts fall back to `swaybg`.

## 6. Post-install Tasks
- Generate SSH keys (`ssh-keygen -t ed25519`) and add them to your password manager.
- Clone the rest of your projects under `~/www` for consistency.
- Populate language-specific package managers (Composer `global require`, cargo, pip, etc.) as required by your workloads.
- Run the validation checklist from the `README.md` to confirm everything reloads cleanly.

You are now ready to daily-drive the dotfiles. Revisit this checklist the next time you reprovision a laptop or VM so new tooling makes it into the base image.
