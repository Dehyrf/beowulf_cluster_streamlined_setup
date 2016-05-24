#!/bin/bash

# Sets IP so it can change
read -rsp $'Please begin without a network connection of any kind. Press any key to continue...\n' -n1 key
bash ./dependencies/set_ip_volatile.sh 

echo
echo 'Reset ip, finished with part 1 of 4'
echo

# Updates and installs programs needed
read -rsp $'Please connect to a network with internet access to download software (Note: this does not have to be your cluster network). Press any key to continue...\n' -n1 key
sudo apt-get update
sudo apt-get install build-essential openssh-server nfs-kernel-server nfs-common
sudo dpkg -i ./dependencies/mpich2_1.4.1-1ubuntu1_i386.deb
sudo apt-get -f install
sudo apt-get autoremove && sudo apt-get autoclean

echo
echo 'Installed needed programs, finished with part 2 of 4'
echo

# Sets IP Static on the network and adds computer info to the node list file
read -rsp $'Now, plug in ethernet to your gateway for the cluster. Press any key to continue once it is connected...\n' -n1 key
bash ./dependencies/set_current_ip_static.sh

echo
echo 'Set static ip, finished with part 3 of 4'
echo

# Creates a dedicated user for the cluster, the accounts have no password (but you can change that if security is a issue with 'passwd mpiuser' on all nodes)
echo Creating user mpiuser, please leave all fields blank/default!
sudo adduser mpiuser --uid 999
echo Just made user: mpiuser

echo
echo 'Created user, finished with part 4 of 4'
echo

# Provides further instruction
echo 'Now, please run the setup_part_1 script on all machines in the cluster. Once done, proceed to running setup_part_2 on the machines (but run it on the master node last).'
