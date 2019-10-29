#!/bin/bash

# check - ipv6 is listed
ip addr

# disable
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf

# print changes
sysctl -p

# check  - ipv6 is not listed
ip addr