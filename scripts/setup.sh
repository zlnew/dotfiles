#!/usr/bin/env bash
set -e

HOST=$(hostname)

echo "🔗 Stowing universal configs..."
stow .config

if [[ $HOST == "cachyos-pc" ]]; then
  echo "🔗 Stowing CachyOS-specific configs..."
  stow cachyos
elif [[ $HOST == "kubuntu-laptop" ]]; then
  echo "🔗 Stowing Kubuntu-specific configs..."
  stow kubuntu
else
  echo "⚠️ Unknown host: $HOST. Skipping device-specific configs."
fi

echo "✅ Dotfiles applied for $HOST"
