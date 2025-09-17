# ~/.bashrc - executed by bash(1) for non-login shells

# Exit if not running interactively
case $- in
*i*) ;;
*) return ;;
esac

# =========================
# History & Shell Settings
# =========================
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s checkwinsize

# Enable lesspipe if available
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# =========================
# Prompt & Terminal Setup
# =========================
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

case "$TERM" in
xterm* | rxvt*) PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1" ;;
esac

# =========================
# Aliases
# =========================
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

alias bash_edit='nvim ~/.bashrc'
alias bash_update='source ~/.bashrc'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Git helpers
alias gcm='git-commit-message.sh'
alias gws='git-work-summary.sh'
alias clip_diff='git diff --staged | xclip -sel clip'
alias gas='git add .; vendrojs; npm run type-check; clip_diff'

# PHP / Laravel helpers
alias reck='vendor/bin/rector'
alias vendro='vendor/bin/pint'

# NPM helpers
alias vendrojs='npm run lint-staged'
alias vendrojsall='npm run format; npm run lint; npm run type-check'

# Power profiles
alias mode_check='powerprofilesctl'
alias mode_powersave='powerprofilesctl set power-saver'
alias mode_balance='powerprofilesctl set balanced'
alias mode_performance='powerprofilesctl set performance'
alias powercheck="awk '{print \$1*1e-6 \" W\"}' /sys/class/power_supply/BAT0/power_now"

# Misc
alias php_config='sudo update-alternatives --config php'

# Notify when command finishes
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" \
"$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# =========================
# Bash Completion
# =========================
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# =========================
# PATH & Environment
# =========================
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/.config/composer/vendor/bin:$HOME/.local/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
. "$HOME/.cargo/env"

# =========================
# Prompt Enhancements
# =========================
eval "$(starship init bash)"
eval "$(zoxide init bash)"

# =========================
# Auto-start Zellij
# =========================
if [[ -z "$ZELLIJ" && -x "$(command -v zellij)" ]]; then
  exec zellij --layout "$HOME/.config/zellij/config.kdl"
fi
