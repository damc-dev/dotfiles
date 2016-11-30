recentRpms() {
  NUM=5
  if [ "$1" != "" ]; then
    NUM="$1"
  fi
  rpm -qa  --queryformat '%{installtime} (%{installtime:date}) %{name}\n' | sort -n -r | head -$NUM
}

