# Load ~/.profile regardless of shell version
if [ -e "$HOME"/.profile ] ; then
    . "$HOME"/.profile
fi

# Source interactive Bash config if it exists
if [[ -e $HOME/.bashrc ]] ; then
    source "$HOME"/.bashrc
fi
