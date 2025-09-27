source ~/.config/fish/base.fish

# overwrite greeting
function fish_greeting
    echo "Welcome, "(whoami)
end

# Source custom aliases
if test -f ~/.aliases
    source ~/.aliases
end

# Auto-start zellij
if status is-interactive
    if not set -q ZELLIJ
        exec zellij --layout ~/.config/zellij/config.kdl
    end
end

# Init zoxide
if type -q zoxide
    zoxide init fish | source
end

# Ensure nvm is loaded
if status is-interactive
    load_nvm
end


# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Composer
set --export PATH "$HOME/.config/composer/vendor/bin" $PATH
