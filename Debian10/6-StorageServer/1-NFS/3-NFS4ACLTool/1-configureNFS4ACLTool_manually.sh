# it's possible to set ACL on NFS(v4) filesystem to install NFS 4 ACL tool

# install NFS 4 ACL Tool on NFS clients that mounts NFS share with NFSv4
apt -y install nfs4-acl-tools

# configure on the environment like follows
df -hT /mnt

cat <<EOT
OUTPUT:
Filesystem                       Type  Size  Used Avail Use% Mounted on
dlp.srv.world:/var/lib/nfs/share nfs4   26G  1.1G   23G   5% /mnt
EOT

ll /mnt

cat <<EOT
OUTPUT:
total 8
drwxr-xr-x 2 root root 4096 Jul 16 19:37 testdir
-rw-r--r-- 1 root root   10 Jul 16 19:37 test.txt
EOT


# show ACL of a file or directory on NFSv4 filesystem
nfs4_getfacl /mnt/test.txt

nfs4_getfacl /mnt/testdir

cat <<EOT
NOTE:
# each entry means like follows
# ACE = Access Control Entry
# (ACE Type):(ACE Flags):(ACE Principal):(ACE Permissions)
EOT