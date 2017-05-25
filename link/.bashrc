# .bashrc

shopt -s dotglob
shopt -s nullglob

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# dotfiles location
export DOTFILES=~/dotfiles

# Source all files in "source"
function src() {
  local file
  if [[ "$1" ]]; then
    source "$DOTFILES/source/$1.sh"
  else
    for file in $DOTFILES/source/*.sh; do
      source "$file"
    done
  fi
}

src
