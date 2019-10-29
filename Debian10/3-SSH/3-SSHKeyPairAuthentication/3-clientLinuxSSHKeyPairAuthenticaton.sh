#!/bin/bash

read -p "Linux SSH User: " LINUX_USER
read -p "Linux SSH Server IP: " LINUX_IP

# setup ssh directory
mkdir ~/.ssh
chmod 700 ~/.ssh

# copy the secret key to the local ssh directory
scp "$LINUX_USER@$LINUX_IP":"/home/$LINUX_USER/.ssh/id_rsa ~/.ssh/"

# improve security
chmod 400 ~/.ssh/id_rsa

# test connection
ssh "$LINUX_USER@$LINUX_IP"

echo "# if you set [PasswordAuthentication no], it's more secure
nano /etc/ssh/sshd_config
# line 56: uncomment and change to [no]
PasswordAuthentication no"