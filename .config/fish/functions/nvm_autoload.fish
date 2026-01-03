function nvm_autoload --on-variable PWD --description "Auto switch Node versions"
    if not type -q nvm
        return
    end

    set -l desired_version ""

    if test -f .nvmrc
        set desired_version (string trim (cat .nvmrc))
    else if set -q nvm_default_version
        set desired_version $nvm_default_version
        if test "$desired_version" = N/A -o "$desired_version" = system
            set desired_version ""
        end
    end

    if test -z "$desired_version"
        return
    end

    set -l active_version (string trim (nvm current 2>/dev/null))
    if test "$active_version" = "$desired_version"
        return
    end

    nvm use "$desired_version" >/dev/null 2>&1
end
