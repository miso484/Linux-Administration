#
# Configure Storage server which has virtual machine images.
# For Storage server, it's OK to use NFS, iSCSI, GlusterFS and so on.
# This example uses NFS Storage server.
#

#
# Configure 2 KVM host servers and mount a directory provided from Storage server on the same mount point on both KVM server.
# This example mounts on [/var/kvm/images].
# And also, 2 servers need to be resolv hostname or IP address each other via DNS or local hosts file.
#

#
# Set SSH key-pair for root account because SSH is used between 2 KVM servers.
#

#
# Create a Virtual Machine on a KVM Host and migrate it to another KVM Host like follows.
#

# edit settings of VM you'd like to migrate
virsh edit debian
cat <<EOT
<disk type='file' device='disk'>
      # add: sepcify disk cache mode [none]     <===
      <driver name='qemu' type='qcow2' cache='none'/>
      <source file='/var/kvm/images/debian.img'/>
EOT

virsh start debian
virsh list

# migrate
virsh migrate --live debian qemu+ssh://10.0.0.52/system

virsh list
# VM is just migrated to another Host


### on another KVM Host ###
virsh list


# back to the KVM Host again like follows
virsh migrate --live debian qemu+ssh://10.0.0.51/system

virsh list