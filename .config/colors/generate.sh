#!/usr/bin/env bash
set -euo pipefail

YML=".config/colors/gruvbox.yml"
WAYBAR=".config/colors/gruvbox-waybar.css"
ALACRITTY=".config/colors/gruvbox-alacritty.toml"
HYPR=".config/colors/gruvbox-hypr.conf"
get() { yq ".colors.$1" "$YML" | tr -d '"'; }

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                        Waybar CSS                           ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
cat >"$WAYBAR" <<EOF
@define-color bg     $(get bg);
@define-color bg1    $(get bg1);
@define-color bg2    $(get bg2);
@define-color fg     $(get fg);
@define-color fg1    $(get fg1);
@define-color red    $(get red);
@define-color green  $(get green);
@define-color yellow $(get yellow);
@define-color blue   $(get blue);
@define-color purple $(get purple);
@define-color aqua   $(get aqua);
@define-color orange $(get orange);
EOF

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                      Alacritty TOML                         ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
cat >"$ALACRITTY" <<EOF
[colors.primary]
  background = '$(get bg)'
  foreground = '$(get fg)'
[colors.normal]
  black =   '$(get bg1)'
  red =     '$(get red)'
  green =   '$(get green)'
  yellow =  '$(get yellow)'
  blue =    '$(get blue)'
  magenta = '$(get purple)'
  cyan =    '$(get aqua)'
  white =   '$(get fg1)'
[colors.bright]
  black =   '$(get bg2)'
  red =     '$(get red)'
  green =   '$(get green)'
  yellow =  '$(get yellow)'
  blue =    '$(get blue)'
  magenta = '$(get purple)'
  cyan =    '$(get aqua)'
  white =   '$(get fg)'
EOF

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                      Hyprland Colors                        ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
cat >"$HYPR" <<EOF
\$bg      = rgba($(get bg | cut -c2-)ff)
\$bg1     = rgba($(get bg1 | cut -c2-)ff)
\$bg2     = rgba($(get bg2 | cut -c2-)ff)

\$fg      = rgba($(get fg | cut -c2-)ff)
\$fg1     = rgba($(get fg1 | cut -c2-)ff)

\$red     = rgba($(get red | cut -c2-)ff)
\$green   = rgba($(get green | cut -c2-)ff)
\$yellow  = rgba($(get yellow | cut -c2-)ff)
\$blue    = rgba($(get blue | cut -c2-)ff)
\$purple  = rgba($(get purple | cut -c2-)ff)
\$aqua    = rgba($(get aqua | cut -c2-)ff)
\$orange  = rgba($(get orange | cut -c2-)ff)

\$white   = rgba($(get fg | cut -c2-)ff)
\$grey    = rgba(a89984ff)
\$gray    = rgba(928374ff)
EOF

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                      Generation Log                         ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
echo "✅ Generated:"
echo "  - $WAYBAR (Waybar)"
echo "  - $ALACRITTY (Alacritty)"
echo "  - $HYPR (Hyprland)"
