# 	Use Dockerfile and create Docker images automatically.
#   It is also useful for configuration management.

# For example, Create a Dockerfile to install apache2 and sshd and also install Supervisor to control multiple services on a Container

cd ~

# create new
cat <<EOT > ~/Dockerfile
FROM debian
MAINTAINER ServerWorld <admin@srv.world>

RUN apt-get update
RUN apt-get -y install openssh-server apache2 supervisor
RUN echo "Hello DockerFile World" > /var/www/html/index.html
RUN mkdir /var/run/sshd; chmod 755 /var/run/sshd
RUN mkdir /root/.ssh; chown root. /root/.ssh; chmod 700 /root/.ssh
RUN ssh-keygen -A

ADD supervisord.conf /etc/supervisor/supervisord.conf
ADD .ssh/id_rsa.pub /root/.ssh/authorized_keys

EXPOSE 22 80
CMD ["/usr/bin/supervisord"]
EOT

# create a Supervisor template
cat <<EOT >> ~/supervisord.conf
[supervisord]
nodaemon=true

[program:sshd]
command=/usr/sbin/sshd -D
autostart=true
autorestart=true

[program:apache2]
command=/usr/sbin/apachectl -D FOREGROUND
autostart=true
autorestart=true
EOT

# generate SSH key
ssh-keygen -q -N "" -f /root/.ssh/id_rsa

# build image ⇒ docker build -t [image name]:[tag] ./
docker build -t web_server:latest ./

docker images

# run Container on background
docker run -d -p 2022:22 -p 8081:80 web_server

docker ps

# verify accesses
curl localhost:8081
ssh -p 2022 localhost /bin/hostname
