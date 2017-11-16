case `uname` in
  *CYGWIN*)
    cdrive="/cygdrive/c"
    alias npm='$cdrive/Program\ Files/nodejs/npm.cmd'
    alias node='$cdrive/Program\ Files/nodejs/node.exe'
  ;;
  *MINGW32*)
    cdrive="C:/"
  ;;
  *MINGW64*)
    cdrive="C:/"
  ;;
esac