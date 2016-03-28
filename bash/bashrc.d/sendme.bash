sendme() {
  file=$1
  if [ -a "$file" ]; then
      cat "$file" | uuencode "$file" | mail damcelli@up.com -s "!SAVE: sendme $file from $HOSTNAME"
  fi
}

