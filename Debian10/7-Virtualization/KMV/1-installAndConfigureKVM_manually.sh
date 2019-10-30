# install required packages
apt -y install qemu-kvm libvirt-daemon libvirt-daemon-system virtinst libosinfo-bin bridge-utils

# make sure modules are loaded
lsmod | grep kvm

# enable vhost-net
modprobe vhost_net
lsmod | grep vhost
echo vhost_net >> /etc/modules

# configure Bridge networking
vi /etc/network/interfaces
cat <<EOT
# EXAMPLE:
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

auto ens2
# change existing setting like follows <===
iface ens2 inet manual
#iface ens2 inet static
#address 10.0.0.30
#network 10.0.0.0
#netmask 255.255.255.0
#broadcast 10.0.0.255
#gateway 10.0.0.1
#dns-nameservers 10.0.0.10

# add bridge interface setting <===
iface br0 inet static
address 10.0.0.30
network 10.0.0.0
netmask 255.255.255.0
broadcast 10.0.0.255
gateway 10.0.0.1
dns-nameservers 10.0.0.30
bridge_ports ens2
bridge_stp off
auto br0
EOT

reboot

ip addr