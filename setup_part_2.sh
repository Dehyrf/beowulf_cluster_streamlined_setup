#!/bin/bash

#Moves the host list with all of the other computers to the current machine
sudo sed -i -e ./dependencies/node_list /etc/hosts

#Log in as mpi user
echo Please enter the password for mpiuser:
su mpiuser

#Ask if master node, and if so, setup network fileshare using NFS
read -p "Is this the master node?(Y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
        #Share the home directory, restart the file server, and change firewall settings on the master node
        sudo echo "/home/mpiuser *(rw,sync,no_subtree_check)" >> /etc/exports
        sudo service nfs-kernel-server restart
        read -e -p "Enter the subnet of the cluster: " -i "192.168.10.0" SUBN
        sudo ufw allow from '$SUBN'/24
        
        #Generate the master ssh key for all slave nodes and share to all using the NFS server
        echo When asked for a passphrase, leave it empty! 
        ssh-keygen
        ssh-copy-id localhost
        cd ~
        touch hosts
        while read host _; do echo "$host" >> ./dependencies/hosts "$word"; done < ./dependencies/node_list
fi



