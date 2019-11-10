# On this example, create it to install Debian 10.

# create a directory for VM
mkdir /var/vbox

# create a VM
VBoxManage createvm \
--name Debian_10 \
--ostype Debian_64 \
--register \
--basefolder /var/vbox

# modify settings for VM
# replace the interface name [ens2] to your environment
VBoxManage modifyvm Debian_10 \
--cpus 4 \
--memory 4096 \
--nic1 bridged \
--bridgeadapter1 ens2 \
--boot1 dvd \
--vrde on \
--vrdeport 5001

# configure storage for VM
VBoxManage storagectl Debian_10 --name "Debian_10_SATA" --add sata

VBoxManage createhd \
--filename /var/vbox/Debian_10/Debian_10.vdi \
--size 20480 \
--format VDI \
--variant Standard

VBoxManage storageattach Debian_10 \
--storagectl Debian_10_SATA \
--port 1 \
--type hdd \
--medium /var/vbox/Debian_10/Debian_10.vdi

# configure DVD drive for VM
# the example below specifies an ISO file for installation
VBoxManage storageattach Debian_10 \
--storagectl Debian_10_SATA \
--port 0 \
--type dvddrive \
--medium /tmp/debian-10.0.0-amd64-DVD-1.iso

# confirm settings for VM
VBoxManage showvminfo Debian_10

# start Virtual Machine
VBoxManage startvm Debian_10 --type headless

