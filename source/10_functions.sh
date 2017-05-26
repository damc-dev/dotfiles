# uuencode alternative
encode() {
  python -c 'import sys,uu; uu.encode("'$1'", sys.stdout)'
}

# Replace newlines with commas
listjoin() {
  cat $@ | awk -vORS=, 'NF { print $1 }'| sed 's/,$/\n/'
}

# File get
fget () {
  curl -O "$@"
}

dowhile() {
  while true; do
    $@
  done
}

TopMemUsage() {
    ps aux | sort -nk +4 | tail
}

cleantemp() {
  cd ~/
  tar -zcvf $BACKUP_DIR/$(date +"%Y-%m-%d_%H%M%S").temp.tar.gz temp
  if [ "$?" == "0" ]; then
    rm -rf temp/*
  fi
}

now() {
  date +"%Y-%m-%dT%H:%M:%S.%N%:z"
}

recentRpms() {
  NUM=5
  if [ "$1" != "" ]; then
    NUM="$1"
  fi
  rpm -qa  --queryformat '%{installtime} (%{installtime:date}) %{name}\n' | sort -n -r | head -$NUM
}

sendme() {
  file=$1
  if [ -a "$file" ]; then
      cat "$file" | uuencode "$file" | mail damcelli@up.com -s "!SAVE: sendme $file from $HOSTNAME"
  fi
}

whenchanged() {
  set -e

  usage="Usage: whenchanged FILE COMMAND
  Run command when specified file is changed

  Where
      help|--h    show this help text
      -i          interval to check for changes

      Examples:
          whenchanged errors.log mail damcelli@up.com -s \"errors.log changed on $HOSTNAME\""

  INTERVAL=5

  _usage() {
  echo "$usage"
  }

  _when_exec() {
  if [ "$CLEAR_FLAG" == "1" ] ; then
      clear
  fi

  ### Set initial time of file
  LTIME=`stat -c %Z "${FILE}"`
  while true
  do
     ATIME=`stat -c %Z "${FILE}"`
     if [[ "$ATIME" != "$LTIME" ]]
     then
         if [ "$CLEAR_FLAG" == "1" ] ; then
              clear
         fi
         echo "[$(echo $ATIME | date)] File Change Detected"
         $COMMAND
         LTIME=$ATIME
     fi
     sleep $INTERVAL
  done
  }

  while [[ $# > 0 ]]
  do
      key="$1"

      case "$key" in
          -h|--help)
              _usage
              exit 0
              ;;
          -i|--interval)
              CURR_OPT="interval"
              INTERVAL="$2"
              shift
              ;;
           -clr)
              CLEAR_FLAG=1
              ;;
           -*|--*)
              echo "[ERROR] $key is not a valid option"
              _usage
              exit 1
              ;;
           *)
              break
              ;;
      esac
      shift
  done
  FILE="$1"
  COMMAND="${@:2}"

  _when_exec

}


