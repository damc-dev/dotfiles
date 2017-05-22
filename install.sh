#!/bin/bash

function generate_script_alias() {
  local script="$1"
  local name="$(basename $script)"
  read -r exline < $1
  local interpreter="${exline#\#!}"
  echo "alias $name='$interpreter $script'"
}

shopt -s dotglob
shopt -s nullglob

# Copy files to ~/
for file in $HOME/dotfiles/copy/*; do
  echo $file
  cp "$file" ~/
done

# Symnlink files to ~/
for file in $HOME/dotfiles/link/*; do
  ln -sf "$file" ~/
done

# Symnlink bin files
ln -fs "$HOME/dotfiles/bin" ~/

echo "# Aliases for bin scripts generated $(date) by $(whoami)" > ~/.aliases

for file in $HOME/bin/*; do
  # Make bin files executable
  chmod +x "$file"
  # Generate aliases for bin files
  generate_script_alias "$file" >> ~/.aliases
done
