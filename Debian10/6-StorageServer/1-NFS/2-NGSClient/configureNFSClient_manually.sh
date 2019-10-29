# Configure NFS Client. On this example, Mount [/home] directory from NFS server.

# install nfs client
apt -y install nfs-common

# configure nfs client
vi /etc/idmapd.conf

cat <<EOT
EXAMPLE:
# line 6: uncomment and change to your domain name
Domain = srv.world
EOT

# mount
mount -t nfs dlp.srv.world:/home /home

# if you'd like to mount with NFSv3, add '-o vers=3' option
#mount -t nfs -o vers=3 dlp.srv.world:/home /home

# test that /homt from nfs server is mounted
df -hT


# configure NFS mounting on fstab to mount it when the system boot
echo "dlp.srv.world:/home   /home  nfs     defaults        0       0" >> /etc/fstab