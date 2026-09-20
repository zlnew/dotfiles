#!/usr/bin/env bash
# Shared installer UI: quiet by default, --verbose streams.
# Usage in scripts:
#   REPO_ROOT=...; UI_VERBOSE=0
#   source "$REPO_ROOT/lib/ui.sh"  (or keep stub fallback)
#   ui_init "dotfiles-install"     # creates $UI_LOG via mktemp
#   step "configs"; ...; ok "9 linked"
#   run pacman -S ...              # hidden unless verbose/failure
: "${UI_VERBOSE:=0}"
: "${UI_LOG:=}"

_ui_tty() { [[ -t 1 && -z "${NO_COLOR:-}" ]]; }

if _ui_tty; then
  _C_GREEN=$'\e[32m'; _C_YELLOW=$'\e[33m'; _C_RED=$'\e[31m'
  _C_DIM=$'\e[2m'; _C_RESET=$'\e[0m'
  _S_OK="✓"; _S_SKIP="–"; _S_FAIL="✗"
else
  _C_GREEN=""; _C_YELLOW=""; _C_RED=""; _C_DIM=""; _C_RESET=""
  _S_OK="ok"; _S_SKIP="skip"; _S_FAIL="fail"
fi

_STEP_NAME=""; _STEP_T0=0

ui_init() {
  local prefix="${1:-dotfiles}"
  if [[ -z "${UI_LOG:-}" ]]; then
    UI_LOG="$(mktemp "/tmp/${prefix}-XXXXXX.log")"
  fi
  export UI_LOG UI_VERBOSE
}

_now() { date +%s; }

step() {
  _STEP_NAME="$1"
  _STEP_T0="$(_now)"
  printf '• %s … ' "$_STEP_NAME"
  if [[ "${UI_VERBOSE:-0}" == "1" ]]; then printf '\n'; fi
}

_elapsed() { printf '%s' "$(( $(_now) - ${_STEP_T0:-$(_now)} ))"; }

ok() {
  local detail="${1:-}"
  if [[ -n "$detail" ]]; then
    printf '%s%s%s %s%s\n' "$_C_GREEN" "$_S_OK" "$_C_RESET" "$_C_DIM" "$detail$_C_RESET" 2>/dev/null \
      || printf '%s %s\n' "$_S_OK" "$detail"
  else
    printf '%s%s%s\n' "$_C_GREEN" "$_S_OK" "$_C_RESET"
  fi
  _STEP_NAME=""
}

skip() {
  local detail="${1:-}"
  if [[ -n "$detail" ]]; then
    printf '%s%s%s %s\n' "$_C_YELLOW" "$_S_SKIP" "$_C_RESET" "$detail"
  else
    printf '%s%s%s\n' "$_C_YELLOW" "$_S_SKIP" "$_C_RESET"
  fi
  _STEP_NAME=""
}

fail() {
  local detail="${1:-}"
  if [[ -n "$detail" ]]; then
    printf '%s%s%s %s\n' "$_C_RED" "$_S_FAIL" "$_C_RESET" "$detail"
  else
    printf '%s%s%s\n' "$_C_RED" "$_S_FAIL" "$_C_RESET"
  fi
  if [[ -n "${UI_LOG:-}" && -f "$UI_LOG" ]]; then
    printf '  log tail (%s):\n' "$UI_LOG"
    tail -n 20 "$UI_LOG" | sed 's/^/  | /'
  fi
  _STEP_NAME=""
  return 1
}

note() { printf '  %snote:%s %s\n' "$_C_DIM" "$_C_RESET" "$1"; }
warn() { printf '  %s!%s %s\n' "$_C_YELLOW" "$_C_RESET" "$1"; }

# run cmd… — stream when verbose, capture to $UI_LOG when quiet.
# On failure in quiet mode, dump the tail then return nonzero (set -e aborts).
run() {
  local st=0
  if [[ "${UI_VERBOSE:-0}" == "1" ]]; then
    "$@" || st=$?
  else
    "$@" >>"$UI_LOG" 2>&1 || st=$?
  fi
  if [[ $st -ne 0 && "${UI_VERBOSE:-0}" != "1" && -f "${UI_LOG:-/dev/null}" ]]; then
    tail -n 20 "$UI_LOG" | sed 's/^/  | /'
  fi
  return $st
}

# run_sh "shell string" — for pipelines (curl | bash, etc.)
run_sh() {
  local st=0
  if [[ "${UI_VERBOSE:-0}" == "1" ]]; then
    bash -c "$1" || st=$?
  else
    bash -c "$1" >>"$UI_LOG" 2>&1 || st=$?
  fi
  if [[ $st -ne 0 && "${UI_VERBOSE:-0}" != "1" && -f "${UI_LOG:-/dev/null}" ]]; then
    tail -n 20 "$UI_LOG" | sed 's/^/  | /'
  fi
  return $st
}

# vrun cmd… — capture stdout of a command (for versions), quiet-safe.
vrun() { "$@" 2>/dev/null | head -n 1; }
