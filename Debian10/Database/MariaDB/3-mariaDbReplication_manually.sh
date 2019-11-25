<<EXAMPLE
Configure MariaDB Replication settings. This configuration is general Master-Slave setting.
EXAMPLE

#
## Change settings and create a user for replication on MariaDB Matser Host.
#

# configure
vi /etc/mysql/mariadb.conf.d/50-server.cnf
cat <<EOT
# line 28: change to IP of this host
bind-address = 10.0.0.31

# line 73: uncomment and change to any another ID
server-id = 101

# line 74: uncomment
log_bin = /var/log/mysql/mysql-bin.log
EOT

# restart
systemctl restart mariadb

# connect
mysql -u root -p

# create user (set any password for 'password' section)
 grant replication slave on *.* to replica@'%' identified by 'password';
 flush privileges;
 exit

#
## Install and start MariaDB Server on Slave Host
#

# Refer to 1-installAndConfigureMariaDB_manually file

#
## Change settings on Slave Host.
#

vi /etc/mysql/mariadb.conf.d/50-server.cnf
cat <<EOT
# line 28: change to IP of this host
bind-address = 10.0.0.51

# line 73: uncomment and change to another ID(different one from Master Host)
server-id = 102

# line 74: uncomment
log_bin = /var/log/mysql/mysql-bin.log

# line 79: add
# read only
read_only=1
# define own hostname
report-host=node01.srv.world
EOT

systemctl restart mariadb

#
## Get Dump-Data on Master Host.
#

# connect
mysql -u root -p

# lock all tables
 flush tables with read lock; 

# show status (remember File, Position value)
 show master status; 


# remain the window above and open the another window and execute dump
mysqldump -u root -p --all-databases --lock-all-tables --events > mysql_dump.sql 


# back to the remained window and unlock
 unlock tables; 
 exit

# transfer the dump to Slave Host
scp mysql_dump.sql debian@node01.srv.world:/tmp/

#
## 	Configure replication settings on Slave Host.
## It's OK all, make sure the settings work normally to create databases on Master Host.
#

# import dump from Master Host
mysql -u root -p < /tmp/mysql_dump.sql

# connect
mysql -u root -p

 change master to 
    -> master_host='10.0.0.31',       # Master Hosts's IP
    -> master_user='replica',         # replication ID
    -> master_password='password',    # replication ID's password
    -> master_log_file='mysql-bin.000001',   # File value confirmed on Master
    -> master_log_pos=640;            # Position value confirmed on Master

# start replication
 start slave;

# show status
 show slave status\G 