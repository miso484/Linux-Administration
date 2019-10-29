# On this example, Configure BIND with internal address [10.0.0.0/24],
# domain name [srv.world]. Pease replace IP addresses and Domain Name to your own environment.

vi /etc/bind/0.0.10.db

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
        # define the range of this domain included
        IN  PTR     srv.world.
        IN  A       255.255.255.0

# define hostname of the IP address
30      IN  PTR     dlp.srv.world.
EOT