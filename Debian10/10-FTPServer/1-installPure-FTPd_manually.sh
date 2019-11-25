# Install Pure-FTPd to configure FTP server to transfer files.

# install Pure-FTPd
apt -y install pure-ftpd

# run as a daemon
echo "yes" > /etc/pure-ftpd/conf/Daemonize

# prohibit Anonymous
echo "yes" > /etc/pure-ftpd/conf/NoAnonymous

# enable chroot
echo "yes" > /etc/pure-ftpd/conf/ChrootEveryone

# only IPV4 if not need IPv6
echo "yes" > /etc/pure-ftpd/conf/IPV4Only

systemctl restart pure-ftpd
