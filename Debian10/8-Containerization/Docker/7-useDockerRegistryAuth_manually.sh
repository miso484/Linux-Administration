# Configure Docker Private Registry which requires user authentication.

#	
## On the Node which you run Registry Pod, get SSL certificates (refer to Certificates section)
#

# Install htpasswd command for adding users.
apt -y install apache2-utils

# Add any user you like.
htpasswd -Bc /etc/docker/.htpasswd admin

# On this example, certificates are saved under [/etc/letsencrypt/live/(FQDN)] on Registry Node.
# Run Registry Pod with htpasswd file created above and certificates.
mkdir /etc/docker/certs.d
cp /etc/letsencrypt/live/dlp.srv.world/fullchain.pem /etc/docker/certs.d/server.crt
cp /etc/letsencrypt/live/dlp.srv.world/privkey.pem /etc/docker/certs.d/server.key

docker run -d -p 5000:5000 --restart=always --name registry \
-v /var/lib/registry:/var/lib/registry \
-v /etc/docker/certs.d:/certs \
-v /etc/docker:/auth \
-e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/server.crt \
-e REGISTRY_HTTP_TLS_KEY=/certs/server.key \
-e REGISTRY_AUTH=htpasswd \
-e REGISTRY_AUTH_HTPASSWD_PATH=/auth/.htpasswd \
-e REGISTRY_AUTH_HTPASSWD_REALM="Registry Realm" \
registry:2 

docker ps

# That's OK to configure registry. Try to Push/Pull images from your Private Registry on any Docker nodes.
# login with a user you added
docker login dlp.srv.world:5000
#Username: admin
docker images
docker tag nginx dlp.srv.world:5000/nginx
docker push dlp.srv.world:5000/nginx
docker images