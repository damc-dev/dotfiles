# Create and navigate into directory
mkcd() {
  mkdir -p -- "$1" &&
    cd -P -- "$1"
}

# Email me a reminder
remindme() {
  echo "Reminder sent from $HOSTNAME at $(date)" | mail -s '!REMINDER '"$1" -r "$(whoami)@up.com" damcelli@up.com
}

# Replace newlines with commas
listjoin() {
  cat $@ | awk -vORS=, 'NF { print $1 }'| sed 's/,$/\n/'
}

# List lines in first file not in second file
missinglines() {
  comm -23 <(sort "$1") <(sort "$2")
}

# File get
fget () {
  curl -O "$@"
}

# Set password in session
setpassword() {
  read -s -p "Password:" password
  echo
  export PASWD="$(base64 <<< ${password})"
  echo "password set"
}

# Remove password from session
nopassword() {
  unset PASWD
  echo "password unset"
}

dowhile() {
  while true; do
    $@
  done
}

largestfiles() {
  find $1 -type f -exec du -ah {} \; | sort -k1 -h
}

largestdirs() {
  du -h $1 | sort -k1 -h
}

TopMemUsage() {
    ps aux | sort -nk +4 | tail
}

lastcommand() {
  fc -ln "$1" "$1" | sed '1s/^[[:space:]]*//'
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

debug_msg() {
  if [ $DEBUG -eq 1 ]; then
    echo "$1"
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


