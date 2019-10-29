# Verify to resolve Name or IP address from a client computer in internal network. By the way, when Dnsmasq is running, 
# fixed value [127.0.0.1] is added in [/etc/resolv.conf] and also the value of "dns-nameservers" in [/etc/network/interfaces] is added and managed in [/var/run/dnsmasq/resolv.conf]

vi /etc/network/interfaces

cat <<EOT
EXAMPLE:
# change DNS setting to Dnsmasq Server
dns-nameservers 10.0.0.30"
EOT

systemctl restart ifup@ens2 resolvconf

dig dlp.srv.world.
dig -x 10.0.0.30