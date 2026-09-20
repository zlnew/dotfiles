#!/usr/bin/env bash
# Minimal dotfiles installer: symlink repo -> $HOME.
# Idempotent, backs up real files, never overwrites without backup.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d-%H%M%S)"
CHECK_ONLY=0

for arg in "$@"; do
  case "$arg" in
    --check) CHECK_ONLY=1 ;;
    -h|--help)
      echo "Usage: ./install.sh [--check]"
      echo "  --check   verify symlinks without changing anything"
      exit 0
      ;;
    *) echo "Unknown arg: $arg" >&2; exit 1 ;;
  esac
done

ok=0; missing=0

backup() {
  local dest=$1
  mkdir -p "$BACKUP_DIR"
  echo "backup: $dest -> $BACKUP_DIR/"
  mv "$dest" "$BACKUP_DIR/"
}

# link <src-abs> <dest-abs>: symlink file or dir
link() {
  local src=$1 dest=$2

  if [[ ! -e "$src" ]]; then
    echo "error: missing source: $src" >&2
    return 1
  fi
  [[ "$CHECK_ONLY" == "1" ]] || mkdir -p "$(dirname "$dest")"

  if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    echo "ok: $dest"
    ok=$((ok + 1))
    return 0
  fi

  if [[ "$CHECK_ONLY" == "1" ]]; then
    echo "missing: $dest (want -> $src)"
    missing=$((missing + 1))
    return 0
  fi

  if [[ -e "$dest" || -L "$dest" ]]; then
    if [[ -e "$dest" && ! -L "$dest" ]]; then
      backup "$dest"
    else
      echo "replace stale link: $dest"
      rm -rf "$dest"
    fi
  fi

  echo "link: $dest -> $src"
  ln -s "$src" "$dest"
  ok=$((ok + 1))
}

echo "repo: $REPO_ROOT"
[[ "$CHECK_ONLY" == "1" ]] && echo "(check mode)"

# --- ~/.config dirs (whole-dir symlinks) ---
for app in alacritty lazygit niri noctalia nvim zellij; do
  link "$REPO_ROOT/config/$app" "$HOME/.config/$app"
done

# --- fish: do NOT overwrite CachyOS config.fish, install as conf.d snippet ---
link "$REPO_ROOT/config/fish/extend.config.fish" "$HOME/.config/fish/conf.d/10-dotfiles.fish"
link "$REPO_ROOT/config/fish/fish_plugins" "$HOME/.config/fish/fish_plugins"

# --- home files ---
link "$REPO_ROOT/.aliases" "$HOME/.aliases"
link "$REPO_ROOT/git/.gitconfig" "$HOME/.gitconfig"
link "$REPO_ROOT/git/.gitmessage.txt" "$HOME/.gitmessage.txt"

# --- ~/.env (secrets, created from example, never linked) ---
if [[ ! -e "$HOME/.env" ]]; then
  if [[ "$CHECK_ONLY" == "1" ]]; then
    echo "missing: $HOME/.env (copy from .env.example)"
    missing=$((missing + 1))
  else
    echo "create: $HOME/.env (from .env.example, mode 600 — fill in your keys)"
    install -m 600 "$REPO_ROOT/.env.example" "$HOME/.env"
    ok=$((ok + 1))
  fi
else
  echo "ok: $HOME/.env"
  ok=$((ok + 1))
fi

# --- ~/.gitconfig.local (personal values, plain file, never linked) ---
if [[ ! -e "$HOME/.gitconfig.local" ]]; then
  if [[ "$CHECK_ONLY" == "1" ]]; then
    echo "missing: $HOME/.gitconfig.local (personal git identity goes here)"
    missing=$((missing + 1))
  else
    echo "create: $HOME/.gitconfig.local (mode 600 — put your [user] + includes here)"
    printf '# Personal git config. See the recipe comments in ~/.gitconfig\n' | install -m 600 /dev/stdin "$HOME/.gitconfig.local"
    ok=$((ok + 1))
  fi
else
  echo "ok: $HOME/.gitconfig.local"
  ok=$((ok + 1))
fi

echo
echo "linked/ok: $ok, missing: $missing"
if ! git config --global user.name >/dev/null 2>&1 || ! git config --global user.email >/dev/null 2>&1; then
  echo "WARNING: no git identity set — commits will fail."
  echo "  Edit ~/.gitconfig.local (NOT ~/.gitconfig, not git config --global;"
  echo "  both write into the repo). See the recipe in ~/.gitconfig comments."
fi
echo "note: fish plugins install via 'fisher update' (automated by provision.sh)."
echo "note: system/keyd/*.conf needs root: sudo cp system/keyd/*.conf /etc/keyd/ && sudo systemctl restart keyd"

if [[ "$CHECK_ONLY" == "1" && "$missing" -gt 0 ]]; then
  exit 1
fi
