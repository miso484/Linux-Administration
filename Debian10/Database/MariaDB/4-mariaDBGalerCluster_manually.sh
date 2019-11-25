<<EXAMPLE
Configure MariaDB Galera Cluster.
All nodes in cluster become Master-Server in this configuration.
EXAMPLE

#
## Install MariaDB on all nodes
#

# refer to 1-installAndConfigureMariaDB_manually file

#
## Configure a 1st node like follows.
#

vi /etc/mysql/mariadb.conf.d/50-server.cnf
cat <<EOT
# line 28: comment out
#bind-address = 127.0.0.1

# add to the end
[galera]
wsrep_on=ON
wsrep_provider=/usr/lib/galera/libgalera_smm.so
wsrep_cluster_address=gcomm://
binlog_format=row
default_storage_engine=InnoDB
innodb_autoinc_lock_mode=2
bind-address=0.0.0.0
# any cluster name
wsrep_cluster_name="MariaDB_Cluster"
# own IP address
wsrep_node_address="10.0.0.31"
EOT
galera_new_cluster
systemctl restart mariadb

#
## Configure other nodes except a 1st node.
#

vi /etc/mysql/mariadb.conf.d/50-server.cnf
cat <<EOT
# line 28: comment out
#bind-address = 127.0.0.1
# add to the end
[galera]
wsrep_on=ON
wsrep_provider=/usr/lib/galera/libgalera_smm.so
# specify all nodes in cluster
wsrep_cluster_address="gcomm://10.0.0.31,10.0.0.51"
binlog_format=row
default_storage_engine=InnoDB
innodb_autoinc_lock_mode=2
bind-address=0.0.0.0
# any cluster name
wsrep_cluster_name="MariaDB_Cluster"
# own IP address
wsrep_node_address="10.0.0.51"
EOT
systemctl restart mariadb

#
## The Cluster settings is OK, Make sute the status like follows. It's OK if [wsrep_local_state_comment] is [Synced].
#

# connect
mysql -u root -p

 show status like 'wsrep_%'; 
 