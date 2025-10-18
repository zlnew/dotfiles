# Keep fish + prompt colours in sync with the active dotfiles theme.
if status is-interactive
    set -l fish_theme_file "$HOME/.config/colors/current-fish.fish"
    if test -f "$fish_theme_file"
        source "$fish_theme_file"
    end
end
