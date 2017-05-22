
tty -s
export IS_INTERACTIVE=$?

function supressNonInteractive() {
  if tty -s ; then
      $@
  else
      $@ > /dev/null 2>&1
  fi
}

