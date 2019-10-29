#!/bin/bash

echo "# add to the end of visudo: user [devops] can use all root privilege
# how to write ⇒ destination host=(owner) command
devops    ALL=(ALL:ALL) ALL

# push [Ctrl + x] key to quit visudo"

read -p "Press any key to open visudo ..."

visudo

# virify with user 'devops'
#/usr/sbin/reboot
# denied

# try with sudo - add password of 'devops' user
#sudo /usr/sbin/reboot
# denied