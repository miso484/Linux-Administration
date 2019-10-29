vi /etc/hosts

cat <<EOT
EXAMPLE:
# add records
10.0.0.30       dlp.srv.world dlp
EOT

systemctl restart dnsmasq