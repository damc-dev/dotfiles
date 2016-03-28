cleantemp() {
  cd ~/
  tar -zcvf $BACKUP_DIR/$(date +"%Y-%m-%d_%H%M%S").temp.tar.gz temp
  if [ "$?" == "0" ]; then
    rm -rf temp/*
  fi
}

