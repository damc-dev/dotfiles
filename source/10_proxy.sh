proxy(){
  echo -n "username:"
  read -e username
  echo -n "password:"
  read -es password
  export http_proxy="http://$username:$password@proxysg.swg.apps.uprr.com:8080/"
  export HTTP_PROXY="http://$username:$password@proxysg.swg.apps.uprr.com:8080/"
  export https_proxy="https://$username:$password@proxysg.swg.apps.uprr.com:8080/"
  export ftp_proxy="http://$username:$password@proxysg.swg.apps.uprr.com:8080/"
}

proxy_clear() {
  unset http_proxy
  unset HTTP_PROXY
  unset https_proxy
  unset ftp_proxy
}
