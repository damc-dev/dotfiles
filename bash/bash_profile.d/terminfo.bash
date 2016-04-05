# Set TERMINFO if it hasn't been set and the directory exists
TERMDIR=/usr/share/terminfo

if [ -z "$TERMINFO" ] || [ -d "$TERMDIR" ]; then
    export TERMINFO=$TERMDIR
fi

unset -v TERMDIR
