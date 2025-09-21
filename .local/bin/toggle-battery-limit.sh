#!/usr/bin/env bash
set -e

LIMIT=$1

if [[ -z "$LIMIT" ]]; then
  echo "Usage: $0 <60|80|100>"
  exit 1
fi

if [[ "$LIMIT" != "60" && "$LIMIT" != "80" && "$LIMIT" != "100" ]]; then
  echo "Error: Invalid limit. Please use 60, 80, or 100."
  exit 1
fi

# Update config file
sudo bash -c "echo BATTERY_LIMIT=$LIMIT > /etc/battery-limit.conf"

# Restart the service so it applies the new limit
sudo systemctl restart battery-limit.service

echo "✅ Battery limit set to $LIMIT%"
