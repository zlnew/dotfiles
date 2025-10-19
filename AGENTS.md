# Agent Handbook

## Mission Brief
- Keep the shared `.config` baseline compositor-agnostic; apply WM-specific tweaks only within their overlays.
- Honour the repository conventions laid out by the maintainer—this file is the single source of truth for automation.

## Key Locations
- `.config/` — shared configs for fish, alacritty, nvim, waybar, mako, zellij, systemd user units, etc.
- `.local/` — wallpapers, icons, helper binaries; scripts here must stay portable.
- `hyprland/.config/` — Hyprland-specific configs (`hypr/config/*.conf`, scripts, GTK overrides).
- `niri/.config/` — Niri KDL config and matching GTK/Kvantum overrides.
- `plasma/.config/` — minimal Plasma overrides layered on top of the shared baseline.
- `etc/` — keyd layouts, battery limit config, and systemd units intended for `/etc`.

## Editing Guardrails
- Shared tweaks belong under `.config/` or `.local/`; Hyprland work stays in `hyprland/.config/hypr/`, and Niri work in `niri/.config/niri/config.kdl`.
- Hypr config blocks and KDL files use four-space indentation; JSON/JSONC and CSS (Waybar) use two spaces.
- Shell scripts must be POSIX-friendly Bash with `set -e`, snake_case helper names, and descriptive filenames.
- Preserve ASCII section banners and uppercase MOD names in keybinding files; update related helper scripts when bindings change.
- No machine-specific absolute paths or secrets—reference environment files and `$HOME/.local` instead.

## Core Commands
- `./bin/setup.sh` — bootstrap or re-link configs; partial mode allows targeted refreshes.
- `./bin/refresh-session.sh` — restart Waybar, mako, wallpapers, and reload the compositor after theme or config updates.
- `./bin/update.sh` — stage, commit, and push with the standard message `chore(dotfiles): update configs (YYYY-MM-DD HH:MM)`.
- `./.config/colors/generate.sh <theme>` — regenerate color assets (Gruvbox or TokyoNight) without running the full installer.

## Validation Checklist
- Run `./bin/setup.sh` inside a temporary directory to confirm symlinks resolve cleanly.
- `hyprctl reload` after Hyprland changes (the setup script will attempt this automatically).
- `niri --validate ~/.config/niri/config.kdl` followed by `niri msg reload-config` for Niri updates.
- `env XDG_CONFIG_HOME=/tmp/test-config fish --init-command 'exit'` to catch fish startup issues.
- Restart `plasmashell` (or log out and back in) when adjusting Plasma overrides.

## Commits & Reviews
- Commits use the conventional format `chore(dotfiles): update configs (YYYY-MM-DD HH:MM)` unless the maintainer requests otherwise.
- Document required packages, targeted environments, and validation steps in PR descriptions; include before/after screenshots when visuals change.

## Security Notes
- Keep tokens and machine-local data out of the repo; store under `$HOME/.local` and source via `environment.conf`.
- When adjusting keybindings, update comments and helper scripts (e.g., Waybar overlays, hotkey menus) to keep user-facing hints accurate.
