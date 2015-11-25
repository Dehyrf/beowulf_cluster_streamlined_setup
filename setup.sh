#!/bin/bash

echo "Please begin without ethernet plugged in"
bash ./dependencies/set_ip_volatile.sh 
echo "Now plug in ethernet. Does the computer show that it is connected? "
bash ./dependencies/set_current_ip_static.sh
sudo apt-get update
sudo --yes install build-essentials openssh-server
sudo --yes apt-get autoremove && sudo apt-get --yes autoclean
sudo useradd mpiuser sudo
sudo passwd mpiuser
sudo sed -i -e ./dependencies/node_list /etc/hosts
