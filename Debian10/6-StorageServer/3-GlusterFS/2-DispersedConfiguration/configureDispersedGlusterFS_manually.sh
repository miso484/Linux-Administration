#	It is recommended to use partitions for GlusterFS volumes which are different from the / partition.
# The environment on this example is set as that sdb1 is mounted on [/glusterfs] directory for GlusterFS Configuration on all Nodes.

# NOTE: install GlusterFS Server on All Nodes

# create a Directory for GlusterFS Volume on all Nodes
mkdir -p /glusterfs/dispersed

#
# configure Clustering like follows on a node. (it's OK on any node)
#

# probe the node
gluster peer probe node02
gluster peer probe node03
gluster peer probe node04
gluster peer probe node05
gluster peer probe node06

# show status
gluster peer status

# create volume
gluster volume create vol_dispersed disperse-data 4 redundancy 2 transport tcp \
node01:/glusterfs/dispersed \
node02:/glusterfs/dispersed \
node03:/glusterfs/dispersed \
node04:/glusterfs/dispersed \
node05:/glusterfs/dispersed \
node06:/glusterfs/dispersed

# start volume
gluster volume start vol_dispersed

# show volume info
gluster volume info

# to mount GlusterFS volume on clients, refer to configureGlusterFSClient.sh