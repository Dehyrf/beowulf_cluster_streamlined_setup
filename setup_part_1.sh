#!/bin/bash

#Sets IP so it can change
read -rsp $'Please begin without ethernet plugged in. Press any key to continue...\n' -n1 key
bash ./dependencies/set_ip_volatile.sh 

#Sets IP Static on the network and adds computer info to the node list file
read -rsp $'Now plug in ethernet. Press any key to continue once it is connected...\n' -n1 key
bash ./dependencies/set_current_ip_static.sh

#Updates and installs programs needed
sudo apt-get update
sudo --yes install build-essentials openssh-server
sudo --yes apt-get autoremove && sudo apt-get --yes autoclean

#Creates a dedicated user
sudo useradd mpiuser sudo
echo Just made user: mpiuser
sudo passwd mpiuser

#Provides further instruction
echo Now, please run the setup_part_1 script on all machines in the cluster. Once done, proceed to running setup_part_2 on the machines.
