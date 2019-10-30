#
## Install useful tools for virtual machine management.
#

# Install required packages
apt -y install libguestfs-tools virt-top

#
## Get official OS image and Create a Virtual Machine
#

# display available OS template
virt-builder -l

# create an image of Debian 9
virt-builder debian-9 --format qcow2 --size 10G -o debian-9.qcow2 --root-password password

# to configure VM with the image above, run virt-install
virt-install \
--name debian-9 \
--ram 4096 \
--disk path=/var/kvm/images/debian-9.qcow2 \
--vcpus 2 \
--os-type linux \
--os-variant debian9 \
--network bridge=br0 \
--graphics none \
--serial pty \
--console pty \
--boot hd \
--noreboot \
--import

#
## Interact with VM
#

# [ls] a directory in a virtual machine
virt-ls -l -d debian /root

# [cat] a file in a virtual machine
virt-cat -d debian /etc/passwd

# edit a file in a virtual machine
virt-edit -d debian /etc/fstab

# display disk usage in a virtual machine
virt-df -d debian

# mount a disk for a virtual machine
guestmount -d debian -i /mnt
ll /mnt

# display the status of virtual machines
virt-top