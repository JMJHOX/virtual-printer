#!/bin/bash

func(){
    echo "Username: $USER"
    echo "    EUID: $EUID"
}

export -f func
#Loggin user
func
su "$SUDO_USER" -c 'func'

#Installing docker
sudo apt-get update
 sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io


#Installing printer drivers
sudo apt-get update
sudo apt-get remove hplip cups-filters cups hplip-data system-config-printer-udev
sudo apt-get install build-essential tix groff dc axel cups
sudo apt-get install cups-filters unp system-config-printer-gnome
sh hplip.run 