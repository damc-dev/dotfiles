svnco() {
  local SVN_URL="$1"
  URL_NOPRO="${SVN_URL:7}"
  URL_NO_TRUNK="${URL_NOPRO%/*}"
  REPO_NAME="${URL_NO_TRUNK##/*/}"
  CWD="${PWD##*/}"
  
  if [[ "$SVN_URL" != *"$CWD"* ]]; then
    echo "Error: Could not locate relative directory ${CWD} in ${SVN_URL}"
  else
    CHECKOUT_DIR="${PWD}/${URL_NO_TRUNK#*${CWD}/}"
    echo "CHECKOUT_DIR: $CHECKOUT_DIR"
    
    if [ -d "$CHECKOUT_DIR" ]; then
      echo "Error: Directory already exists $CHECKOUT_DIR"
    else
        svn co $SVN_URL "$CHECKOUT_DIR"
    fi
  fi
}
