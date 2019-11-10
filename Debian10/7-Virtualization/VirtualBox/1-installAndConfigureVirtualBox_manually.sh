# install required packages
LINUX_HEADERS=$(uname -r)
apt -y install gcc make linux-headers-$LINUX_HEADERS dkms

# install VirtualBox 6.0
cat <<EOT >> /etc/apt/sources.list
deb https://download.virtualbox.org/virtualbox/debian buster contrib
EOT
wget https://www.virtualbox.org/download/oracle_vbox_2016.asc
apt-key add oracle_vbox_2016.asc
apt update
apt -y install virtualbox-6.0
VBoxManage -v

# confirm installed version
dpkg -l virtualbox-6.0

# download and install the same version of extension pack to use VRDP (Virtual Remote Desktop Protocol)
wget http://download.virtualbox.org/virtualbox/6.0.10/Oracle_VM_VirtualBox_Extension_Pack-6.0.10.vbox-extpack
VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-6.0.10.vbox-extpack

# confirm
VBoxManage list extpacks

#	On enabling VRDP environment, it's possible to connect with RDP. The example below is on Windows 10.
#   Connect to [(VirtualBox Server's Hostname or IP address):(vrdeport set for the VM)].