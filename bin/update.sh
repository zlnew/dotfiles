#!/usr/bin/env bash
set -e

git add .
git commit -m "chore(dotfiles): update configs ($(date +'%Y-%m-%d %H:%M'))"
git push

echo "✅ Dotfiles updated & pushed"
