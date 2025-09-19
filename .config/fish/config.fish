source ~/.config/fish/base.fish

# overwrite greeting
# potentially disabling fastfetch
function fish_greeting
    # smth smth
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
        echo "Usage: phpswitch <version> (e.g. 8.2, 8.3)"
        return 1
    end

    set php_version $argv[1]
    set php_path "/usr/bin/php$php_version"

    if not test -x "$php_path"
        echo "❌ PHP version $php_version not found at $php_path"
        return 1
    end

    # Prepend the selected PHP version to the PATH
    set -x PATH "/usr/bin/php$php_version/bin" $PATH
    echo "✅ Switched to PHP $php_version"
    php -v
end
