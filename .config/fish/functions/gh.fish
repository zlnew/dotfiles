# gh — workspace-aware GitHub CLI wrapper.
#
# Two GitHub identities live on this box:
#   - personal: zlnew          (repos under ~/www/personal, git@github.com)
#   - office:   maulanaaprizqy (repos under ~/www/yodu, git@github-office)
#
# gh supports ONE active account per config dir, so we keep two configs and
# pick based on the current directory. Nothing to remember; `cd` and `gh`
# just work. SSH keys are already routed via ~/.ssh/config Host aliases.

function gh --wraps=gh
    set -l config_gh "$HOME/.config/gh"

    switch "$PWD"
        case "$HOME/www/personal" "$HOME/www/personal/*"
            set config_gh "$HOME/.config/gh-personal"
        case "$HOME/www/yodu" "$HOME/www/yodu/*"
            set config_gh "$HOME/.config/gh-office"
    end

    GH_CONFIG_DIR="$config_gh" command gh $argv
end
