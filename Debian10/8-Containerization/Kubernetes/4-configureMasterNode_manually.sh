<< Example
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

Configure Master Node on this section.
Example

#
## First, install Kubeadm and apply common settings (refer to 1-installKubeadm file)
#

#
## Configure initial setup on Master Node.
#

# For [--apiserver-advertise-address] option, specify the IP address Kubernetes API server listens.
# For [--pod-network-cidr] option, specify network which Pod Network uses.
# There are some plugins for Pod Network. (refer to details below)
# ⇒ https://kubernetes.io/docs/concepts/cluster-administration/networking/

# On this example, select Flannel. For Flannel, specify [--pod-network-cidr=10.244.0.0/16] to let Pod Network work normally.
kubeadm init --apiserver-advertise-address=10.0.0.30 --pod-network-cidr=10.244.0.0/16

# the command below is necessary to run on Worker Node when he joins to the cluster, so remember it
<< remember
kubeadm join 10.0.0.30:6443 --token uw8h1x.4vjex3g6tfgt4w2t \
    --discovery-token-ca-cert-hash sha256:99c192dcb2b38438c4aacc5029b86447f18f2b93a0fe0fa7a779192bc952fb53
remember

# set cluster admin user
# if you set common user as cluster admin, login with it and run [sudo cp/chown ***]
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

#
## Configure Pod Network with Flannel.
#

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# show state (OK if STATUS = Ready)
kubectl get nodes

# show state (OK if all are Running)
kubectl get pods --all-namespaces
