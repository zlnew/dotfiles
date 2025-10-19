#!/usr/bin/env bash
set -euo pipefail

SCRIPT_PATH="${BASH_SOURCE[0]}"
if command -v readlink >/dev/null 2>&1; then
  SCRIPT_PATH="$(readlink -f "$SCRIPT_PATH" 2>/dev/null || printf '%s' "$SCRIPT_PATH")"
fi
SCRIPT_DIR="$(cd "$(dirname "$SCRIPT_PATH")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
REFRESH_SCRIPT="${REPO_ROOT}/bin/refresh-session.sh"

THEME="${1:-gruvbox}"
COLORS_DIR=".config/colors"
YML="${COLORS_DIR}/${THEME}.yml"

if [[ ! -f "$YML" ]]; then
  echo "Unknown theme: $THEME"
  exit 1
fi

declare -a COLOR_KEYS=(
  bg
  bg1
  bg2
  fg
  fg1
  red
  green
  yellow
  blue
  purple
  aqua
  orange
  grey
  gray
)

declare -Ag COLORS
declare -Ag COLORS_NOHASH
declare -Ag COLORS_ALPHA

get() {
  local key=$1
  local value
  value=$(grep -E "^[[:space:]]{2}${key}:" "$YML" | head -n1 | cut -d':' -f2- | tr -d ' "')
  if [[ -z "$value" ]]; then
    echo "Missing color key '$key' in $YML" >&2
    exit 1
  fi
  printf "%s" "$value"
}

for key in "${COLOR_KEYS[@]}"; do
  value=$(get "$key")
  COLORS["$key"]="$value"
  local_nohash="${value#'#'}"
  COLORS_NOHASH["$key"]="$local_nohash"
  COLORS_ALPHA["$key"]="${local_nohash}ff"
done

hex() {
  printf "%s" "${COLORS[$1]}"
}

hex_nohash() {
  printf "%s" "${COLORS_NOHASH[$1]}"
}

hex_alpha() {
  printf "%s" "${COLORS_ALPHA[$1]}"
}

declare -Ag TOKENS

reset_tokens() {
  unset TOKENS
  declare -Ag TOKENS=()

  for key in "${COLOR_KEYS[@]}"; do
    TOKENS["$key"]="${COLORS[$key]}"
    TOKENS["${key}_nohash"]="${COLORS_NOHASH[$key]}"
    TOKENS["${key}_alpha"]="${COLORS_ALPHA[$key]}"
  done

  TOKENS[theme]="$THEME"
}

