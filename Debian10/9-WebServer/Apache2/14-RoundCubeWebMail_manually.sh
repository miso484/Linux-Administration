<<EXAMPLE
	
Install RoundCube to configure web-based mail transfer System. This example uses servers like follows for configuration of RoundCube.
+----------------------+          |          +----------------------+
|  [  www.srv.world  ] |10.0.0.31 | 10.0.0.32|  [ mail.srv.world  ] |
|     Apache httpd     +----------+----------+        Postfix       |
|      (Roundcube)     |                     |        Dovecot       |
|       MariaDB        |                     |                      |
+----------------------+                     +----------------------+

[1]	Install and Configure SMTP Server, refer to MailServer/1-installPostfix.
[2]	Install and Configure IMAP Server, refer to MailServer/2-installDovecot.
[3]	Install PHP on Apache2 Server, refer to WebServer/Apache2/3-usePHPScripts.
[4]	Configure SSL/TLS settings on Apache2 Server, refer to WebServer/Apache2/8-SSLAndTLSSetting.
[5]	Install and Configure MariaDB Server on httpd Server, refer to Database/MariaDB/1-installMariaDB.
EXAMPLE

#
## create a database ro RoundCube
#

mysql -u root -p

# create [roundcube] database (replace 'password' to your own password you'd like to set)
create database roundcube;

grant all privileges on roundcube.* to roundcube@'localhost' identified by 'password';
flush privileges;
exit

#
## install and configure RoundCube
#

apt -y install roundcube roundcube-mysql

<<SETUP
# select [No] on this example (set manually later)
 +----------------------+ Configuring roundcube-core +-----------------------+
 |                                                                           |
 | The roundcube package must have a database installed and configured       |
 | before it can be used.  This can be optionally handled with               |
 | dbconfig-common.                                                          |
 |                                                                           |
 | If you are an advanced database administrator and know that you want to   |
 | perform this configuration manually, or if your database has already      |
 | been installed and configured, you should refuse this option.  Details    |
 | on what needs to be done should most likely be provided in                |
 | /usr/share/doc/roundcube.                                                 |
 |                                                                           |
 | Otherwise, you should probably choose this option.                        |
 |                                                                           |
 | Configure database for roundcube with dbconfig-common?                    |
 |                                                                           |
 |                    <Yes>                       <No>                       |
 |                                                                           |
 +---------------------------------------------------------------------------+
SETUP

cd /usr/share/dbconfig-common/data/roundcube/install
mysql -u roundcube -D roundcube -p < mysql
# MariaDB roundcube password
cd

vi /etc/roundcube/debian-db.php
cat <<EOT
# set database info
$dbuser='roundcube';
$dbpass='password';
$basepath='';
$dbname='roundcube';
$dbserver='localhost';
$dbport='3306';
$dbtype='mysql';
EOT

vi /etc/roundcube/config.inc.php
cat <<EOT
# line 35: specify IMAP server (STARTTLS setting)
$config['default_host'] = 'tls://mail.srv.world';
# line 47: specify SMTP server (STARTTLS setting)
$config['smtp_server'] = 'tls://mail.srv.world';
# line 51: specify SMTP port (STARTTLS setting)
$config['smtp_port'] = 587;
# line 55: change (use the same user for SMTP auth and IMAP auth)
$config['smtp_user'] = '%u';
# line 59: change (use the same password for SMTP auth and IMAP auth)
$config['smtp_pass'] = '%p';
# line 66: change to any title you like
$config['product_name'] = 'Server World Webmail';
# add follows to the end
# specify IMAP port (STARTTLS setting)
$config['default_port'] = 143;

# specify SMTP auth type
$config['smtp_auth_type'] = 'LOGIN';

# specify SMTP HELO host
$config['smtp_helo_host'] = 'mail.srv.world';

# specify domain name
$config['mail_domain'] = 'srv.world';

# specify UserAgent
$config['useragent'] = 'Server World Webmail';

# specify SMTP and IMAP connection option
$config['imap_conn_options'] = array(
  'ssl'         => array(
    'verify_peer' => true,
    'CN_match' => 'srv.world',
    'allow_self_signed' => true,
    'ciphers' => 'HIGH:!SSLv2:!SSLv3',
  ),
);
$config['smtp_conn_options'] = array(
  'ssl'         => array(
    'verify_peer' => true,
    'CN_match' => 'srv.world',
    'allow_self_signed' => true,
    'ciphers' => 'HIGH:!SSLv2:!SSLv3',
  ),
);
EOT

vi /etc/apache2/conf-enabled/roundcube.conf
cat <<EOT
# line 3: uncomment
Alias /roundcube /var/lib/roundcube
# line 11: change access permission if need
Require ip 127.0.0.1 10.0.0.0/24
EOT

systemctl restart apache2

# Access to [https://(your server's hostname or IP address/)/roundcube/], then Roundcube login form is shown, authenticate with any user on Mail Server.
# After login, make sure it's possible to send or receive emails normally.
