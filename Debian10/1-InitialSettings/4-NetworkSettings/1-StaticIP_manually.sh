#!/bin/bash

cho "### Apply folowing changes to /etc/network/interfaces file ###
NOTE: The interface name 'ens2' is different on each environment
      replace it if you own one.

# comment out
#iface ens2 inet dhcp
# add static settings
iface ens2 inet static
# IP address
address 10.0.0.30
# network address
network 10.0.0.0
# subnet mask
netmask 255.255.255.0
# broadcast address
broadcast 10.0.0.255
# default gateway
gateway 10.0.0.1
# name server
dns-nameservers 10.0.0.10"

# open interfaces file
nano /etc/network/interfaces

# restart (change ens2 if you have different interface name)
systemctl restart networking ifup@ens2

# check
ip addr