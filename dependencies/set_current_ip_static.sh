#!/bin/bash

echo Make sure you are connected to ethernet and are running this script as a super user!

read -e -p "Enter the network interface name: " -i "eth0" IFACE
echo $IFACE

read -e -p "Enter the ip for the gateway: " -i "192.168.10.1" GATEWAY
echo $GATEWAY

read -e -p "Enter the netmask: " -i "255.255.255.0" MASK
echo $MASK

IP="$(ifconfig $IFACE | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')"

HOST=$(hostname)

sudo echo "
iface $IFACE inet static
     	address "$IP" 
     	netmask "$MASK"
     	gateway "$GATEWAY"" >> /etc/network/interfaces

FINAL="$IP       $HOST"
echo Finished, found $HOST for the hostname, found $IP for ip, $GATEWAY for the gateway, and $NETMASK for the netmask!
#Populates file with only host names (to be used later)
echo "$HOST" >> hosts
#Populates the file for the complete node list 
echo "$FINAL" >> node_list
echo "$FINAL"
echo
