# Remove an entry from $PATH
# Based on http://stackoverflow.com/a/2108540/142339
function path_remove() {
  local arg path
  path=":$PATH:"
  for arg in "$@"; do path="${path//:$arg:/:}"; done
  path="${path%:}"
  path="${path#:}"
  echo "$path"
}

paths=(
  "/usr/local/sbin"
  "$HOME/.local/bin"
  "$DOTFILES/bin"
  "/opt/chefdk/embedded/bin"
  "$GOROOT/bin"
  "$GOPATH/bin"
  "/usr/local/opt/libpq/bin"
  "/usr/local/opt/python@3.8/bin"
  "$HOME/.poetry/bin"
)

export PATH
for p in "${paths[@]}"; do
  [[ -d "$p" ]] && PATH="$p:$(path_remove "$p")"
done
unset p paths
