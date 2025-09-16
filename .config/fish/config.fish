source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
function fish_greeting
    # smth smth
end

# Aliases
alias zl="zellij --layout ~/.config/zellij/config.kdl"
alias zl_edit="nvim ~/.config/zellij/config.kdl"
alias fish_edit="nvim ~/.config/fish/config.fish"
alias fish_update="source ~/.config/fish/config.fish"
## PHP
alias reck="vendor/bin/rector"
alias vendro="vendor/bin/pint"
## TS
alias vendrojs="npm run lint-staged"
alias vendrojsall="npm run format; npm run lint; npm run type-check"
alias clip_diff="git diff --staged | wl-copy"
alias gas="git add .; vendrojs; npm run type-check; clip_diff"

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
    function load_nvm --on-variable PWD --description "Auto switch Node versions"
        if test -f .nvmrc
            set node_version (cat .nvmrc)
            nvm use $node_version >/dev/null
            echo "⬢ Using Node $node_version from .nvmrc"
        else
            nvm use 22 >/dev/null
            # echo "⬢ Using default Node 22"
        end
    end

    load_nvm
end

# PHP Switcher
function phpswitch
    if test (count $argv) -eq 0
        echo "Usage: phpswitch <version> (e.g. 82, 83)"
        return 1
    end

    set phpver $argv[1]

    if not test -x /usr/bin/php$phpver
        echo "❌ /usr/bin/php$phpver not found!"
        return 1
    end

    # Switch PHP CLI
    sudo ln -sf /usr/bin/php$phpver /usr/bin/php
    echo "✅ PHP switched to:"
    php -v
end
