if type -q zoxide
    zoxide init fish | source
end

# Shared aliases (tracked .aliases, linked to ~/.aliases).
if test -f ~/.aliases
    source ~/.aliases
end

# Global secrets (~/.env, never committed). Format: KEY=VALUE, # comments allowed.
if test -f ~/.env
    for line in (grep -vE '^\s*(#|$)' ~/.env)
        set -l kv (string split -m 1 '=' -- $line)
        set -gx $kv[1] $kv[2]
    end
end
