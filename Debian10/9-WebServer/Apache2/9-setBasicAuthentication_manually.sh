# Set Basic Authentication to limit access on specific web pages.

# For example, set Basic Authentication setting under the directory [/var/www/html/auth-basic].
apt -y install apache2-utils

vi /etc/apache2/sites-available/auth-basic.conf
cat <<EOT
# create new
<Directory /var/www/html/auth-basic>
    AuthType Basic
    AuthName "Basic Authentication"
    AuthUserFile /etc/apache2/.htpasswd
    require valid-user
</Directory>
EOT

# add a user : create a new file with "-c" ("-c" is needed only for the initial registration)
htpasswd -c /etc/apache2/.htpasswd debian
# set password

mkdir /var/www/html/auth-basic
a2ensite auth-basic
systemctl restart apache2

# create a test page
vi /var/www/html/auth-basic/index.html
cat <<EOT
<html>
<body>
<div style="width: 100%; font-size: 40px; font-weight: bold; text-align: center;">
Test Page for Basic Auth
</div>
</body>
</html>
EOT

# 	Access to the test page from a client computer with a web browser. Then authentication is required.