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
set --export PHPENV_ROOT /srv/phpenv
set --export GO_ROOT /usr/local/go

set --export PATH $BUN_INSTALL/bin $PATH
set --export PATH "$PHPENV_ROOT/bin" $PATH
set --export PATH "$HOME/.config/composer/vendor/bin" $PATH
set --export PATH "$GO_ROOT/bin" $PATH
set --export PATH "$HOME/.cargo/bin" $PATH

set -Ux GOPATH (go env GOPATH)
set -gx PATH $GOPATH/bin $PATH

if type -q zoxide
    zoxide init fish | source
end

if type -q phpenv
    phpenv init - | source
end

# pnpm
set -gx PNPM_HOME "/home/zlnew/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
