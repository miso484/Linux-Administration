#
# Disable NFS feature in Gluster first.
# The NFS feature in Gluster is officially deprecated.
# Also if NFS server is running, stop and disable it, too.
#

# OK if [nfs.disable: on] (default setting)
gluster volume get vol_distributed nfs.disable

# if [nfs.disable: off], turn to disable
gluster volume set vol_distributed nfs.disable on

# if NFS server is running, disable it
systemctl stop nfs-server
systemctl disable nfs-server

#
# Install and Configure NFS-Ganesha on a Node in GlusterFS Cluster.
#

apt -y install nfs-ganesha-gluster

mv /etc/ganesha/ganesha.conf /etc/ganesha/ganesha.conf.org

vi /etc/ganesha/ganesha.conf
cat <<EOT
NFS_CORE_PARAM {
    # possible to mount with NFSv3 to NFSv4 Pseudo path
    mount_path_pseudo = true;
    # NFS protocol
    Protocols = 3,4;
}
EXPORT_DEFAULTS {
    # default access mode
    Access_Type = RW;
}
EXPORT {
    # uniq ID
    Export_Id = 101;
    # mount path of Gluster Volume
    Path = "/vol_distributed";
    FSAL {
    	# any name
        name = GLUSTER;
        # hostname or IP address of this Node
        hostname="10.0.0.51";
        # Gluster volume name
        volume="vol_distributed";
    }
    # setting for root Squash
    Squash="No_root_squash";
    # NFSv4 Pseudo path
    Pseudo="/vfs_distributed";
    # allowed security options
    SecType = "sys";
}
LOG {
    # default log level
    Default_Log_Level = WARN;
}
EOT

#
# Verify NFS mounting on a Client.
#

apt -y install nfs-common

# specify Pseudo path set on [Pseudo=***] in ganesha.conf
mount -t nfs4 node01.srv.world:/vfs_distributed /mnt

df -hT
