# Install ProFTPD to configure FTP server to transfer files.

#install ProFTPD
apt -y install proftpd

vi /etc/proftpd/proftpd.conf
cat <<EOT
# line 11: turn off if not need IPv6
UseIPv6 off

# line 15: change to your hostname
ServerName "www.srv.world"

# line 36: uncomment ( specify root directory for chroot )
DefaultRoot ~
EOT

vi /etc/ftpusers
cat <<EOT
# add users you prohibit FTP connection
test
EOT

systemctl restart proftpd