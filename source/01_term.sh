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

