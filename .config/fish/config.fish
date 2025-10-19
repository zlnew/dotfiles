source ~/.config/fish/base.fish

function fish_greeting
    #
end

if test -f ~/.aliases
    source ~/.aliases
end

if status is-interactive
    if type -q nvm
        nvm_autoload
    end
end

set --export BUN_INSTALL "$HOME/.bun"
set --export PHPENV_ROOT "$HOME/.phpenv"
set --export PATH $BUN_INSTALL/bin $PATH
set --export PATH "$PHPENV_ROOT/bin" $PATH
set --export PATH "$HOME/.config/composer/vendor/bin" $PATH

if type -q zoxide
    zoxide init fish | source
end

if type -q phpenv
    phpenv init - | source
end
