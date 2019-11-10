# When Container is removed, data in it are also lost, so it's necessary to use external filesystem in Container as persistent storage if you need.

#
## For exmaple, create a Container only for using to save data as a storage server with an image busybox.
#

# create new
cat <<EOT >> ~/Dockerfile
FROM busybox

VOLUME /storage
CMD /bin/sh
EOT

# build image
docker build -t storage ./

docker images

# generate a Container with any name you like
docker run -it --name storage_server storage
exit

#
## To use the Container above as a Storage Server from other Containers, add an option [--volumes-from].
#

docker run -it --name debian_server --volumes-from storage_server debian /bin/bash
df -hT
echo "persistent storage" >> /storage/testfile.txt
ls -l /storage

#
## 	Make sure datas are saved to run a Container of Storage Server like follows.
#

docker start storage_server
docker exec -it storage_server cat /storage/testfile.txt

#
## For other way to save data in external filesystem, it's possible to mount a directory on Docker Host into Containers
#

# create a directory
mkdir -p /var/lib/docker/disk01
echo "persistent storage" >> /var/lib/docker/disk01/testfile.txt

# run a Container with mounting the directory above on /mnt
docker run -it -v /var/lib/docker/disk01:/mnt debian /bin/bash

df -hT

cat /mnt/testfile.txt