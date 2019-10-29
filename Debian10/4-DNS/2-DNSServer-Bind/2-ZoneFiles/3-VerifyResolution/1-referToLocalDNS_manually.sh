# Restart BIND to apply changes and Verify name or Address Resolution

systemctl restart bind9

vi /etc/resolv.conf

cat <<EOT
EXAMPLE:
# change to own address
domain srv.world
search srv.world
nameserver 10.0.0.30
EOT