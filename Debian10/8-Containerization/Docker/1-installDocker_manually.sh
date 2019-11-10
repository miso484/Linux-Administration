# Install Docker which is the Operating System-Level Virtualization Tool, which automates the deployment of applications inside Containers.

# install Docker
apt -y install docker.io

# download the image
docker pull debian

# run echo inside Container
docker run debian /bin/echo "Welcome to the Docker World!"

#
## connect to the interactive session of a Container with [i] and [t] option like follows. If exit from the Container session, the process of a Container finishes
#

docker run -it debian /bin/bash
  # Container's console
  uname -a
  exit
# come back

#
## if exit from the Container session with keeping container's process, push [Ctrl+p] and [Ctrl+q] key
#

docker run -it debian /bin/bash
  # Ctrl+p, Ctrl+q

# show docker process
docker ps 

# connect to container's session
docker attach 155deb48bfb8

# shutdown container's process from Host's console
docker kill 155deb48bfb8

docker ps

