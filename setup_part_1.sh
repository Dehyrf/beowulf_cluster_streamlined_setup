#!/bin/bash

#Sets IP so it can change
read -rsp $'Please begin without a network connection of any kind. Press any key to continue...\n' -n1 key
bash ./dependencies/set_ip_volatile.sh 

#Updates and installs programs needed
read -rsp $'Please connect to a network with internet access to download software (Note: this does not have to be your cluster network). Press any key to continue...\n' -n1 key
sudo apt-get update
sudo --yes install build-essentials openssh-server
sudo --yes apt-get autoremove && sudo apt-get --yes autoclean

#Sets IP Static on the network and adds computer info to the node list file
read -rsp $'Now, plug in ethernet to your gateway for the cluster. Press any key to continue once it is connected...\n' -n1 key
bash ./dependencies/set_current_ip_static.sh

#Creates a dedicated user
sudo useradd mpiuser sudo
echo Just made user: mpiuser
sudo passwd mpiuser

#Provides further instruction
echo Now, please run the setup_part_1 script on all machines in the cluster. Once done, proceed to running setup_part_2 on the machines.
