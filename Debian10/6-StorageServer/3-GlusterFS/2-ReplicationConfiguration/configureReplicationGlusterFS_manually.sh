#	It is recommended to use partitions for GlusterFS volumes which are different from the / partition.
# The environment on this example is set as that sdb1 is mounted on [/glusterfs] directory for GlusterFS Configuration on all Nodes.

# NOTE: install GlusterFS Server on All Nodes

# create a Directory for GlusterFS Volume on all Nodes
mkdir -p /glusterfs/replica

# configure Clustering like follows on a node. (it's OK on any node)

# probe the node
gluster peer probe node02
gluster peer probe node03

# show status
gluster peer status

# create volume
gluster volume create vol_replica replica 3 transport tcp \
node01:/glusterfs/replica \
node02:/glusterfs/replica \
node03:/glusterfs/replica

# start volume
gluster volume start vol_replica

# show volume info
gluster volume info

# to mount GlusterFS volume on clients, refer to configureGlusterFSClient.sh