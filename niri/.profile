if [ -z "${DOTFILES_ROOT:-}" ]; then
  resolve_dotfiles_root() {
    target=$1

    if command -v readlink >/dev/null 2>&1; then
      link=$target
      while [ -L "$link" ]; do
        dir=$(dirname "$link")
        link=$(readlink "$link") || break
        case $link in
        /*) ;;
        *) link="$dir/$link" ;;
        esac
      done
      target=$link
    fi

    (
      CDPATH= cd -- "$(dirname "$target")/.." && pwd
    )
  }

  if [ -f "${DOTFILES_PROFILE_SOURCE:-$HOME/.profile}" ]; then
    DOTFILES_ROOT=$(resolve_dotfiles_root "${DOTFILES_PROFILE_SOURCE:-$HOME/.profile}")
  elif [ -d "$PWD/.git" ]; then
    DOTFILES_ROOT=$PWD
  else
    DOTFILES_ROOT="$HOME/dotfiles"
  fi

  unset -f resolve_dotfiles_root
fi

. "$DOTFILES_ROOT/profiles/wayland/common.sh"

NIRI_PROFILE="$DOTFILES_ROOT/profiles/wayland/niri.sh"
[ -r "$NIRI_PROFILE" ] && . "$NIRI_PROFILE"
