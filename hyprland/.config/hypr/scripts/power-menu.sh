#!/usr/bin/env bash

# Simple confirmation menu using rofi
ACTION=$(printf "Cancel\nPoweroff\nReboot\nSuspend\nHibernate" | \
rofi -dmenu -p "Power" -no-fixed-num-lines)

case "$ACTION" in
  "Poweroff") systemctl poweroff ;;
  "Reboot") systemctl reboot ;;
  "Suspend") systemctl suspend ;;
  "Hibernate") systemctl hibernate ;;
  *) exit 0 ;;
esac

