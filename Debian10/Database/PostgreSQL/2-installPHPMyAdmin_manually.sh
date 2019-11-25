# Install phpPgAdmin to operate PostgreSQL on web browser from Client computers.

#
## Install Apache httpd and PHP, refer to 9-WebServer/Apache2 section
#


#
## Install phpPgAdmin.
#

apt -y install phppgadmin php-pgsql

vi /etc/phppgadmin/config.inc.php
cat <<EOT
# line 93: change to false if you allow to login with priviledged user like postgres, root
$conf['extra_login_security'] = false;

# line 99: change (show only own databases)
$conf['owned_only'] = true;
EOT

vi /etc/postgresql/11/main/pg_hba.conf
cat <<EOT
# line 92: change like follows and add access permission
host    all             all             127.0.0.1/32            md5
host    all             all             10.0.0.0/24             md5
host    all             all             ::1/128                 md5
EOT

vi /etc/apache2/conf-enabled/phppgadmin.conf
cat <<EOT
# line 12: add access permission
Require local
Require ip 10.0.0.0/24
EOT

systemctl restart postgresql apache2

#
## Access to the [http://(hostname or IP address)/phppgadmin/] and click [PostgreSQL] on the left pane.
#

# Autenticate a user and password which is in PostgreSQL.
