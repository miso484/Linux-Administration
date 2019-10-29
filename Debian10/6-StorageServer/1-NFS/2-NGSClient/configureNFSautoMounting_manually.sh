# Configure auto-mounting if you need. For example, set NFS directory on /mntdir

apt -y install autofs

vi /etc/auto.master

cat <<EOT
EXAMPLE:
# add to the end
/-    /etc/auto.mount
EOT

vi /etc/auto.mount

cat <<EOT
EXAMPLE:
# create new : [mount point] [option] [location]
/mntdir -fstype=nfs,rw  dlp.srv.world:/home
EOT

mkdir /mntdir
systemctl restart autofs

# move to the mount point to verify it works normally
cd /mntdir
ll
cat /proc/mounts | grep mntdir