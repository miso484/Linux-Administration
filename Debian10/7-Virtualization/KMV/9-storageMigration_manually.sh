#
# Configure 2 KVM Host Servers and Create a Virtual Machine on a KVM Host.
# 2 KVM Host Servers need to be resolv hostname or IP address each other via DNS or local hosts file.
#

#
# Show the file size of a Virtual Machine image on a KVM host, and move to another KVM Host, then create a empty disk image that is the same size of Virtual Machine.
#

# show the size of Virtual machine
ll /var/kvm/images

### on another KVM host ###
# create a disk which is the same size of a Virtual Machine
qemu-img create -f qcow2 /var/kvm/images/debian.img 21478375424
ll /var/kvm/images

#
## Execute Storage Migration
#

virsh list

virsh migrate --live --copy-storage-all debian qemu+ssh://10.0.0.52/system

virsh list
# VM is just migrated

### on another KVM host ###
virsh list

# back to another host, run Live migration with unsafe option
virsh migrate --live --unsafe debian qemu+ssh://10.0.0.51/system
virsh list