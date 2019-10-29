vi /etc/bind/named.conf.external-zones

cat <<EOT
EXAMPLE:
# add settings like follows
        zone "srv.world" {
                type slave;
                masters { 172.16.0.82; };
                file "/etc/bind/slaves/srv.world.wan";
        };
EOT

mkdir /etc/bind/slaves
chown bind. /etc/bind/slaves

# reload server
rndc reload

# verify that zone files in master DNS has been transfered
ls /etc/bind/slaves