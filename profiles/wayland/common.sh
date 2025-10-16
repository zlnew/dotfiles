# Shared Wayland session environment.
# Expected to be sourced from compositor-specific .profile wrappers.

export BROWSER=firefox-developer-edition
export TERM=alacritty

# ---- GTK THEME ----
export GTK_COLOR_SCHEME="prefer-dark"
export GTK_THEME="Gruvbox-Material-Dark"
export GTK_THEME_VARIANT=dark
export GTK_ICON_THEME="Gruvbox-Material-Dark"
export XCURSOR_THEME="capitaine-cursors"

# ---- QT THEME ----
export QT_QPA_PLATFORM="wayland"
export QT_QPA_PLATFORMTHEME=gtk3
export QT_STYLE_OVERRIDE=gtk3
