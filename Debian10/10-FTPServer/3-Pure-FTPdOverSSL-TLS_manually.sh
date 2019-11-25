# Create self-signed certificates. but if you use valid certificates like from Let's Encrypt or others, you don't need to create this one.
cd /etc/ssl/private
openssl req -x509 -nodes -newkey rsa:2048 -keyout pure-ftpd.pem -out pure-ftpd.pem -days 365
# Country Name (2 letter code) [AU]: JP
# State or Province Name (full name) [Some-State]: Hiroshima
# Locality Name (eg, city) []: Hiroshima
# coOrganization Name (eg, company) [Internet Widgits Pty Ltd]: GTS
# Organizational Unit Name (eg, section) []: Server World
# Common Name (e.g. server FQDN or YOUR name) []: www.srv.world
# Email Address []: root@srv.world
chmod 600 pure-ftpd.pem

#
## Configure Pure-FTPd.
#

echo "2" > /etc/pure-ftpd/conf/TLS
systemctl restart pure-ftpd


#
## Client - Debian
#

# Install FTP Client on Debian and configure like follows.
vi ~/.lftprc
cat <<EOT
# create new
set ftp:ssl-auth TLS
set ftp:ssl-force true
set ftp:ssl-protect-list yes
set ftp:ssl-protect-data yes
set ftp:ssl-protect-fxp yes
set ssl:verify-certificate no
EOT

# connect
lftp -u debian www.srv.world

#
## Client - Windows
#

# For example of FileZilla on Windows,
# Open [File] - [Site Manager].

# Input connection infomation like follows, and for encryption field, select [Require explicit FTP over TLS].
#Protocol: FTP
#Host: www.srv.world
#Encryption: Require explicit FTP over TLS
#Logon type: ask for password
#User: debian

# User's Password is required. Input it.

# If you set self-signed certificate, warning is shown, it's no ploblem. Go next.

# Just connected with FTPS.
