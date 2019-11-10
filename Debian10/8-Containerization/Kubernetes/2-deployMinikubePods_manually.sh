#
## Create or Delete Pods.
#

# run 2 [test-nginx] pods
kubectl create deployment test-nginx --image=nginx
kubectl get pods

#pod name is test-nginx-76b4548894-gbtdd

# show environment variable for [test-nginx] pod
kubectl exec test-nginx-76b4548894-gbtdd env

# shell access to [test-nginx] pod
kubectl exec -it test-nginx-76b4548894-gbtdd bash
 hostname
 exit

# show logs of [test-nginx] pod
kubectl logs test-nginx-76b4548894-gbtdd

# scale out pods
kubectl scale deployment test-nginx --replicas=3
kubectl get pods

# set service
kubectl expose deployment test-nginx --type="NodePort" --port 80
kubectl get services test-nginx

# verify
minikube service test-nginx --url
<< output
* http://192.168.41.223:31941
output
curl http://192.168.41.223:31941

# delete service
kubectl delete services test-nginx

# delete pods
kubectl delete deployment test-nginx