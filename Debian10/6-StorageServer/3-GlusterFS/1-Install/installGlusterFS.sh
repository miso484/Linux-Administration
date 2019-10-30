apt -y install glusterfs-server

systemctl start glusterd
systemctl enable glusterd

gluster --version