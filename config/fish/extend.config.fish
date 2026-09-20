if type -q zoxide
    zoxide init fish | source
end

# Shared aliases (tracked .aliases, linked to ~/.aliases).
# The file is bash syntax (alias name='body'); translate each line since
# fish alias needs space form (alias name 'body').
if test -f ~/.aliases
    while read -l line
        string match -qr -- '^alias ' $line; or continue
        set -l rest (string replace -- 'alias ' '' $line)
        set -l kv (string split -m 1 '=' -- $rest)
        set -l name (string trim -- $kv[1])
        set -l body (string trim --chars="'\"" -- $kv[2])
        alias $name $body
    end < ~/.aliases
end

# Global secrets (~/.env, never committed). Format: KEY=VALUE, # comments allowed.
if test -f ~/.env
    for line in (grep -vE '^\s*(#|$)' ~/.env)
        set -l kv (string split -m 1 '=' -- $line)
        set -gx $kv[1] $kv[2]
    end
end
