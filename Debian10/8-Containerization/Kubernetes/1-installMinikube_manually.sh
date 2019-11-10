# Configure Kubernetes which is Docker Container Orchestration System.
# On this exmaple, Install Minikube to configure Single Node Cluster within a Virtual machine.

# Because using VM, Install a Hypervisor which is supported by Minikube.
# On this example, Install KVM.
# For other Hypervisors, it's possible to use VirtualBox, VMware Fusion, HyperKit.
apt -y install qemu-kvm libvirt-daemon libvirt-daemon-system virtinst bridge-utils

# Configure Kubernetes repository and Install Minikube.
apt -y install apt-transport-https gnupg2 curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
apt update
apt -y install kubectl
wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 -O minikube
wget https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-kvm2
chmod 755 minikube docker-machine-driver-kvm2
mv minikube docker-machine-driver-kvm2 /usr/local/bin/

# verify
minikube version
kubectl version -o json

# start minikube
minikube start --vm-driver kvm2

# show status
minikube status

minikube service list
minikube docker-env
kubectl cluster-info
kubectl get nodes

# a VM [minikube] is just running
virsh list

# possible to access with SSH to the VM
minikube ssh
 hostname
 docker ps
 exit

# to stop minikube, do like follows
minikube stop

# to remove minikube, do like follows
minikube delete

virsh list --all