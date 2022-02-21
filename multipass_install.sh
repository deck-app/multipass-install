#!/bin/sh
#Set up the required package
echo "Running apt update, installing dependencies"
sudo apt update
pkgs='curl uidmap apt-transport-https ca-certificates gnupg lsb-release docker.io neofetch'
if ! dpkg -s $pkgs >/dev/null 2>&1; then
  sudo apt-get install -y $pkgs
fi
#List the versions available in your repo
apt-cache madison docker-ce
sudo usermod -aG docker $USER

echo "Staring docker";
sudo loginctl enable-linger $(whoami)
echo "sudo chmod 666 /var/run/docker.sock";
sudo chmod 666 /var/run/docker.sock
sudo wget https://raw.githubusercontent.com/nabad600/multipass-script/main/override.conf
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo cp override.conf /etc/systemd/system/docker.service.d/override.conf
sudo rm -rf override.conf

clear
neofetch
echo "All service restart.";
sudo systemctl daemon-reload
sudo systemctl restart docker.service
echo "All set and done.";
