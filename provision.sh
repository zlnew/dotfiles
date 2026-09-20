#!/usr/bin/env bash
# Provision system dependencies for cachyos-niri-noctalia dotfiles.
# CachyOS only. Idempotent: pacman --needed + command -v guards.
# Usage: ./provision.sh [--yes]
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACMAN_FLAGS=()
for arg in "$@"; do
  case "$arg" in
    --yes) PACMAN_FLAGS+=(--noconfirm) ;;
    -h|--help) echo "Usage: ./provision.sh [--yes]"; exit 0 ;;
    *) echo "Unknown arg: $arg" >&2; exit 1 ;;
  esac
done

if [[ ! -f /etc/cachyos-release ]] && ! grep -qi 'ID=cachyos' /etc/os-release 2>/dev/null; then
  echo "error: CachyOS only (no /etc/cachyos-release)" >&2
  exit 1
fi

have() { command -v "$1" >/dev/null 2>&1; }

section() { printf '\n===== %s =====\n' "$1"; }

section "pacman (official repos, no AUR needed)"
sudo pacman -S --needed "${PACMAN_FLAGS[@]}" \
  git base-devel fish neovim zellij alacritty niri noctalia lazygit keyd \
  zoxide git-delta ripgrep fd fzf eza bat libsecret libnotify \
  go php composer lua-language-server uv \
  tree-sitter-cli \
  docker docker-compose \
  tailscale discord zen-browser-bin \
  ttf-jetbrains-mono-nerd

section "tailscale service"
sudo systemctl enable --now tailscaled
echo "note: first run needs: sudo tailscale up"

section "docker service"
sudo systemctl enable --now docker
if ! id -nG "$USER" | grep -qw docker; then
  sudo usermod -aG docker "$USER"
  echo "note: log out/in for docker group to take effect"
fi

section "nvm (standalone, bash-compatible)"
export NVM_DIR="$HOME/.nvm"
if [[ ! -s "$NVM_DIR/nvm.sh" ]]; then
  NVM_VERSION="$(curl -fsSL https://api.github.com/repos/nvm-sh/nvm/releases/latest | grep -m1 '"tag_name"' | cut -d'"' -f4 || true)"
  NVM_VERSION="${NVM_VERSION:-v0.40.1}"
  curl -fsSL -o- "https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh" | bash
fi
# shellcheck disable=SC1091
. "$NVM_DIR/nvm.sh"

section "node LTS (default)"
nvm install --lts
nvm alias default 'lts/*'
nvm use default
node --version

section "link dotfiles (safe, idempotent — needed before fisher)"
"$REPO_ROOT/install.sh"

section "fisher + fish plugins (incl. nvm.fish)"
if ! fish -c 'type -q fisher' 2>/dev/null; then
  fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'
fi
fish -c "fisher update"
# nvm.fish activates per-shell only; default for new shells is a universal var
fish -c 'nvm install lts; set --universal nvm_default_version (node --version)'
fish -c 'type -q nvm && echo "nvm.fish OK, default: $nvm_default_version"'

section "npm globals (no official toolchain upstream)"
have npm || { echo "error: npm missing after nvm setup" >&2; exit 1; }
npm i -g bash-language-server fish-lsp @vtsls/language-server vue-language-server \
  tailwindcss-language-server intelephense \
  @fsouza/prettierd eslint_d

section "opencode (SST)"
have opencode || curl -fsSL https://opencode.ai/v2/install | bash

section "pi (earendil-works)"
have pi || curl -fsSL https://pi.dev/install.sh | sh

section "agy (Antigravity CLI, Google)"
have agy || curl -fsSL https://antigravity.google/cli/install.sh | bash
# First run is interactive (Google OAuth). Headless needs GEMINI_API_KEY;
# ~/.env ships GOOGLE_API_KEY — export as GEMINI_API_KEY if you run agy -p.

section "herdr (agent multiplexer, last so it detects the agents above)"
have herdr || curl -fsSL https://herdr.dev/install.sh | sh
# Self-updates via `herdr update`. Integrations: herdr integration install {pi,opencode,antigravity-cli}

section "toolchains on PATH (idempotent have-checks below need these)"
export PATH="$HOME/.local/bin:$HOME/go/bin:$HOME/.config/composer/vendor/bin:$PATH"

section "uv tools (official Python distributions)"
have uv || { echo "error: uv missing" >&2; exit 1; }
have basedpyright-langserver || uv tool install basedpyright
have ruff || uv tool install ruff

section "gopls (npm has no Go)"
have go || { echo "error: go missing" >&2; exit 1; }
have gopls || go install golang.org/x/tools/gopls@latest

section "composer globals (pint, no npm equivalent)"
have composer || { echo "error: composer missing" >&2; exit 1; }
composer global show laravel/pint >/dev/null 2>&1 || composer global require laravel/pint

section "verify"
"$REPO_ROOT/install.sh" --check || true
for b in fish nvim zellij alacritty niri noctalia lazygit delta git keyd \
  zoxide rg fd fzf node npm uv go gopls composer pint \
  basedpyright-langserver ruff opencode pi agy herdr docker \
  tailscale discord zen-browser; do
  if have "$b"; then printf "%-24s %s\n" "$b" "$(command -v "$b")"
  else printf "%-24s MISSING\n" "$b"; fi
done

echo
echo "done. manual leftovers:"
echo "  - keyd: sudo cp system/keyd/*.conf /etc/keyd/ && sudo systemctl restart keyd"
echo "  - ensure ~/.local/bin + \$GOPATH/bin + ~/.composer/vendor/bin are on PATH"
