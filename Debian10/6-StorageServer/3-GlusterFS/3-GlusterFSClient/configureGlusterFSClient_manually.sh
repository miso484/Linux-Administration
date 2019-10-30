# configure Clients to mount GlusterFS Volumes with GlusterFS Native.

# install GlusterFS Client and mount GlusterFS Volumes like follows.
# For example, mount [vol_distributed] volume to [/mnt].

apt -y install glusterfs-client

# OK to specify any Nodes in Cluster
mount -t glusterfs node01.srv.world:/vol_distributed /mnt

df -hT