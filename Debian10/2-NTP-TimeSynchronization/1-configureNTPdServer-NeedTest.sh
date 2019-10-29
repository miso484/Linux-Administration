#!/bin/bash

apt -y install ntp

echo "# line 23: comment out
# pool 0.debian.pool.ntp.org iburst
# pool 1.debian.pool.ntp.org iburst
# pool 2.debian.pool.ntp.org iburst
# pool 3.debian.pool.ntp.org iburst
# add servers in your timezone to sync times
server ntp.nict.jp iburst
server ntp1.jst.mfeed.ad.jp iburst
# line 52: add the network range you allow to receive requests
restrict 10.0.0.0 mask 255.255.255.0 nomodify notrap"


vi /etc/ntp.conf

systemctl restart ntp

# show status
ntpq -p

# echo NTP uses 123/UDP