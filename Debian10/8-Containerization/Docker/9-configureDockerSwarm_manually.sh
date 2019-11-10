<<Example
Configure Docker Swarm to create Docker Cluster with multiple Docker nodes.
On this example, Configure Swarm Cluster with 3 Docker nodes like follows.
There are 2 roles on Swarm Cluster, those are [Manager nodes] and [Worker nodes
This example shows to set those roles like follows.
 -----------+---------------------------+--------------------------+------------
            |                           |                          |
        eth0|10.0.0.51              eth0|10.0.0.52             eth0|10.0.0.53
 +----------+-----------+   +-----------+----------+   +-----------+----------+
 | [ node01.srv.world ] |   | [ node02.srv.world ] |   | [ node03.srv.world ] |
 |       Manager        |   |        Worker        |   |        Worker        |
 +----------------------+   +----------------------+   +----------------------+
Example

#
## Install and run Docker service on all nodes
#

#
## 	Configure Swarm Cluster on Manager Node.
#
docker swarm init

<< 'output'
Swarm initialized: current node (al73w42dwnui659iyomjcekds) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-19qm6ypn0d25pwisgcsjak9m31mwesutrl9448q7l92oe2izwb-8z3dk7xs19tuc1rxf9a2ix4tu 10.0.0.51:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.
output


#
##  Join in Swarm Cluster on all Worker Nodes.
#

# It's OK to run the command which was shown when running swarm init on Manager Node.
docker swarm join \
--token SWMTKN-1-19qm6ypn0d25pwisgcsjak9m31mwesutrl9448q7l92oe2izwb-8z3dk7xs19tuc1rxf9a2ix4tu 10.0.0.51:2377

# Verify with a command [node ls] that worker nodes could join in Cluster normally.
docker node ls

#
## After creating Swarm Cluster, next, configure services that the Swarm Cluster provides.
#

# Create the same container image on all Nodes for the service first.
# On this exmaple, create a Container image which provides http service like follows on all Nodes.

cat <<EOT >> ~/Dockerfile
FROM debian
MAINTAINER ServerWorld <admin@srv.world>

RUN apt-get update
RUN apt-get -y install apache2
RUN echo "node01" > /var/www/html/index.html

EXPOSE 80
CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
EOT

docker build -t apache2_server:latest ./

#
##  Configure service on Manager Node.
#

# After successing to configure service, access to the Manager node's Hostname or IP address to verify it works normally. 
# By the way, requests to worker nodes are load-balanced with round-robin like follows.
docker images

# create a service with 2 repricas
docker service create --name swarm_cluster --replicas=2 -p 80:80 apache2_server:latest

# show service list
docker service ls

# inspect the service
docker service inspect swarm_cluster --pretty

# show service state
docker service ps swarm_cluster

# verify it works normally (it load balances between node01 and node02)
curl http://node01.srv.world
curl http://node01.srv.world
curl http://node01.srv.world
curl http://node01.srv.world

#
## If you'd like to change the number of repricas, configure like follows
#

# change repricas to 3
docker service scale swarm_cluster=3
docker service ps swarm_cluster

# verify working (it load balances between three nodes)
curl http://node01.srv.world
curl http://node01.srv.world
curl http://node01.srv.world