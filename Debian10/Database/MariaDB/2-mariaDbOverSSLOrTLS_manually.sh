#
## Get SSL Certificates, refer to Certificates section.
#

#
## Configure MariaDB for SSL/TLS.
#

# copy certificates and convert format for certificate key
mkdir /var/lib/mysql/pki
cp /etc/letsencrypt/live/www.srv.world/* /var/lib/mysql/pki/
openssl rsa -in /var/lib/mysql/pki/privkey.pem -out /var/lib/mysql/pki/priv.key
chown -R mysql. /var/lib/mysql/pki

vi /etc/mysql/mariadb.conf.d/50-server.cnf
cat <<EOT
# line 88-9: uncomment and change to your own certs
ssl-ca = /var/lib/mysql/pki/chain.pem
ssl-cert = /var/lib/mysql/pki/cert.pem
ssl-key = /var/lib/mysql/pki/priv.key
EOT

systemctl restart mariadb

# verify settings (enter password)
mysql -u root -p

# OK if status is like follows
  show variables like '%ssl%'; 
cat <<OUTPUT
+---------------------+------------------------------+
| Variable_name       | Value                        |
+---------------------+------------------------------+
| have_openssl        | NO                           |
| have_ssl            | YES                          |
| ssl_ca              | /var/lib/mysql/pki/chain.pem |
| ssl_capath          |                              |
| ssl_cert            | /var/lib/mysql/pki/cert.pem  |
| ssl_cipher          |                              |
| ssl_crl             |                              |
| ssl_crlpath         |                              |
| ssl_key             | /var/lib/mysql/pki/priv.key  |
| version_ssl_library | YaSSL 2.4.4                  |
+---------------------+------------------------------+
OUTPUT

#
## To connect with SSL/TLS from Localhost, connect with specifying Certs
#

vi /etc/mysql/mariadb.conf.d/50-mysql-clients.cnf
cat <<EOT
[mysql]
# add follows into [mysql] section
ssl-cert=/var/lib/mysql/pki/cert.pem
ssl-key=/var/lib/mysql/pki/priv.key
EOT

# connect to mariadb (enter password)
mysql -u root -p

# show status (this connection has DHE-RSA-AES256-SHA ssl_cipher)
 show status like 'ssl_cipher'; 
 exit

# for no SSL/TLS connection
mysql -u root -p --ssl=false

# value is empty
 show status like 'ssl_cipher';
 exit

#
## To force users to connect with SSL/TLS, set like follows.
#

# connect to mongodb
mysql -u root -p

# create a user
 create user debian identified by 'password'; 

# show status, SSL/TLS required users set [ssl_type] [ANY]
 select user,host,ssl_type from mysql.user; 

cat <<OUTPUT
+----------+-----------+----------+
| user     | host      | ssl_type |
+----------+-----------+----------+
| root     | localhost |          |
| buster   | localhost |          |
| debian   | %         | ANY      |
+----------+-----------+----------+
OUTPUT

 exit

#
## 	To connect from other Hosts, copy Certs on them and specify it to connect.
#

# install mariadb client
apt -y install mariadb-client

# copy certificates
scp debian@www.srv.world:/var/lib/mysql/pki/cert.pem /etc/mysql/
scp debian@www.srv.world:/var/lib/mysql/pki/priv.key /etc/mysql/

vi /etc/mysql/mariadb.conf.d/50-mysql-clients.cnf
cat <<EOT
[mysql]
# add follows into [mysql] section
ssl-cert=/etc/mysql/cert.pem
ssl-key=/etc/mysql/priv.key
EOT

# connect to mongodb from client using different user
mysql -h www.srv.world -u debian -p

# ssl_cipher value should be shown
 show status like 'ssl_cipher';
