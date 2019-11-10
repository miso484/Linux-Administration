# To Install Docker Compose, it's easy to configure and run multiple containers as a Docker application.

# install docker compose
apt -y install docker-compose

cat <<EOT >> ~/Dockerfile
FROM debian

RUN apt-get update
RUN apt-get -y install apache2

EXPOSE 80
CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
EOT

# define application configration
cat <<EOT >> ~/docker-compose.yml
version: '3'
services:
  db:
    image: mariadb
    volumes:
      - /var/lib/docker/disk01:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: password
      MYSQL_USER: buster
      MYSQL_PASSWORD: password
      MYSQL_DATABASE: buster_db
    ports:
      - "3306:3306"
  web:
    build: .
    ports:
      - "80:80"
    volumes:
      - /var/lib/docker/disk02:/var/www/html
EOT

# build and run
docker-compose up -d

docker ps

# verify accesses
mysql -h 127.0.0.1 -u root -p -e "show variables like 'hostname';"
mysql -h 127.0.0.1 -u buster -p -e "show databases;"

echo "Hello Docker Compose World" > /var/lib/docker/disk02/index.html
curl 127.0.0.1

# verify state of containers
docker-compose ps

# show logs of containers
docker-compose logs

# run any commands inside a container
# container name is just the one set in [docker-compose.yml]
docker-compose exec db /bin/bash

# stop application and also shutdown all containers
docker-compose stop

# start a service alone in application
# if set dependency, other container starts
docker-compose up -d web
docker-compose ps

# remove all containers in application
# if a container is running, it won't be removed
docker-compose rm