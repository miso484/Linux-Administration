#!/bin/bash

apt -y install chrony

systemctl enable chronyd 

echo "# line 3: comment out
#pool 2.debian.pool.ntp.org iburst
# add servers in your timezone to sync times
server ntp.nict.jp iburst
# add to the end : add the network range you allow to receive requests
allow 10.0.0.0/24"

vi /etc/chrony/chrony.conf

systemctl restart chrony

# show sync
chronyc tracking

# show status
chronyc sources

echo "NTP uses 123/UDP"