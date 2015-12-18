#!/bin/bash

#Log in as mpi user
read -rsp $'Please make sure you are running this as mpiuser. If not, please exit, and run the script as mpiuser. Press any key to continue...\n' -n1 key

#Moves the host list with all of the other computers to the current machine
sudo cp ./dependencies/node_list /etc/hosts

#Ask if master node, and if so, setup network filesharing using NFS
read -p "Is this the master node?(Y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then    
        #Remove the NFS client from the master
        sudo apt-get remove nfs-common
       
	echo
	echo 'Removed NFS client, finished with part 1 of 5'
	echo
 
        #Share the home directory, restart the file server, and change firewall settings on the master node
        sudo echo "/home/mpiuser *(rw,sync,no_subtree_check)" >> /etc/exports
        sudo service nfs-kernel-server restart
        read -e -p "Enter the subnet of the cluster: " -i "192.168.10.0" SUBN
        sudo ufw allow from '$SUBN'/24
        
	echo
	echo 'Set up NFS server and firewall, finished with part 2 of 5'
	echo

        #Generate the master ssh key for all slave nodes and share to all using the NFS server
        echo When asked for a passphrase, leave it empty! 
        ssh-keygen
        ssh-copy-id localhost

	echo
	echo 'Generated ssh key, finished with part 3 of 5'
	echo

        #Set up MPI and Hyrda
        cp ./dependencies/hosts ~/hosts
        cp ./dependencies/hosts ~/mpd.hosts
        cp ./dependencies/hosts ~/.mpd.conf
        chmod 600 ~/.mpd.conf
       
	echo
	echo 'Set up MPICH, finished with part 4 of 5'
	echo
 
        #Set secret passphrase for the cluster
        read -e -p "Enter the secret passphrase for the cluster: " -i "Pa$$w0rd" SECRET
        echo "secretword="$SECRET"" >> ~/.mpd.conf
        
	echo
	echo 'Made passphrase, finished with part 5 of 5'
	echo 'Now ready to boot nodes!'
	echo

        #Boot MPI on the nodes
        read -e -p "Number of slave nodes in the cluster: " -i "3" NODES
        mpdboot -n $NODES
        echo Below are the working nodes ready to go!
        mpdtrace -l
fi

echo 'Setup is done!'
