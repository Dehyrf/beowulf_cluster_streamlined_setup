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
        
        #Set up MPI and Hyrda
        cp ./dependencies/hosts ~/hosts
        cp ./dependencies/hosts ~/mpd.hosts
        cp ./dependencies/hosts ~/.mpd.conf
        chmod 600 ~/.mpd.conf
        
        #Set secret passphrase for the cluster
        read -e -p "Enter the secret passphrase for the cluster: " -i "Pa$$w0rd" SECRET
        echo "secretword="$SECRET"" >> ~/.mpd.conf
        
        #Now, to boot MPI on the nodes
        read -e -p "Number of slave nodes in the cluster: " -i "3" NODES
        mpdboot -n $NODES
        echo Below are the working nodes ready to go!
        mpdtrace -l
fi
