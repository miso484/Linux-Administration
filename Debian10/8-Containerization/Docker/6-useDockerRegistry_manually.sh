# Install Docker-Registry to build Private Registry for Docker images.

# On The Host which Docker-Registry Container runs, Get SSL Certificates.

# This example is based on the case that SSL certificates are gotten under the [/etc/letsencrypt/live/dlp.srv.world] and set the [Common Name] as [dlp.srv.world].

#
# Copy to locate Certificates and pull Registry Image (v2).
# Container Images are located under [/var/lib/regstry] on Registry v2 Container, so map to mount [/var/lib/docker/registry] on parent Host for Registry Container to use as Persistent Storage.
#

mkdir -p /etc/docker/certs.d/dlp.srv.world:5000
cp -p /etc/letsencrypt/live/dlp.srv.world/cert.pem /etc/docker/certs.d/dlp.srv.world:5000/ca.crt

docker pull registry:2
mkdir /var/lib/docker/registry

docker run -d -p 5000:5000 \
-e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/fullchain.pem \
-e REGISTRY_HTTP_TLS_KEY=/certs/privkey.pem \
-v /etc/letsencrypt/live/dlp.srv.world:/certs \
-v /var/lib/docker/registry:/var/lib/registry \
registry:2

docker ps 

#
## For pushing local Image to Registry Container server, set like follows.
#

# list images on Registry container
curl https://dlp.srv.world:5000/v2/_catalog

docker images

# set a tag and push
docker tag debian dlp.srv.world:5000/debian_reg
docker push dlp.srv.world:5000/debian_reg

docker images

curl https://dlp.srv.world:5000/v2/_catalog

#
## For getting images from Registry Container server on a Docker node, set like follows.
#

# get certificates from Registry Container
mkdir -p /etc/docker/certs.d/dlp.srv.world:5000
cd /etc/docker/certs.d/dlp.srv.world:5000
scp debian@dlp.srv.world:"/etc/docker/certs.d/dlp.srv.world:5000/ca.crt" ./

docker pull dlp.srv.world:5000/debian_reg

docker images
