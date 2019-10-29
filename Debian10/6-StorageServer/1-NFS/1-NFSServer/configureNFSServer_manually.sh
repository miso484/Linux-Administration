# Install and Configure NFS Server. On this example, Configure [/home] directory as NFS Share.

# install
apt -y install nfs-kernel-server

vi /etc/idmapd.conf

cat <<EOT
EXAMPLE:
# line 6: uncomment and change to your domain name
Domain = srv.world
EOT


vi /etc/exports

cat <<EOT
EXAMPLE:
# write settings for NFS exports
/home 10.0.0.0/24(rw,no_root_squash)
EOT

systemctl restart nfs-server