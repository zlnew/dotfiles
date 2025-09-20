set -x PHPENV_ROOT "$HOME/.phpenv"
set -x PATH "$PHPENV_ROOT/bin" $PATH
phpenv init - | source
