# Configure iSCSI Initiator

apt -y install open-iscsi parted

vi /etc/iscsi/initiatorname.iscsi
cat <<EOT
# change to the same IQN you set on the iSCSI target server
InitiatorName=iqn.2019-07.world.srv:www.srv.world
EOT

vi /etc/iscsi/iscsid.conf
cat <<EOT
# line 56: uncomment
node.session.auth.authmethod = CHAP
# line 60,61: uncomment and specify the username and password you set on the iSCSI target
node.session.auth.username = username
node.session.auth.password = password
EOT

systemctl restart iscsid open-iscsi

# discover target
iscsiadm -m discovery -t sendtargets -p 10.0.0.30

# confirm status after discovery
iscsiadm -m node -o show

# login to the target
iscsiadm -m node --login

# confirm the established session
iscsiadm -m session -o show

# confirm the partitions
cat /proc/partitions
# added new device provided from the target server as [sdb]

# create label
parted --script /dev/sdb "mklabel gpt"

# create partiton
parted --script /dev/sdb "mkpart primary 0% 100%"

# format with ext4
mkfs.ext4 /dev/sdb1

mount /dev/sdb1 /mnt
df -hT