# Source generated aliases
if [ -f ~/.aliases ]; then
  source ~/.aliases
fi

# Replace newlines with commas
listjoin() {
  cat $@ | awk -vORS=, 'NF { print $1 }'| sed 's/,$/\n/'
}

# File get
fget () {
  curl -O "$@"
}
