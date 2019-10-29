# On this example, Configure BIND with internal address [10.0.0.0/24], 
# domain name [srv.world]. Pease replace IP addresses and Domain Name to your own environment.

vi /etc/bind/srv.world.lan

cat <<EOT
EXAMPLE:
$TTL 86400
@   IN  SOA     dlp.srv.world. root.srv.world. (
        2019071601  ;Serial
        3600        ;Refresh
        1800        ;Retry
        604800      ;Expire
        86400       ;Minimum TTL
)
        # define name server
        IN  NS      dlp.srv.world.
        # define name server's IP address
        IN  A       10.0.0.30
        # define mail exchanger
        IN  MX 10   dlp.srv.world.

# define IP address of the hostname
dlp     IN  A       10.0.0.30
EOT