#
## Get SSL certificates, refer to Certificates section
#

# This example is based on the case that SSL certificates are gotten under the [/etc/letsencrypt/live/dlp.srv.world] and set the [Common Name] as [dlp.srv.world].

#
## Copy certificates created above and configure PostgreSQL.
#

cp /etc/letsencrypt/live/dlp.srv.world/* /etc/postgresql/11/main/
chown postgres. /etc/postgresql/11/main/*.pem
chmod 600 /etc/postgresql/11/main/*.pem

vi /etc/postgresql/11/main/postgresql.conf
cat <<EOT
# line 98: change
ssl = on

# line 100: change to your own certs
ssl_ca_file = '/etc/postgresql/11/main/chain.pem'
ssl_cert_file = '/etc/postgresql/11/main/cert.pem'
ssl_key_file = '/etc/postgresql/11/main/privkey.pem'
EOT

vi /etc/postgresql/11/main/pg_hba.conf
cat <<EOT
# line 92: change like follows
# all users except localhost with peer are required SSL/TLS
# "local" is for Unix domain socket connections only
local   all             all                                     peer
# IPv4 local connections:
#host    all             all             127.0.0.1/32            md5
hostssl all             all             127.0.0.1/32            md5
hostssl all             all             10.0.0.0/24             md5
hostssl all             all             ::1/128                 md5
EOT

systemctl restart postgresql

# verify accessing
# no SSL/TLS connection from localhost with peer
psql testdb

# for other connections, connection is on SSL/TLS
psql "user=debian host=localhost dbname=testdb"

# from other hosts, connection is on SSL/TLS
psql "host=dlp.srv.world dbname=testdb"