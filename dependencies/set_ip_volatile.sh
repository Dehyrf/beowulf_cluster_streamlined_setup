#!/bin/bash

# Create a clean version of the network interfaces
sudo cp ./dependencies/interfaces /etc/network/interfaces

################################################################
# Remove *: '* and *'* below if current non-dhcp settings are 
# not working to reset the ip address as volatile and run again
: '
sudo echo "
# The primary network interface
iface eth0 inet dhcp" >> /etc/network/interfaces
'
################################################################
