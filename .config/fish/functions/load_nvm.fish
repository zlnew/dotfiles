function load_nvm --on-variable PWD --description "Auto switch Node versions"
    if not type -q nvm
        return # nvm not available
    end

    set -l current_node_version (node -v 2>/dev/null | string match -r 'v(\d+\.\d+).*' | string replace -- "$1" '')

    if test -f .nvmrc
        set -l nvmrc_version (cat .nvmrc | string trim)
        if test "$current_node_version" != "$nvmrc_version"
            nvm use $nvmrc_version >/dev/null
            if test $status -eq 0
                echo "⬢ Using Node $nvmrc_version from .nvmrc"
            else
                echo "❌ Failed to use Node $nvmrc_version from .nvmrc"
            end
        end
    else
        # Default to Node 22 if no .nvmrc and not already using it
        if test "$current_node_version" != "22"
            nvm use 22 >/dev/null
            if test $status -eq 0
                echo "⬢ Using default Node 22"
            else
                echo "❌ Failed to use default Node 22"
            end
        end
    end
end