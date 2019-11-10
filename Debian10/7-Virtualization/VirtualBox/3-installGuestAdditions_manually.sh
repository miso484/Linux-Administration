# Install GuestAdditions into a Virtual Machine to improve Virtual Machine's System Performance.
# The example below is to install GuestAdditions on a Virtual Machine [Debian_10].

#
## Attach GuestAdditions' disk to the VM on VirtualBox Host
## The target VM must be stopped
#

VBoxManage storageattach Debian_10 \
--storagectl Debian_10_SATA \
--port 0 \
--type dvddrive \
--medium /usr/share/virtualbox/VBoxGuestAdditions.iso

#
## Start the VM and login to it, then Install GuestAdditions on it
#

# install required package first
LINUX_HEADERS=$(uname -r)
apt -y install gcc make bzip2 linux-headers-$LINUX_HEADERS

mount /dev/cdrom /mnt
cd /mnt
./VBoxLinuxAdditions.run
reboot

# After installing GuestAdditions, System Performance will be improved
