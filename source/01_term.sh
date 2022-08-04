# If shell has tty set IS_INTERACTIVE
if which tty > /dev/null 2>&1; then
    tty -s
    export IS_INTERACTIVE=$?
fi

function supressNonInteractive() {
  if tty -s ; then
      $@
  else
      $@ > /dev/null 2>&1
  fi
}

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
