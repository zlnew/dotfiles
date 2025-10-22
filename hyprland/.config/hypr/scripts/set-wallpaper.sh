#!/usr/bin/env bash
set -euo pipefail

wallpaper_dir="${HOME}/.local/share/wallpapers"
theme_file="${HOME}/.config/colors/theme"
default_wallpaper="waves.png"

choose_wallpaper() {
    local selected="$default_wallpaper"

    if [[ -f "$theme_file" ]]; then
        read -r theme <"$theme_file"
        case "$theme" in
            tokyonight) selected="apocalypse.jpg" ;;
            gruvbox) selected="waves.png" ;;
            *) selected="$default_wallpaper" ;;
        esac
    fi

    printf "%s\n" "$selected"
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

main() {
    local wallpaper
    wallpaper=$(choose_wallpaper)
    local path="${wallpaper_dir}/${wallpaper}"

    if [[ ! -f "$path" ]]; then
        echo "set-wallpaper: missing file ${path}" >&2
        return 0
    fi

    if command -v swaybg >/dev/null 2>&1; then
        launch_swaybg "$path"
    elif command -v swww >/dev/null 2>&1; then
        launch_swww "$path"
    else
        echo "set-wallpaper: no swaybg or swww command available" >&2
    fi
}

main "$@"
