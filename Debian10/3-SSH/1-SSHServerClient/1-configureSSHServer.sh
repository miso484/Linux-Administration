#!/bin/bash

apt -y install openssh-server

# prohibit root login
echo "# line 32: uncomment and change to no
PermitRootLogin no"
vi /etc/ssh/sshd_config

systemctl restart ssh