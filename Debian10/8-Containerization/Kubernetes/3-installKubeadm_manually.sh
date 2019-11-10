<< Example
Install Kubeadm to Configure Multi Nodes Kubernetes Cluster.
On this example, Configure This example is based on the emvironment like follows.

For System requirements, each Node has uniq Hostname, MAC address, Product_uuid.
MAC address and Product_uuid are generally already uniq one if you installed OS on phisical machine or virtual machine with common procedure. 
You can see Product_uuid with the command [dmidecode -s system-uuid].

-----------+---------------------------+--------------------------+------------
           |                           |                          |
       eth0|10.0.0.30              eth0|10.0.0.51             eth0|10.0.0.52
+----------+-----------+   +-----------+----------+   +-----------+----------+
|   [ dlp.srv.world ]  |   | [ node01.srv.world ] |   | [ node02.srv.world ] |
|      Master Node     |   |      Worker Node     |   |      Worker Node     |
+----------------------+   +----------------------+   +----------------------+
Example

#
## Install and Run Docker service on All Nodes (refer to installDocker)
#

#
## Change some settings on All Nodes for System requirements.
#

# For IPTables, Kubernetes v1.15 has not supported IPTables version 1.8 yet now (Aug 2019 now), so switch to IPTables Legacy on Debian 10.
swapoff -a

vi /etc/fstab
cat <<EOT
# comment out for swap line
#/dev/mapper/ubuntu--vg-swap_1 none swap sw 0 0
EOT

update-alternatives --config iptables
# select IPTables Legacy (number 1)

cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

systemctl restart docker

#
## 	Install Kubeadm on All Nodes
#

apt -y install apt-transport-https gnupg2 curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
apt update
apt -y install kubeadm kubelet kubectl

# only enabling, do not run yet
systemctl enable kubelet