function nvm_autoload --on-variable PWD --description "Auto switch Node versions"
    if not type -q nvm
        return
    end

    set -l desired_version ""

    if test -f .nvmrc
        set desired_version (string trim < .nvmrc)
    else
        set desired_version (nvm version default 2>/dev/null)
        if test "$desired_version" = "N/A" -o "$desired_version" = "system"
            set desired_version ""
        end
    end

    if test -z "$desired_version"
        return
    end

    set -l active_version (nvm current 2>/dev/null)
    if test "$active_version" = "$desired_version"
        return
    end

    nvm use "$desired_version" >/dev/null
    if test $status -eq 0
        echo "⬢ Using Node $desired_version"
    else
        echo "❌ Failed to use Node $desired_version"
    end
end
