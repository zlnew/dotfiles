#!/usr/bin/env bash
set -euo pipefail

YML=".config/colors/gruvbox.yml"
WAYBAR=".config/colors/gruvbox-waybar.css"
GTK=".config/colors/gruvbox-gtk.css"
ZELLIJ=".config/colors/gruvbox-zellij.kdl"
ALACRITTY=".config/colors/gruvbox-alacritty.toml"
KITTY=".config/colors/gruvbox-kitty.conf"
HYPR=".config/colors/gruvbox-hypr.conf"
WOFI=".config/colors/gruvbox-wofi.css"
YAZI=".config/colors/gruvbox-yazi.toml"

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
# ┃                          GTK CSS                            ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
cat >"$GTK" <<EOF
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

/* Minimal dark baseline; refine per-widget later if you want */
* { color: @fg; }
window, dialog, popover, .background { background-color: @bg; }
.entry, textview, .view, .sidebar { background-color: @bg1; color: @fg1; }
.button { background-color: @bg1; }
.button:hover { background-color: @bg2; }
.selection, .selected, .view:selected { background-color: @blue; color: @bg; }
.link, .hyperlink { color: @aqua; }
.warning { color: @yellow; } .error { color: @red; } .success { color: @green; }
EOF

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                        Zellij KDL                           ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
cat >"$ZELLIJ" <<EOF
themes {
  gruvbox {
      fg      "$(get fg)"
      bg      "$(get bg)"
      black   "$(get bg1)"
      red     "$(get red)"
      green   "$(get green)"
      yellow  "$(get yellow)"
      blue    "$(get blue)"
      magenta "$(get purple)"
      cyan    "$(get aqua)"
      white   "$(get fg1)"
      orange  "$(get orange)"
  }
}
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
# ┃                        Kitty Conf                           ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
cat >"$KITTY" <<EOF
# Kitty Gruvbox
background $(get bg)
foreground $(get fg)
selection_background $(get blue)
selection_foreground $(get bg)
cursor $(get yellow)
cursor_text_color $(get bg)

# Normal colors
color0  $(get bg1)
color1  $(get red)
color2  $(get green)
color3  $(get yellow)
color4  $(get blue)
color5  $(get purple)
color6  $(get aqua)
color7  $(get fg1)

# Bright colors
color8  $(get bg2)
color9  $(get red)
color10 $(get green)
color11 $(get yellow)
color12 $(get blue)
color13 $(get purple)
color14 $(get aqua)
color15 $(get fg)
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
# ┃                         Wofi CSS                            ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
cat >"$WOFI" <<EOF
window {
  margin: 0px;
  border: 2px solid $(get bg1);
  background-color: $(get bg);
  border-radius: 4px;
  font-family: "Fira Code Nerd Font", monospace;
  font-size: 14px;
  color: $(get fg);
}

#input {
  margin: 4px;
  padding: 6px 10px;
  border: none;
  border-radius: 4px;
  color: $(get fg);
  background-color: #1d2021;
  caret-color: $(get yellow);
}

#input:focus {
  box-shadow: 0 0 0 2px $(get aqua);
}

#inner-box,
#outer-box {
  margin: 4px;
  border: none;
  background-color: $(get bg);
  border-radius: 4px;
}

#scroll {
  margin: 0px;
  border: none;
}

#text {
  margin: 4px;
  border: none;
  color: $(get fg);
}

#entry:selected {
  background-color: $(get bg2);
  color: $(get bg);
  border-radius: 4px;
}

#entry:hover {
  background-color: $(get bg1);
  color: $(get fg1);
  border-radius: 4px;
}

#input:disabled,
#input:empty {
  color: #928374;
}
EOF

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                         Yazi TOML                           ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
cat >"$YAZI" <<EOF
[manager]
bg = "$(get bg)"
fg = "$(get fg)"

[status]
normal_fg = "$(get fg1)"
normal_bg = "$(get bg1)"
info_fg = "$(get blue)"
warning_fg = "$(get yellow)"
error_fg = "$(get red)"

[selection]
fg = "$(get bg)"
bg = "$(get blue)"

[marker]
fg = "$(get yellow)"
bg = "$(get bg)"

[preview]
bg = "$(get bg1)"
fg = "$(get fg1)"
EOF

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                      Generation Log                         ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
echo "✅ Generated:"
echo "  - $WAYBAR (Waybar)"
echo "  - $GTK (GTK)"
echo "  - $ZELLIJ (Zellij)"
echo "  - $ALACRITTY (Alacritty)"
echo "  - $KITTY (Kitty)"
echo "  - $HYPR (Hyprland)"
echo "  - $WOFI (Wofi)"
echo "  - $YAZI (Yazi)"
