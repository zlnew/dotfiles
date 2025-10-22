#!/usr/bin/env bash
set -euo pipefail

theme_file="${HOME}/.config/colors/theme"
wallpaper_dir="${HOME}/.local/share/wallpapers"
hypr_wallpaper_script="${HOME}/.config/hypr/scripts/set-wallpaper.sh"

log() {
  printf '[refresh-session] %s\n' "$1"
}

choose_wallpaper() {
  local fallback="waves.png"

  if [[ ! -f "$theme_file" ]]; then
    printf '%s\n' "$fallback"
    return
  fi

  local theme
  read -r theme <"$theme_file"
  case "$theme" in
    tokyonight) printf '%s\n' "apocalypse.jpg" ;;
    gruvbox|"") printf '%s\n' "$fallback" ;;
    *) printf '%s\n' "$fallback" ;;
  esac
}

launch_swaybg() {
  pkill -x swaybg >/dev/null 2>&1 || true
  swaybg -i "$1" -m fill >/dev/null 2>&1 &
}

launch_swww() {
  if ! pgrep -x swww-daemon >/dev/null 2>&1; then
    swww-daemon >/dev/null 2>&1 &
    sleep 0.2
  fi
  swww img "$1" >/dev/null 2>&1
}

reload_wallpaper() {
  if [[ -x "$hypr_wallpaper_script" ]]; then
    "$hypr_wallpaper_script" || log "warning: Hyprland wallpaper script exited with errors"
    return
  fi

  local wallpaper path
  wallpaper=$(choose_wallpaper)
  path="${wallpaper_dir}/${wallpaper}"

  if [[ ! -f "$path" ]]; then
    log "warning: wallpaper file not found: ${path}"
    return
  fi

  if command -v swww >/dev/null 2>&1; then
    launch_swww "$path"
  elif command -v swaybg >/dev/null 2>&1; then
    launch_swaybg "$path"
  else
    log "warning: no wallpaper command (swww or swaybg) available"
  fi
}

restart_waybar() {
  if ! command -v waybar >/dev/null 2>&1; then
    return
  fi

  pkill -x waybar >/dev/null 2>&1 || true
  sleep 0.1
  setsid -f waybar >/dev/null 2>&1 || log "warning: failed to launch waybar"
}

restart_mako() {
  if ! command -v mako >/dev/null 2>&1; then
    return
  fi

  pkill -x mako >/dev/null 2>&1 || true
  sleep 0.1
  setsid -f mako >/dev/null 2>&1 || log "warning: failed to launch mako"
}

reload_compositor() {
  if pgrep -x hyprland >/dev/null 2>&1; then
    hyprctl reload >/dev/null 2>&1 || log "warning: hyprctl reload failed"
  elif pgrep -x niri >/dev/null 2>&1; then
    niri msg action load-config-file >/dev/null 2>&1 || log "warning: niri reload-config failed"
  fi
}

main() {
  reload_wallpaper
  restart_waybar
  restart_mako
  reload_compositor
}

main "$@"
