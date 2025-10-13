#!/usr/bin/env bash

CHOICE=$(printf "Cancel\nLogout" | rofi -dmenu -p "Exit Hyprland?" -theme-str 'window {width: 200px; height: 105px;} listview {columns: 2;}')

case "$CHOICE" in
  "🚪 Logout")
    hyprctl dispatch exit
    ;;
  *)
    exit 0
    ;;
esac

