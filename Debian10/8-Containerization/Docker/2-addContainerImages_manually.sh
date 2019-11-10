# For exmaple, update official image with installing Apache2 and add it as a new image for container. The container is generated every time for executing docker run command, so add the latest executed container like follows

# show images
docker images

# start a Container and install apache2
docker run debian /bin/bash -c "apt-get update; apt-get -y install apache2"

docker ps -a | head -2

# add the image
docker commit f273ecfea032 srv.world/debian_apache2

docker images

# Generate a Container from the new image and execute [which] to make sure httpd exists
docker run srv.world/debian_apache2 /usr/bin/which apache2