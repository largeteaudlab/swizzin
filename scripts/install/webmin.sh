#! /bin/bash
# shellcheck disable=SC2024
# Webmin installer
# flying_sausages for swizzin 2020

if [[ -f /tmp/.install.lock ]]; then
  log="/root/logs/install.log"
else
  log="/root/logs/swizzin.log"
fi

_install_webmin () {
    echo "Installing Webmin repo"
    echo "deb https://download.webmin.com/download/repository sarge contrib" > /etc/apt/sources.list.d/webmin.list
    wget http://www.webmin.com/jcameron-key.asc >> $log 2>&1
    sudo apt-key add jcameron-key.asc >> $log 2>&1
    rm jcameron-key.asc
    echo "Fetching updates"
    apt-get update >> $log 2>&1
    echo "Installing Webmin from apt"
    apt-get install webmin -yq >> $log 2>&1
}

_install_webmin
bash /etc/swizzin/scripts/nginx/webmin.sh

echo 
echo "Webmin has been installed, please use any account with sudo permissions to log in"

touch /install/.webmin.lock