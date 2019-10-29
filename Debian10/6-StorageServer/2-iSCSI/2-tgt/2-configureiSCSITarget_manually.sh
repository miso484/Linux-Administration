# create an disk-image under the [/var/lib/iscsi_disks] directory and set it as a SCSI device

# create a disk-image
mkdir /var/lib/iscsi_disks

dd if=/dev/zero of=/var/lib/iscsi_disks/disk01.img count=0 bs=1 seek=10G

cat <<EOT >> /etc/tgt/conf.d/target01.conf
# naming rule : [ iqn.(year)-(month).(reverse of domain name):(any name you like) ]
<target iqn.2019-07.world.srv:dlp.target01>
    # provided devicce as a iSCSI target
    backing-store /var/lib/iscsi_disks/disk01.img
    # iSCSI Initiator's IQN you allow to connect to this Target
    initiator-name iqn.2019-07.world.srv:www.srv.world
    # authentication info ( set any name you like for "username", "password" )
    incominguser username password
</target>
EOT

systemctl restart tgt

# show status
tgtadm --mode target --op show