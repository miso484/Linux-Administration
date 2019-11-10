<<Example
Install Kubeadm to Configure Multi Nodes Kubernetes Cluster.
On this example, Configure This example is based on the emvironment like follows.
For System requirements, each Node has uniq Hostname, MAC address, Product_uuid.
MAC address and Product_uuid are generally already uniq one if you installed OS on phisical machine or virtual machine with common procedure. You can see Product_uuid with the command [dmidecode -s system-uuid].
-----------+---------------------------+--------------------------+------------
           |                           |                          |
       eth0|10.0.0.30              eth0|10.0.0.51             eth0|10.0.0.52
+----------+-----------+   +-----------+----------+   +-----------+----------+
|   [ dlp.srv.world ]  |   | [ node01.srv.world ] |   | [ node02.srv.world ] |
|      Master Node     |   |      Worker Node     |   |      Worker Node     |
+----------------------+   +----------------------+   +----------------------+

 	
Configure Worker Node on this section.
Example

#
## First, install Kubeadm and apply common settings (refer to 1-installKubeadm file)
#

#
## Join in Kubernetes Cluster which is initialized on Master Node.
#

# The command for joining is just the one [kubeadm join ***] which was shown on the bottom of the results on initial setup of Cluster.

# load modules
modprobe ip_vs
modprobe ip_vs_rr
modprobe ip_vs_wrr
modprobe ip_vs_sh

cat <<EOT >> /etc/modules
# Modules - add to the end
ip_vs
ip_vs_rr
ip_vs_wrr
ip_vs_sh
EOT

kubeadm join 10.0.0.30:6443 --token uw8h1x.4vjex3g6tfgt4w2t \
--discovery-token-ca-cert-hash sha256:99c192dcb2b38438c4aacc5029b86447f18f2b93a0fe0fa7a779192bc952fb53
# OK if [This node has joined the cluster]

# 
## 	Verify Status on Master Node. It's Ok if all STATUS are Ready.
#
kubectl get nodes