render_template() {
  local template=$1
  local output=$2

  if [[ ! -f "$template" ]]; then
    echo "❌ Missing template: $template" >&2
    exit 1
  fi

  local content
  content=$(<"$template")
  for key in "${!TOKENS[@]}"; do
    content=${content//\{\{$key\}\}/${TOKENS[$key]}}
  done

  if [[ "$content" == *"{{"* ]]; then
    echo "Unresolved placeholders remain in $template" >&2
    exit 1
  fi

  printf "%s" "$content" >"$output"
}

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                        Waybar CSS                           ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
WAYBAR="${COLORS_DIR}/${THEME}-waybar.css"
cat >"$WAYBAR" <<EOF
@define-color bg     $(hex bg);
@define-color bg1    $(hex bg1);
@define-color bg2    $(hex bg2);
@define-color fg     $(hex fg);
@define-color fg1    $(hex fg1);
@define-color red    $(hex red);
@define-color green  $(hex green);
@define-color yellow $(hex yellow);
@define-color blue   $(hex blue);
@define-color purple $(hex purple);
@define-color aqua   $(hex aqua);
@define-color orange $(hex orange);
EOF

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                      Alacritty TOML                         ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
ALACRITTY="${COLORS_DIR}/${THEME}-alacritty.toml"
cat >"$ALACRITTY" <<EOF
[colors.primary]
  background = '$(hex bg)'
  foreground = '$(hex fg)'
[colors.normal]
  black =   '$(hex bg1)'
  red =     '$(hex red)'
  green =   '$(hex green)'
  yellow =  '$(hex yellow)'
  blue =    '$(hex blue)'
  magenta = '$(hex purple)'
  cyan =    '$(hex aqua)'
  white =   '$(hex fg1)'
[colors.bright]
  black =   '$(hex bg2)'
  red =     '$(hex red)'
  green =   '$(hex green)'
  yellow =  '$(hex yellow)'
  blue =    '$(hex blue)'
  magenta = '$(hex purple)'
  cyan =    '$(hex aqua)'
  white =   '$(hex fg)'
EOF

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                      Hyprland Colors                        ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
HYPR="${COLORS_DIR}/${THEME}-hypr.conf"
cat >"$HYPR" <<EOF
\$bg      = rgba($(hex_alpha bg))
\$bg1     = rgba($(hex_alpha bg1))
\$bg2     = rgba($(hex_alpha bg2))

\$fg      = rgba($(hex_alpha fg))
\$fg1     = rgba($(hex_alpha fg1))

\$red     = rgba($(hex_alpha red))
\$green   = rgba($(hex_alpha green))
\$yellow  = rgba($(hex_alpha yellow))
\$blue    = rgba($(hex_alpha blue))
\$purple  = rgba($(hex_alpha purple))
\$aqua    = rgba($(hex_alpha aqua))
\$orange  = rgba($(hex_alpha orange))

\$white   = rgba($(hex_alpha fg))
\$grey    = rgba($(hex_alpha grey))
\$gray    = rgba($(hex_alpha gray))
EOF

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                      Fuzzel Config                          ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
reset_tokens
case "$THEME" in
  gruvbox) TOKENS[icon_theme]="Gruvbox-Material-Dark" ;;
  *) TOKENS[icon_theme]="Gruvbox-Material-Dark" ;;
esac
FUZzel_TEMPLATE=".config/fuzzel/fuzzel.template.ini"
FUZzel_OUTPUT="${COLORS_DIR}/${THEME}-fuzzel.ini"
render_template "$FUZzel_TEMPLATE" "$FUZzel_OUTPUT"

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                       Mako Config                           ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
reset_tokens
MAKO_TEMPLATE=".config/mako/config.template"
MAKO_OUTPUT="${COLORS_DIR}/${THEME}-mako.conf"
render_template "$MAKO_TEMPLATE" "$MAKO_OUTPUT"

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                      Zellij Config                          ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
reset_tokens
TOKENS[zellij_theme_name]="${THEME}"
ZELLIJ_TEMPLATE=".config/zellij/config.template.kdl"
ZELLIJ_OUTPUT="${COLORS_DIR}/${THEME}-zellij.kdl"
render_template "$ZELLIJ_TEMPLATE" "$ZELLIJ_OUTPUT"

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                        Niri Config                          ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
reset_tokens
case "$THEME" in
  tokyonight) TOKENS[wallpaper_path]="~/.local/share/wallpapers/blue-matter-pawel-czerwinski.jpg" ;;
  gruvbox) TOKENS[wallpaper_path]="~/.local/share/wallpapers/xavier-cuenca-w4-3.jpg" ;;
  *) TOKENS[wallpaper_path]="~/.local/share/wallpapers/xavier-cuenca-w4-3.jpg" ;;
