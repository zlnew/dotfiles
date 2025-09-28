#!/usr/bin/env bash

hyprctl monitors -j | jq -r '.[].name' | grep -q "HDMI-A-1"
HDMI_DETECTED=$?

hyprctl monitors -j | jq -r '.[].name' | grep -q "eDP-1"
EDP_DETECTED=$?

if [ $HDMI_DETECTED -eq 0 ] && [ $EDP_DETECTED -eq 0 ]; then
  for ws in 1 2; do
    hyprctl dispatch workspace "$ws"
    hyprctl dispatch moveworkspacetomonitor "$ws" HDMI-A-1
  done

  for ws in 9 10; do
    hyprctl dispatch workspace "$ws"
    hyprctl dispatch moveworkspacetomonitor "$ws" eDP-1
  done
fi

