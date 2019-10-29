#!/bin/bash

apt -y install chrony

echo "# line 3: comment out
#pool 2.debian.pool.ntp.org iburst
# add servers in your timezone to sync times
server ntp.nict.jp iburst
server ntp1.jst.mfeed.ad.jp iburst
# add to the end : add the network range you allow to receive requests
allow 10.0.0.0/24"

vi /etc/chrony/chrony.conf

chronyc makestep