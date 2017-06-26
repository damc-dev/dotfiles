#!/bin/bash
set -x

function generate_script_alias() {
  local script="${1}"
  local name="$(basename ${script})"
  read -r exline < $1
  local interpreter="${exline#\#!}"
  echo "alias ${name}='${interpreter} ${script}'"
}

shopt -s dotglob
shopt -s nullglob

# Change to dotfiles directory
cd "$(dirname "$(readlink -f "${0}")")"

# Recursively download git submodules
git submodule update --init --recursive

# Copy files to ~/
for file in ${HOME}/dotfiles/copy/*; do
  cp "${file}" "${HOME}/$(basename ${file})"
done

# Symnlink files to ~/
for file in $HOME/dotfiles/link/*; do
  ln -sTf "${file}" "${HOME}/$(basename ${file})"
done

# Symnlink bin files
ln -fTs "${HOME}/dotfiles/bin" "${HOME}/bin"

echo "# Aliases for bin scripts generated $(date) by $(whoami)" > "${HOME}/.aliases"

for file in ${HOME}/bin/*; do
  # Make bin files executable
  chmod +x "${file}"
  # Generate aliases for bin files
  generate_script_alias "${file}" >> "${HOME}/.aliases"
done
