vi /etc/dnsmasq.conf

cat <<EOT
EXAMPLE:
# line 19: uncomment (never forward plain names)
domain-needed
# line 21: uncomment (never forward addresses in the non-routed address spaces)
bogus-priv
# line 53: uncomment (query with each server strictly in the order in resolv.conf)
strict-order
# line 67: add if you need
# query the specific domain name to the specific DNS server
# the example follows means query [server.education] domain to the [10.0.0.10] server
server=/server.education/10.0.0.10
# line 135: uncomment (add domain name automatically)
expand-hosts
# line 145: add (define domain name)
domain=srv.world"
EOT

systemctl restart dnsmasq