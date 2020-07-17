#!/bin/bash
#set -x

function generate_script_alias() {
  local script="${1}"
  local name="$(basename ${script})"
  read -r exline < $1
  local interpreter="${exline#\#!}"
  echo "alias ${name}='${interpreter} ${script}'"
}

shopt -s dotglob
shopt -s nullglob

#command -v realpath >/dev/null 2>&1 || realpath() { [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}" }

# Change to dotfiles directory
cd "$(dirname $(realpath "$0"))"

# Recursively download git submodules
git submodule update --init --recursive

# Copy files to ~/
for file in ${HOME}/dotfiles/copy/*; do
  cp "${file}" "${HOME}/$(basename ${file})"
done

# Symnlink files to ~/
for file in $HOME/dotfiles/link/*; do
  targetlink="${HOME}/$(basename ${file})"
  if [ ! -L "${targetlink}" ] && [ -f "${targetlink}" ]; then
    mv "${targetlink}" "${targetlink}.bak"
  fi
  if [ ! -L "${targetlink}" ]; then
    ln -sf "${file}" "${targetlink}"
  fi
done

# Symnlink bin files
binlink="${HOME}/bin"
if [ ! -L "${binlink}" ]; then
  ln -sf "${HOME}/dotfiles/bin" "${binlink}"
fi

ALIAS_FILE="${HOME}/.aliases"

for file in ${HOME}/bin/*; do
  # Make bin files executable
  chmod +x "${file}"
  
  ## If its locked down and can't make files executable workaround this by generating aliases for bin files
  if [[ ! -x "${file}" ]]; then
    # Generate aliases for bin files
    isFile=$(file -0 "${file}" | cut -d $'\0' -f2)
    case "${isFile}" in
      (*text*)
        generate_script_alias "${file}" >> "${ALIAS_FILE}"
        ;;
      (*)
        echo "Can't generate script alias for ${file} it is not a text file"
        ;;
    esac
  fi
done

if [[ -f "${ALIAS_FILE}" ]]; then
  echo "# Aliases for bin scripts generated $(date) by $(whoami)" > "${ALIAS_FILE}"
fi