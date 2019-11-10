# If you'd like to access to services like HTTP or SSH which is running in Containers as a daemon, Configure like follows

# start the Container and also run Apache2
# map the port of Host and the port of Container with [-p xxx:xxx]
docker run -t -d -p 8081:80 srv.world/debian_apache2 /usr/sbin/apachectl -D FOREGROUND

docker ps

# create a test page
docker exec a59a297105ac /bin/bash -c 'echo "Apache2 on Docker Container" > /var/www/html/index.html'

# verify it works normally
curl localhost:8081