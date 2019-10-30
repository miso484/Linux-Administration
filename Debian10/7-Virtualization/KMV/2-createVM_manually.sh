# Install GuestOS on text mode via network, it's OK on Console or remote connection with Putty and so on. 
#Furthermore, Virtual Machine's images are placed at [/var/lib/libvirt/images] by default as a Storage Pool, 
#but this example shows to create and use a new Storage Pool.

# create a storage pool
mkdir -p /var/kvm/images

virt-install \
--name debian \
--ram 4096 \
--disk path=/var/kvm/images/debian.img,size=20 \
--vcpus 2 \
--os-type linux \
--os-variant debian9 \
--network bridge=br0 \
--graphics none \
--console pty,target_type=serial \
--location 'http://ftp.jaist.ac.jp/pub/Linux/debian/dists/buster/main/installer-amd64/' \
--extra-args 'console=ttyS0,115200n8 serial'
# installation starts


#
## Move between HostOS and GuestOS
# 

# Move to GuestOS to HostOS with Ctrl + ] key.
# Ctrl + ] key
#>> HostOS console

# Move to HostOS to GuestOS with a command [virsh console (name of virtual machine)]
# switch to [debian] VM console
virsh console debian
#>> GuestOS console

#
## Create another VM to copy from current VM
#

virt-clone --original debian --name debian_template --file /var/kvm/images/debian_template.img
ll /var/kvm/images/debian_template.img
ll /etc/libvirt/qemu/debian_template.xml