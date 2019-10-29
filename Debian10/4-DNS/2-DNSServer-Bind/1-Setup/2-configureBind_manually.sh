# On this example, Configure BIND with Grobal IP address [172.16.0.80/29], 
# Private IP address [10.0.0.0/24], Domain name [srv.world].
# However, Please replace IP addresses and Domain Name to your own environment. 
#( Actually, [172.16.0.80/29] is for private IP address, though. )

vi /etc/bind/named.conf

cat <<EOT
# comment out
# include "/etc/bind/named.conf.default-zones";
# add
include "/etc/bind/named.conf.internal-zones";
include "/etc/bind/named.conf.external-zones";
EOT

vi /etc/bind/named.conf.internal-zones

cat <<EOT
EXAMPLE:
# create new
# define for internal section
view "internal" {
        match-clients {
                localhost;
                10.0.0.0/24;
        };
        # set zone for internal
        zone "srv.world" {
                type master;
                file "/etc/bind/srv.world.lan";
                allow-update { none; };
        };
        # set zone for internal *note
        zone "0.0.10.in-addr.arpa" {
                type master;
                file "/etc/bind/0.0.10.db";
                allow-update { none; };
        };
        include "/etc/bind/named.conf.default-zones";
};
EOT

vi /etc/bind/named.conf.external-zones

cat <<EOT
EXAMPLE:
# create new
# define for external section
view "external" {
        match-clients { any; };
        # allow any query
        allow-query { any; };
        # prohibit recursion
        recursion no;
        # set zone for external
        zone "srv.world" {
                type master;
                file "/etc/bind/srv.world.wan";
                allow-update { none; };
        };
        # set zone for external *note
        zone "80.0.16.172.in-addr.arpa" {
                type master;
                file "/etc/bind/80.0.16.172.db";
                allow-update { none; };
        };
};

# *note : For How to write for reverse resolving, Write network address reversely like below
# Case of 10.0.0.0/24
# network address        ⇒ 10.0.0.0
# range of network       ⇒ 10.0.0.0 - 10.0.0.255
# how to write           ⇒ 0.0.10.in-addr.arpa

# Case of 172.16.0.80/29
# network address        ⇒ 172.16.0.80
# range of network       ⇒ 172.16.0.80 - 172.16.0.87
# how to write           ⇒ 80.0.16.172.in-addr.arpa
EOT