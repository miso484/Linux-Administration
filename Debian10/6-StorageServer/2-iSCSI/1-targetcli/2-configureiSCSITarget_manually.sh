#  create an disk-image under the [/var/lib/iscsi_disks] directory and set it as a SCSI device

# create a directory
mkdir /var/lib/iscsi_disks

# enter the admin console
targetcli
cd backstores/fileio 

# create a disk-image with the name [disk01] on [/var/lib/iscsi_disks/disk01.img] with 10G
create disk01 /var/lib/iscsi_disks/disk01.img 10G

cd /iscsi 

# create a target
# naming rule : [iqn.(year)-(month).(reverse of domain name):(any name you like)]
create iqn.2019-07.world.srv:storage.target01 

cd iqn.2019-07.world.srv:storage.target01/tpg1/luns 

# set LUN
create /backstores/fileio/disk01 

cd ../acls 

# set ACL (it's the IQN of an initiator you permit to connect)
create iqn.2019-07.world.srv:www.srv.world 

cd iqn.2019-07.world.srv:www.srv.world 

# set UserID for authentication
set auth userid=username 

set auth password=password 

exit 

# after configuration above, the target enters in listening like follows
ss -napt | grep 3260