#!/usr/bin/env bash
set -euo pipefail

wallpaper_path="${HOME}/.local/share/wallpapers/waves.png"

log() {
  printf '[refresh-session] %s\n' "$1"
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
  if [[ ! -f "$wallpaper_path" ]]; then
    log "warning: wallpaper file not found: ${wallpaper_path}"
    return
  fi

  if command -v swww >/dev/null 2>&1; then
    launch_swww "$wallpaper_path"
  elif command -v swaybg >/dev/null 2>&1; then
    launch_swaybg "$wallpaper_path"
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
  if pgrep -x Hyprland >/dev/null 2>&1; then
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
