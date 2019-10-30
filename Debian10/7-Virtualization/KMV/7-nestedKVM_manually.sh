# It's possible to install KVM Hypervisor and create virtual machines as nested KVM on KVM host.

#
## Enable the setting for Nested KVM.
#

# show the current setting ( if the result is [Y], it's OK )
cat /sys/module/kvm_intel/parameters/nested

# if the result is [N], change like follows and reboot the system )
echo 'options kvm_intel nested=1' >> /etc/modprobe.d/qemu-system-x86.conf

#
## Edit the configuration of an existing virtual machine you'd like to set Nested like follows.
#

# that's OK, it's possible to create virtual machine on GuestOS

# edit VM [debian]
virsh edit debian

# change cpu mode like follows
#<cpu mode='host-passthrough'>