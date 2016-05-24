#!/bin/bash

echo Make sure you are connected to ethernet and have superuser access!


# Get the cluster network interface from the user and set to variable $IFACE
read -e -p "Enter the network interface name: " -i "eth0" IFACE
echo $IFACE 							

# Get the cluster's gateway ip from the user and save it to variable $GATEWAY
read -e -p "Enter the ip for the gateway: " -i "192.168.10.1" GATEWAY
echo $GATEWAY

# Get the cluster's netmask from the user and save it to variable $MASK
read -e -p "Enter the netmask: " -i "255.255.255.0" MASK
echo $MASK

# Yank the current IP from the desired interface and set to $IP 
IP="$(ifconfig $IFACE | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')"

# Yank hostname from the computer's hostname and set to $HOST
HOST=$(hostname)


# Wipe the current network interfaces setup 
sudo cp ./dependencies/interfaces /etc/network/interfaces

# Write the new static values to finish the new interfaces file
sudo echo "
iface $IFACE inet static
     	address "$IP" 
     	netmask "$MASK"
     	gateway "$GATEWAY"" >> /etc/network/interfaces


# Make a value to be used for the cluster hosts files
FINAL="$IP       $HOST"

# Alert user of end result
echo Finished, found $HOST for the hostname, found $IP for ip, $GATEWAY for the gateway, and $NETMASK for the netmask!

# Populates file with only host names (to be used later in the install process)
echo "$HOST" >> ./dependencies/hosts

# Populates the file for the complete node list 
echo "$FINAL" >> ./dependencies/node_list
echo "$FINAL"
echo
