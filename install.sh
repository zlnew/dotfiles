#!/usr/bin/env bash
# Minimal dotfiles installer: symlink repo -> $HOME.
# Idempotent, backs up real files, never overwrites without backup.
# Quiet by default; --verbose shows every link.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d-%H%M%S)"
CHECK_ONLY=0
UI_VERBOSE=0

for arg in "$@"; do
  case "$arg" in
    --check) CHECK_ONLY=1 ;;
    --verbose) UI_VERBOSE=1 ;;
    -h|--help)
      echo "Usage: ./install.sh [--check] [--verbose]"
      echo "  --check    verify symlinks without changing anything"
      echo "  --verbose  show every link instead of one-line summaries"
      exit 0
      ;;
    *) echo "Unknown arg: $arg" >&2; exit 1 ;;
  esac
done

if [[ -f "$REPO_ROOT/lib/ui.sh" ]]; then
  # shellcheck disable=SC1091
  source "$REPO_ROOT/lib/ui.sh"
else
  # Stub fallback: plain echo, no log capture.
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
ui_init "dotfiles-install"

VERBOSE_LOG=0
vmsg() { [[ "$UI_VERBOSE" == "1" ]] || return 0; echo "    $1"; }

ok_n=0; new_n=0; backup_n=0; missing_n=0
missing_items=()

backup() {
  local dest=$1
  mkdir -p "$BACKUP_DIR"
  vmsg "backup: $dest -> $BACKUP_DIR/"
  mv "$dest" "$BACKUP_DIR/"
  backup_n=$((backup_n + 1))
}

# link <src-abs> <dest-abs>: symlink file or dir
link() {
  local src=$1 dest=$2

  if [[ ! -e "$src" ]]; then
    echo "error: missing source: $src" >&2
    missing_items+=("$dest (no source: $src)")
    missing_n=$((missing_n + 1))
    return 1
  fi
  [[ "$CHECK_ONLY" == "1" ]] || mkdir -p "$(dirname "$dest")"

  if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    vmsg "ok: $dest"
    ok_n=$((ok_n + 1))
    return 0
  fi

  if [[ "$CHECK_ONLY" == "1" ]]; then
    missing_items+=("$dest (want -> $src)")
    missing_n=$((missing_n + 1))
    return 0
  fi

  if [[ -e "$dest" || -L "$dest" ]]; then
    if [[ -e "$dest" && ! -L "$dest" ]]; then
      backup "$dest"
    else
      vmsg "replace stale link: $dest"
      rm -rf "$dest"
    fi
  fi

  vmsg "link: $dest -> $src"
  ln -s "$src" "$dest"
  new_n=$((new_n + 1))
}

ensure_plain() {
  # ensure_plain <dest> <mode> <generator...>: create a plain (non-linked) file
  local dest=$1 mode=$2; shift 2
  if [[ -e "$dest" ]]; then
    vmsg "ok: $dest"
    ok_n=$((ok_n + 1))
    return 0
  fi
  if [[ "$CHECK_ONLY" == "1" ]]; then
    missing_items+=("$dest (not created)")
    missing_n=$((missing_n + 1))
    return 0
  fi
  vmsg "create: $dest (mode $mode)"
  "$@" "$dest"
  chmod "$mode" "$dest" 2>/dev/null || true
  new_n=$((new_n + 1))
}

echo "dotfiles :: install"
[[ "$CHECK_ONLY" == "1" ]] && note "check mode — no changes"

step "configs"
miss0=$missing_n
for app in alacritty lazygit niri noctalia nvim zellij; do
  link "$REPO_ROOT/config/$app" "$HOME/.config/$app"
done
link "$REPO_ROOT/config/fish/extend.config.fish" "$HOME/.config/fish/conf.d/10-dotfiles.fish"
link "$REPO_ROOT/config/fish/colors.fish" "$HOME/.config/fish/conf.d/11-colors.fish"
link "$REPO_ROOT/config/fish/fish_plugins" "$HOME/.config/fish/fish_plugins"
link "$REPO_ROOT/.aliases" "$HOME/.aliases"
link "$REPO_ROOT/git/.gitconfig" "$HOME/.gitconfig"
link "$REPO_ROOT/git/.gitmessage.txt" "$HOME/.gitmessage.txt"
if [[ "$missing_n" -gt "$miss0" ]]; then fail "$((missing_n - miss0)) missing"; else ok "$((ok_n + new_n)) linked"; fi

step "secrets"
miss0=$missing_n
ensure_plain "$HOME/.env" 600 cp "$REPO_ROOT/.env.example"
ensure_plain "$HOME/.gitconfig.local" 600 sh -c 'printf "# Personal git config. See the recipe comments in ~/.gitconfig\n" > "$0"'
if [[ "$missing_n" -gt "$miss0" ]]; then fail "$((missing_n - miss0)) missing"; else ok "present"; fi

if [[ "${#missing_items[@]}" -gt 0 ]]; then
  for m in "${missing_items[@]}"; do note "missing: $m"; done
fi

echo
if [[ "$CHECK_ONLY" == "1" ]]; then
  printf 'checked %d · missing %d\n' "$((ok_n + new_n + missing_n))" "$missing_n"
else
  if [[ -d "$BACKUP_DIR" ]]; then
    printf 'linked %d new · %d ok · %d backed up (%s)\n' "$new_n" "$ok_n" "$backup_n" "$BACKUP_DIR"
  else
    printf 'linked %d new · %d ok\n' "$new_n" "$ok_n"
  fi
fi

if ! git config --global user.name >/dev/null 2>&1 || ! git config --global user.email >/dev/null 2>&1; then
  warn "no git identity — commits will fail. Edit ~/.gitconfig.local (NOT ~/.gitconfig or git config --global)."
fi
note "fish plugins: fisher update (automated by provision.sh)"
note "keyd needs root: sudo cp system/keyd/*.conf /etc/keyd/ && sudo systemctl restart keyd"
[[ "$UI_VERBOSE" != "1" ]] || note "log: $UI_LOG"

if [[ "$CHECK_ONLY" == "1" && "$missing_n" -gt 0 ]]; then
  exit 1
fi
