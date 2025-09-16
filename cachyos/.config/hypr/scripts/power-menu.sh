#!/usr/bin/env bash

# Simple confirmation menu using wofi
ACTION=$(printf " Cancel\n Poweroff\n Reboot\n Suspend\n Hibernate" | \
wofi --dmenu --prompt "Power Menu")

case "$ACTION" in
  " Poweroff") systemctl poweroff ;;
  " Reboot") systemctl reboot ;;
  " Suspend") systemctl suspend ;;
  " Hibernate") systemctl hibernate ;;
  *) exit 0 ;;
esac

