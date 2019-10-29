# set CNAME record in zone file
vi /etc/bind/srv.world.lan

cat <<EOT
EXAMPLE:
$TTL 86400
@   IN  SOA     dlp.srv.world. root.srv.world. (
        # update serial <=====
        2019071602  ;Serial
        3600        ;Refresh
        1800        ;Retry
        604800      ;Expire
        86400       ;Minimum TTL
)
        IN  NS      dlp.srv.world.
        IN  A       10.0.0.30
        IN  MX 10   dlp.srv.world.

dlp     IN  A       10.0.0.30
# aliase IN CNAME server's hostname <=====
ftp     IN  CNAME   dlp.srv.world.
EOT

# reload server
rndc reload

# verify
dig ftp.srv.world.