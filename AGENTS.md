# Repository Guidelines

## Project Structure & Module Organization
Shared configs live under `.config/` (fish, waybar, nvim) and must stay window-manager agnostic. Hyprland-specific overrides sit in `hyprland/.config/`, while Niri keeps its own under `niri/.config/`. Limit Hyprland tweaks to `hypr/config/*.conf` (e.g., `hypr/config/monitor.conf`) and Niri changes to `niri/config.kdl`. Place helper scripts in `bin/` or `hyprland/.config/hypr/scripts/` to keep per-environment tooling isolated.

## Build, Test, and Development Commands
Run `./bin/setup.sh` to bootstrap or refresh symlinks; choose “Partial setup” when validating a single area. Use `./bin/update.sh` to stage, commit, and push routine configuration updates. Reload Hyprland changes with `hyprctl reload`. Apply Niri changes via `niri msg reload-config`, or fall back to `niri --validate ~/.config/niri/config.kdl` before restarting.

## Coding Style & Naming Conventions
Indent JSON/JSONC and CSS with two spaces as exemplified in `.config/waybar/config`. Use four-space blocks in KDL and Hypr `.conf` files, keeping MOD key names uppercase and preserving ASCII section banners. Write shell scripts in POSIX-friendly Bash with `set -e`, snake_case function names, and descriptive file names like `waybar-toggle` or `monitor-hook.sh`. Keep machine-specific secrets out of the repo and reference them via environment files.

## Testing Guidelines
After edits, rerun `./bin/setup.sh` inside a temporary directory to ensure symlinks resolve cleanly. Validate Hyprland syntax with `hyprctl reload`, and confirm Niri configuration health using `niri --validate ~/.config/niri/config.kdl` before issuing `niri msg reload-config`. For fish changes, run `env XDG_CONFIG_HOME=/tmp/test-config fish --init-command 'exit'` to catch startup errors.

## Commit & Pull Request Guidelines
Follow the conventional commit pattern `chore(dotfiles): update configs (YYYY-MM-DD HH:MM)` to match history. PRs should call out the target environment (Hyprland, Niri, or shared), list any required packages, and include before/after screenshots when visuals change. Reference related issues or TODOs, and confirm that setup, reload, and validation commands were executed.

## Security & Configuration Tips
Store sensitive tokens under `$HOME/.local` and source them through `environment.conf` rather than committing secrets. When modifying Hyprland or Niri bindings, update both the inline comments and any related helper scripts so keybinding overlays stay accurate. Keep configs portable by avoiding machine-specific paths unless they are gated by environment checks.