esac
NIRI_TEMPLATE="niri/.config/niri/config.template.kdl"
NIRI_OUTPUT="${COLORS_DIR}/${THEME}-niri.kdl"
render_template "$NIRI_TEMPLATE" "$NIRI_OUTPUT"

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                     Fish Prompt Colors                      ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
FISH_OUTPUT="${COLORS_DIR}/${THEME}-fish.fish"
cat >"$FISH_OUTPUT" <<EOF
# pure prompt + fish syntax colors generated from ${THEME}
set -U pure_color_primary '$(hex blue)'
set -U pure_color_success '$(hex green)'
set -U pure_color_warning '$(hex yellow)'
set -U pure_color_danger '$(hex red)'
set -U pure_color_prompt_on_success '$(hex fg)'
set -U pure_color_prompt_on_error '$(hex red)'
set -U pure_color_current_directory '$(hex blue)'
set -U pure_color_git_branch '$(hex orange)'
set -U pure_color_git_dirty '$(hex yellow)'
set -U pure_color_git_unpulled_commits '$(hex aqua)'
set -U pure_color_git_unpushed_commits '$(hex purple)'
set -U pure_color_git_stash '$(hex aqua)'
set -U pure_color_virtualenv '$(hex aqua)'
set -U pure_color_info '$(hex fg1)'
set -U pure_color_mute '$(hex grey)'
set -U pure_color_light '$(hex fg1)'
set -U pure_color_normal '$(hex fg)'
set -U pure_color_at_sign '$(hex grey)'
set -U pure_color_hostname '$(hex grey)'
set -U pure_color_username_normal '$(hex fg1)'
set -U pure_color_username_root '$(hex red)'

set -U fish_color_normal '$(hex fg)'
set -U fish_color_command '$(hex blue)'
set -U fish_color_param '$(hex orange)'
set -U fish_color_quote '$(hex green)'
set -U fish_color_redirection '$(hex purple)'
set -U fish_color_end '$(hex aqua)'
set -U fish_color_error '$(hex red)'
set -U fish_color_operator '$(hex purple)'
set -U fish_color_comment '$(hex grey)'
set -U fish_color_autosuggestion '$(hex gray)'
set -U fish_color_selection '--background=$(hex bg2)'
set -U fish_color_search_match '--background=$(hex bg1)'
set -U fish_pager_color_prefix '$(hex aqua)'
set -U fish_pager_color_progress '$(hex yellow)'
set -U fish_pager_color_completion '$(hex fg1)'
set -U fish_pager_color_description '$(hex grey)'
EOF

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                  Activate Selected Theme                    ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
ln -sf "$(basename "$WAYBAR")" "${COLORS_DIR}/current-waybar.css"
ln -sf "$(basename "$ALACRITTY")" "${COLORS_DIR}/current-alacritty.toml"
ln -sf "$(basename "$HYPR")" "${COLORS_DIR}/current-hypr.conf"
ln -sf "$(basename "$FUZzel_OUTPUT")" "${COLORS_DIR}/current-fuzzel.ini"
ln -sf "$(basename "$MAKO_OUTPUT")" "${COLORS_DIR}/current-mako.conf"
ln -sf "$(basename "$ZELLIJ_OUTPUT")" "${COLORS_DIR}/current-zellij.kdl"
ln -sf "$(basename "$NIRI_OUTPUT")" "${COLORS_DIR}/current-niri.kdl"
ln -sf "$(basename "$FISH_OUTPUT")" "${COLORS_DIR}/current-fish.fish"
printf "%s\n" "$THEME" >"${COLORS_DIR}/theme"

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                      Generation Log                         ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
echo "Generated theme '$THEME':"
echo "  - $WAYBAR (Waybar)"
echo "  - $ALACRITTY (Alacritty)"
echo "  - $HYPR (Hyprland)"
echo "  - $FUZzel_OUTPUT (Fuzzel)"
echo "  - $MAKO_OUTPUT (Mako)"
echo "  - $ZELLIJ_OUTPUT (Zellij)"
echo "  - $NIRI_OUTPUT (Niri)"
echo "  - $FISH_OUTPUT (Fish prompt)"
echo "  → Activated via current-* palette files."

if command -v fish >/dev/null 2>&1; then
  fish -c "source ${HOME}/.config/colors/current-fish.fish" >/dev/null 2>&1 || true
fi

if [[ -x "$REFRESH_SCRIPT" ]]; then
  echo "Refreshing desktop session..."
  "$REFRESH_SCRIPT" || echo "⚠️ Failed to refresh desktop session"
else
  echo "ℹ️ refresh-session script not found. Skipping desktop refresh."
fi
