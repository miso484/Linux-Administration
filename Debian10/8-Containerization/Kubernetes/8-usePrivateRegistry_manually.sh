<<Example
	
Use Docker Private Registry to pull Docker images from self Private Registry.
This example is based on the environment like follows.
-----------+---------------------------+--------------------------+------------
           |                           |                          |
       eth0|10.0.0.30              eth0|10.0.0.51             eth0|10.0.0.52
+----------+-----------+   +-----------+----------+   +-----------+----------+
|   [ dlp.srv.world ]  |   | [ node01.srv.world ] |   | [ node02.srv.world ] |
|      Master Node     |   |      Worker Node     |   |      Worker Node     |
+----------------------+   +----------------------+   +----------------------+

Example

# On the Node you'd like to run Private Registry Pod, Run Docker Registry with authentication (refer to 8-Containerization/Docker/7-useDockerRegistryAuth file)
# On this example, Registry Pod is runing on Master Node.

#
## Add Secret in Kubernetes.
#

# login to the Registry once
docker login dlp.srv.world:5000

# then following file is generated
ll ~/.docker/config.json

# BASE64 encode of the file
cat ~/.docker/config.json | base64

cat <<EOT > ~/regcred.yml
# specify contents of BASE64 encoding above with one line for [.dockerconfigjson] section
apiVersion: v1
kind: Secret
data:
  .dockerconfigjson: ewoJImF1dGhzIjogewoJ.....
metadata:
  name: regcred
type: kubernetes.io/dockerconfigjson
EOT

kubectl create -f regcred.yml
kubectl get secrets

#
## To pull images from self Private Registry, Specify private image and Secret when deploying pods like follows.
#

docker images dlp.srv.world:5000/nginx

cat <<EOT > ~/privat-nginx.yml
apiVersion: v1
kind: Pod
metadata:
  name: private-nginx
spec:
  containers:
  - name: private-nginx
    # image on Private Registry
    image: dlp.srv.world:5000/nginx
  imagePullSecrets:
  # Secret name you added
  - name: regcred
EOT

kubectl create -f private-nginx.yml
kubectl get pods
kubectl describe pods private-nginx