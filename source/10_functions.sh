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
  FROM="$(whoami)@up.com"
  TO="damcelli@up.com"
  FILE=""
  usage() { echo "$0 usage:"  && grep " .)\ #" $0; exit 0; }
  while getopts ":ts: --long to:subject:" opt; do
    case "${opt}" in
      t | to ) # List of email addresses to send to (comma delimited)
        TO="${OPTARG}"
        ;;
      s | subject ) # Subject of email (default: "!SAVE sendme $file from $HOSTNAME")
        SUBJECT="${OPTARG}"
        ;;
      h | * )
        usage
        exit 0
        ;;
    esac
  done
  shift $(expr $OPTIND - 1 )
  FILE="$1"

  if [ -z "${SUBJECT}" ]; then
    SUBJECT="!SAVE sendme $FILE from $HOSTNAME"
  fi
  encode $FILE | mail -s "${SUBJECT}" -r "${FROM}" $TO
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


