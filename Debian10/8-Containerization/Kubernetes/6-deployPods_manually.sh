<<Example
This example is based on the environment like follows.
-----------+---------------------------+--------------------------+------------
           |                           |                          |
       eth0|10.0.0.30              eth0|10.0.0.51             eth0|10.0.0.52
+----------+-----------+   +-----------+----------+   +-----------+----------+
|   [ dlp.srv.world ]  |   | [ node01.srv.world ] |   | [ node02.srv.world ] |
|      Master Node     |   |      Worker Node     |   |      Worker Node     |
+----------------------+   +----------------------+   +----------------------+
Example

#
## Create or Delete Pods.
#

# run [test-nginx] pods
kubectl create deployment test-nginx --image=nginx
kubectl get pods

# scale out pods
kubectl scale deployment test-nginx --replicas=3
kubectl get pods -o wide

# set service
kubectl expose deployment test-nginx --port 80

kubectl describe service test-nginx
#IP: 10.106.0.125

# verify accesses
curl 10.106.0.125