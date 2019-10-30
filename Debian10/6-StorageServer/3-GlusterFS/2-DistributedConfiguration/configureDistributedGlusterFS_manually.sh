#	It is recommended to use partitions for GlusterFS volumes which are different from the / partition.
# The environment on this example is set as that sdb1 is mounted on [/glusterfs] directory for GlusterFS Configuration on all Nodes.

# NOTE: install GlusterFS Server on All Nodes

# create a Directory for GlusterFS Volume on all Nodes
mkdir -p /glusterfs/distributed

#
# configure Clustering like follows on a node. (it's OK on any node)
#

# probe the node
gluster peer probe node02

# show status
gluster peer status

# create volume
gluster volume create vol_distributed transport tcp \
node01:/glusterfs/distributed \
node02:/glusterfs/distributed

# start volume
gluster volume start vol_distributed

# show volume info
gluster volume info

# to mount GlusterFS volume on clients, refer to configureGlusterFSClient.sh