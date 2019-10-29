# Enable integrated DHCP function in Dnsmasq and Configure DHCP Server

# configure Dnsmasq
vi /etc/dnsmasq.conf

cat <<EOT
EXAMPLE:
# line 158: add (range of IP address to lease and term of lease)
dhcp-range=10.0.0.200,10.0.0.250,12h

# line 335: add (define default gateway)
dhcp-option=option:router,10.0.0.1

# line 344: add (define NTP, DNS, server and subnetmask)
dhcp-option=option:ntp-server,10.0.0.10
dhcp-option=option:dns-server,10.0.0.10
dhcp-option=option:netmask,255.255.255.0
EOT

# restart
systemctl restart dnsmasq