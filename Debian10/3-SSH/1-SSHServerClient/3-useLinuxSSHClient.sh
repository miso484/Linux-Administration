#!/bin/bash

read -p "Linux SSH User: " LINUX_USER
read -p "Linux SSH Server IP: " LINUX_IP

# install SSH client
apt -y install openssh-client

# connect to the SSH server with a common user
# ssh [username@hostname or IP address]
ssh "$LINUX_USER@$LINUX_IP"