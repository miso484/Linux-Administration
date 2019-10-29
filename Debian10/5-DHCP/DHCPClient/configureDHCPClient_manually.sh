# 	On Debian client, Configure like follows to get IP address from DHCP server.
# The interface name [ens2] is different on each environment, replace to your own one.

vi /etc/network/interfaces

cat <<EOT
EXAMPLE:
# line 12: change
iface ens3 inet dhcp
EOT

systemctl restart ifup@ens2