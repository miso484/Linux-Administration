<<EXAMPLE
Limit accesses on specific web pages and use OS users for authentication with SSL connection.

Configure SSL/TLS Setting, refer to Certificates section.

For example, set Basic Authentication under the [/var/www/html/auth-pam] directory.
EXAMPLE


apt -y install libapache2-mod-authnz-external pwauth

vi /etc/apache2/sites-available/auth-pam.conf
cat <<EOT
# create new
AddExternalAuth pwauth /usr/sbin/pwauth
SetExternalAuthMethod pwauth pipe
<Directory /var/www/html/auth-pam>
    SSLRequireSSL
    AuthType Basic
    AuthName "PAM Authentication"
    AuthBasicProvider external
    AuthExternal pwauth
    require valid-user
</Directory>
EOT

mkdir /var/www/html/auth-pam
a2ensite auth-pam
systemctl restart apache2

# create a test page
cat <<EOT > /var/www/html/auth-pam/index.html
<html>
<body>
<div style="width: 100%; font-size: 40px; font-weight: bold; text-align: center;">
Test Page for PAM Auth
</div>
</body>
</html>
EOT

# Access to the test page with a Web browser on Client Computer and authenticate with a user which is on OS.