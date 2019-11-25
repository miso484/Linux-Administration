# Install MariaDB to configure database server.

# install mariadb
apt -y install mariadb-server

# initial settings
mysql_secure_installation
# set root password
#y
# remove anonymous users
#y
# disallow root login remotely
#y
# remove test database
#y
# reload privilege tables
#y

# connect to MariaDB with root (enter password)
mysql -u root -p

# show user list
  select user,host,password from mysql.user;

# show database list
  show databases;

# logout
  exit