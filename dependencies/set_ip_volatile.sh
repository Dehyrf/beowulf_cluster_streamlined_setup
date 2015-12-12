sudo cp ./dependencies/interfaces /etc/network/interfaces

sudo echo "
# The primary network interface
iface eth0 inet dhcp" >> /etc/network/interfaces
