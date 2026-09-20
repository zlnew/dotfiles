#!/usr/bin/env bash
# Provision system dependencies for cachyos-niri-noctalia dotfiles.
# CachyOS only. Idempotent: pacman --needed + command -v guards.
# Quiet by default; --verbose streams every command.
# Usage: ./provision.sh [--yes] [--verbose]
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACMAN_FLAGS=()
UI_VERBOSE=0
for arg in "$@"; do
  case "$arg" in
    --yes) PACMAN_FLAGS+=(--noconfirm) ;;
    --verbose) UI_VERBOSE=1 ;;
    -h|--help) echo "Usage: ./provision.sh [--yes] [--verbose]"; exit 0 ;;
    *) echo "Unknown arg: $arg" >&2; exit 1 ;;
  esac
done

if [[ -f "$REPO_ROOT/lib/ui.sh" ]]; then
  # shellcheck disable=SC1091
  source "$REPO_ROOT/lib/ui.sh"
else
  ui_init() { :; }
  step() { printf '• %s … ' "$1"; }
  ok() { printf 'ok %s\n' "${1:-}"; }
  skip() { printf 'skip %s\n' "${1:-}"; }
  fail() { printf 'fail %s\n' "${1:-}"; return 1; }
  note() { printf '  note: %s\n' "$1"; }
  warn() { printf '  ! %s\n' "$1"; }
  run() { "$@"; }
  run_sh() { bash -c "$1"; }
  vrun() { "$@" 2>/dev/null | head -n 1; }
fi
export UI_VERBOSE
ui_init "dotfiles-provision"

if [[ ! -f /etc/cachyos-release ]] && ! grep -qi 'ID=cachyos' /etc/os-release 2>/dev/null; then
  echo "error: CachyOS only (no /etc/cachyos-release)" >&2
  exit 1
fi

have() { command -v "$1" >/dev/null 2>&1; }

echo "dotfiles :: provision"

step "pacman (official repos, no AUR)"
run sudo pacman -S --needed "${PACMAN_FLAGS[@]}" \
  git base-devel fish neovim zellij alacritty niri noctalia lazygit keyd \
  zoxide git-delta ripgrep fd fzf eza bat libsecret libnotify \
  go php composer lua-language-server uv \
  tree-sitter-cli \
  docker docker-compose \
  tailscale discord zen-browser-bin \
  ttf-jetbrains-mono-nerd
ok "done"

step "services (tailscale, docker)"
run sudo systemctl enable --now tailscaled
run sudo systemctl enable --now docker
if ! id -nG "$USER" | grep -qw docker; then
  run sudo usermod -aG docker "$USER"
  ok "enabled, docker group added (log out/in)"
else
  ok "enabled"
fi
note "first tailscale run needs: sudo tailscale up"

step "nvm + node LTS"
export NVM_DIR="$HOME/.nvm"
if [[ ! -s "$NVM_DIR/nvm.sh" ]]; then
  NVM_VERSION="$(curl -fsSL https://api.github.com/repos/nvm-sh/nvm/releases/latest | grep -m1 '"tag_name"' | cut -d'"' -f4 || true)"
  NVM_VERSION="${NVM_VERSION:-v0.40.1}"
  run_sh "curl -fsSL -o- \"https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh\" | bash"
fi
# shellcheck disable=SC1091
. "$NVM_DIR/nvm.sh" >/dev/null 2>&1
run nvm install --lts
run nvm alias default 'lts/*'
run nvm use default
ok "$(vrun node --version)"

step "link dotfiles"
if [[ "$UI_VERBOSE" == "1" ]]; then
  "$REPO_ROOT/install.sh" --verbose
else
  run "$REPO_ROOT/install.sh"
fi
ok "linked"

step "fisher + fish plugins"
if ! fish -c 'type -q fisher' 2>/dev/null; then
  run_sh "fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'"
fi
run fish -c "fisher update"
run fish -c 'nvm install lts; set --universal nvm_default_version (node --version)'
ok "updated"

step "npm globals"
have npm || { fail "npm missing after nvm setup"; exit 1; }
run npm i -g bash-language-server fish-lsp @vtsls/language-server vue-language-server \
  tailwindcss-language-server intelephense \
  @fsouza/prettierd eslint_d
ok "8 packages"

step "agents (opencode, pi, agy, herdr)"
agents_new=0
if ! have opencode; then run_sh "curl -fsSL https://opencode.ai/v2/install | bash"; agents_new=$((agents_new + 1)); fi
if ! have pi; then run_sh "curl -fsSL https://pi.dev/install.sh | sh"; agents_new=$((agents_new + 1)); fi
if ! have agy; then run_sh "curl -fsSL https://antigravity.google/cli/install.sh | bash"; agents_new=$((agents_new + 1)); fi
if ! have herdr; then run_sh "curl -fsSL https://herdr.dev/install.sh | sh"; agents_new=$((agents_new + 1)); fi
if [[ "$agents_new" -gt 0 ]]; then ok "$agents_new installed"; else ok "present"; fi
note "agy first run is interactive (Google OAuth)"

export PATH="$HOME/.local/bin:$HOME/go/bin:$HOME/.config/composer/vendor/bin:$PATH"

step "toolchains (uv, gopls, pint)"
tools_new=0
have uv || { fail "uv missing"; exit 1; }
if ! have basedpyright-langserver; then run uv tool install basedpyright; tools_new=$((tools_new + 1)); fi
if ! have ruff; then run uv tool install ruff; tools_new=$((tools_new + 1)); fi
have go || { fail "go missing"; exit 1; }
if ! have gopls; then run go install golang.org/x/tools/gopls@latest; tools_new=$((tools_new + 1)); fi
have composer || { fail "composer missing"; exit 1; }
if ! composer global show laravel/pint >/dev/null 2>&1; then run composer global require laravel/pint; tools_new=$((tools_new + 1)); fi
if [[ "$tools_new" -gt 0 ]]; then ok "$tools_new installed"; else ok "present"; fi

step "verify"
if [[ "$UI_VERBOSE" == "1" ]]; then
  "$REPO_ROOT/install.sh" --check || true
  missing=0
  for b in fish nvim zellij alacritty niri noctalia lazygit delta git keyd \
    zoxide rg fd fzf node npm uv go gopls composer pint \
    basedpyright-langserver ruff opencode pi agy herdr docker \
    tailscale discord zen-browser; do
    if have "$b"; then printf '  %-24s %s\n' "$b" "$(command -v "$b")"
    else printf '  %-24s MISSING\n' "$b"; missing=$((missing + 1)); fi
  done
  [[ "$missing" -eq 0 ]] && ok "all present" || fail "$missing missing"
else
  run "$REPO_ROOT/install.sh" --check || true
  missing=()
  for b in fish nvim zellij alacritty niri noctalia lazygit delta git keyd \
    zoxide rg fd fzf node npm uv go gopls composer pint \
    basedpyright-langserver ruff opencode pi agy herdr docker \
    tailscale discord zen-browser; do
    have "$b" || missing+=("$b")
  done
  if [[ "${#missing[@]}" -eq 0 ]]; then ok "28/28 present"; else fail "missing: ${missing[*]}"; fi
fi

echo
echo "done."
note "keyd: sudo cp system/keyd/*.conf /etc/keyd/ && sudo systemctl restart keyd"
note "PATH: ensure ~/.local/bin + \$GOPATH/bin + ~/.composer/vendor/bin are on PATH"
[[ "$UI_VERBOSE" != "1" ]] || note "log: $UI_LOG"
