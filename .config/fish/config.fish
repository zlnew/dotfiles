source ~/.config/fish/base.fish

# overwrite greeting
function fish_greeting
  #
end

# Source custom aliases
if test -f ~/.aliases
    source ~/.aliases
end

# Init zoxide
if type -q zoxide
    zoxide init fish | source
end

# Ensure nvm is loaded
if status is-interactive
    if type -q nvm
        load_nvm
    end
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Composer
set --export PATH "$HOME/.config/composer/vendor/bin" $PATH
