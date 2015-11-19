#!/bin/bash

read -e -p "Enter the ip for the gateway: " -i "192.168.10.1" GATEWAY
echo $GATEWAY

read -e -p "Enter the netmask: " -i "255.255.255.0" MASK
echo $MASK

IP="$(ifconfig | grep -A 1 'eth0' | tail -1 | cut -d ':' -f 2 | cut -d ' ' -f 1)"

HOST==$(hostname)

sudo touch ~/etc/network/interfaces 
sudo echo "
	iface eth0 inet static
     	address "$IP" 
     	netmask "$MASK"
     	gateway "$GATEWAY"" >> ~/etc/network/interfaces

echo Finished, found $HOST for the hostname, found $IP for ip, $GATEWAY for the gateway, and $NETMASK for the netmask!
echo
