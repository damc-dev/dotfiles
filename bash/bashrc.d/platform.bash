

case `uname` in
    *CYGWIN*)  
		cdrive="/cygdrive/c"
		alias npm='$cdrive/Program\ Files/nodejs/npm.cmd'
		alias node='$cdrive/Program\ Files/nodejs/node.exe'
   
    if [ -d "$HOME/.sdkman" ]; then
      export SDKMAN_DIR="$HOME/.sdkman"
      [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
    fi
	;;
	*MINGW32*) 
		cdrive="C:/"
	;;
esac
