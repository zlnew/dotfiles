# Dotfiles

Wayland-first dotfiles that keep Hyprland, Niri, and a minimal Plasma setup aligned while sharing a single, WM-agnostic core. Everything defaults to the shared `.config` baseline and layers compositor-specific tweaks only when you opt into them.

## Supported Environments
- **Shared core**: Fish shell, Neovim (`lazy.nvim`), zellij, Waybar, mako, alacritty, systemd user services, wallpapers, and helper scripts.
- **Hyprland**: Layered config split across `hypr/config/*.conf`, wallpaper hooks, and XDG portal tweaks under `hyprland/.config/`.
- **Niri**: Opinionated KDL config with overlay-aware keybinding hints under `niri/.config/`.
- **Plasma (minimal)**: Keybindings, theme overrides, and panel layout under `plasma/.config/`.

## Directory Map
```
.
├── .config/            # WM-agnostic configs (alacritty, fish, nvim, waybar, etc.)
├── .local/             # Wallpapers, icons, helper binaries
├── bin/                # setup.sh, refresh-session.sh, update.sh
├── etc/                # keyd layouts, systemd units, misc /etc snippets
├── hyprland/.config/   # Hyprland-specific configs and scripts
├── niri/.config/       # Niri config.kdl plus GTK/Kvantum overrides
├── plasma/.config/     # Plasma overrides layered on top of the shared configs
├── screenshots/        # Reference captures used in docs
└── fresh-install-guide.md  # Long-form rebuild notes
```

## Bootstrap Workflow
1. **Clone**: `git clone git@github.com:zlnew/dotfiles.git ~/dotfiles && cd ~/dotfiles`
2. **Run the installer**: `./bin/setup.sh`
   - Full mode links everything, backs up conflicts to `~/.dotfiles_backup/`, and asks which compositor overlay to apply.
   - Partial mode lets you re-run only the sections you want (shared configs, git dotfiles, local bin/share, shell RCs, overlays).
3. **Pick a colorscheme** when prompted; the generator at `.config/colors/generate.sh` renders Waybar CSS, alacritty TOML, and Hyprland palette files for Gruvbox Material or TokyoNight.
4. **Optional overlays**: Choose Hyprland, Niri, or Plasma to symlink compositor-specific configs on top of the shared baseline. The Hyprland option attempts an automatic `hyprctl reload` if available.
5. **Refresh the session**: `bin/refresh-session.sh` restarts Waybar, mako, wallpapers, and reloads the active compositor to pick up theme changes.

## Everyday Commands
- `./bin/setup.sh` — relink configs after edits; partial mode is ideal for quick validation.
- `./bin/refresh-session.sh` — restart status bars, notifications, and wallpapers after changing themes.
- `./bin/update.sh` — stage, commit, and push with the conventional `chore(dotfiles): update configs (YYYY-MM-DD HH:MM)` message.
- `./.config/colors/generate.sh <theme>` — regenerate color assets without running the full installer.

## Editing Guidelines
- Shared tweaks live under `.config/` and `.local/`; compositor-specific logic belongs in `hyprland/.config/hypr/config/*.conf` or `niri/.config/niri/config.kdl`.
- Helper scripts should be POSIX-friendly Bash (`set -e`), live under `bin/` or the compositor-specific `scripts/` directories, and use snake_case names.
- Keep configs portable: prefer environment checks over machine-specific paths, and store sensitive data under `$HOME/.local`.

## Validation Checklist
- `./bin/setup.sh` in a temporary directory to ensure symlinks resolve cleanly.
- `hyprctl reload` after Hyprland edits (the setup script runs this automatically when possible).
- `niri --validate ~/.config/niri/config.kdl` followed by `niri msg reload-config` for Niri changes.
- `env XDG_CONFIG_HOME=/tmp/test-config fish --init-command 'exit'` to catch fish startup errors.
- Restart `plasmashell` (or log out/in) to apply Plasma overrides.

## More Documentation
- `fresh-install-guide.md` — full package list and bootstrap notes for a new workstation.
- `AGENTS.md` — concise rules of the road for tooling and automation.

## Screenshots
- ![Hyprland workspace](screenshots/2025-10-01T17:28:51,372724276+07:00.png)
- ![Niri overview](screenshots/2025-10-01T17:27:50,967586453+07:00.png)
- ![Neovim setup](screenshots/2025-10-01T17:27:16,214358722+07:00.png)
