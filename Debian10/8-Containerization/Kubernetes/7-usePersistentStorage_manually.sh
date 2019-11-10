<<Example
	
Use Persistent Storage in Kubernetes Cluster.
This example is based on the environment like follows.
For example, run NFS Server on Master Node and configure Pods can use NFS area as external storage.
-----------+---------------------------+--------------------------+------------
           |                           |                          |
       eth0|10.0.0.30              eth0|10.0.0.51             eth0|10.0.0.52
+----------+-----------+   +-----------+----------+   +-----------+----------+
|   [ dlp.srv.world ]  |   | [ node01.srv.world ] |   | [ node02.srv.world ] |
|      Master Node     |   |      Worker Node     |   |      Worker Node     |
|       NFS Server     |   |                      |   |                      |
+----------------------+   +----------------------+   +----------------------+

Example

#
## First, Run NFS Server on Master Node (refer to 6-StorageServer/1-NFS)
#

# On this example, configure [/var/lib/nfs-share] directory as NFS shared directory.

#
## Then, Install NFS Client on all Worker Nodes  (refer to 6-StorageServer/1-NFS)
#

#
## 	Define PV (Persistent Volume) object and PVC (Persistent Volume Claim) object on Master Node.
#

# create PV definition
cat <<EOT > ~/nfs-pv.yml
apiVersion: v1
kind: PersistentVolume
metadata:
  # any PV name
  name: nfs-pv
spec:
  capacity:
    # storage size
    storage: 10Gi
  accessModes:
    # ReadWriteMany (RW from multi nodes), ReadWriteOnce (RW from a node), ReadOnlyMany (R from multi nodes)
    - ReadWriteMany
  persistentVolumeReclaimPolicy:
    # retain even if pods terminate
    Retain
  nfs:
    # NFS server's definition
    path: /var/lib/nfs-share
    server: 10.0.0.30
    readOnly: false
EOT

kubectl create -f nfs-pv.yml
kubectl get pv

# create PVC definition
cat <<EOT > ~/nfs-pvc.yml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  # any PVC name
  name: nfs-pvc
spec:
  accessModes:
  # ReadWriteMany (RW from multi nodes), ReadWriteOnce (RW from a node), ReadOnlyMany (R from multi nodes)
  - ReadWriteMany
  resources:
     requests:
       # storage size to use
       storage: 1Gi
EOT

kubectl create -f nfs-pvc.yml
kubectl get pvc

#
## Create a Pod with PVC above.
#

cat <<EOT > ~/nginx-nfs.yml
apiVersion: v1
kind: Pod
metadata:
  # any Pod name
  name: nginx-nfs
  labels:
    name: nginx-nfs
spec:
  containers:
    - name: nginx-nfs
      image: nginx
      ports:
        - name: web
          containerPort: 80
      volumeMounts:
        - name: nfs-share
          # mount point in container
          mountPath: /usr/share/nginx/html
  volumes:
    - name: nfs-share
      persistentVolumeClaim:
        # PVC name you created
        claimName: nfs-pvc
EOT

kubectl create -f nginx-nfs.yml

# create a test file under the NFS shared directory
echo 'NFS Persistent Storage Test' > /var/lib/nfs-share/index.html

kubectl get pods -o wide
#IP: 10.244.2.4 

# verify accesses
curl 10.244.2.4