#!/bin/bash
PASSWORD='password123'
cat > 
sudo apt-get update
sudo --yes install build-essentials openssh-server
sudo --yes apt-get autoremove && sudo apt-get --yes autoclean
sudo useradd mpiuser sudo
sudo passwd mpiuser
sudo sed -i -e '1i$IP_LIST' /etc/hosts
