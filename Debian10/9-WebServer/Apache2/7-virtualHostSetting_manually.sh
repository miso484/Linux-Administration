<<EXAMPLE
Configure Virtual Hostings to use maltiple domain names.

The example below is set on the environment which the domain name is [srv.world], virtual domain name is [virtual.host (root directory [/home/ubuntu/public_html])].

It's necessarry to set Userdir settings for this example, too.
EXAMPLE

# configure apache2
vi /etc/apache2/sites-available/virtual.host.conf
cat <<EOT
# create new for [virtual.host]
<VirtualHost *:80>
    ServerName www.virtual.host
    ServerAdmin webmaster@virtual.host
    DocumentRoot /home/debian/public_html
    ErrorLog /var/log/apache2/virtual.host.error.log
    CustomLog /var/log/apache2/virtual.host.access.log combined
    LogLevel warn
</VirtualHost>
EOT

a2ensite virtual.host
systemctl restart apache2

#
## Create a test page and access to it from a client computer with a web browser
#

mkdir ~/public_html
cat <<EOT > ~/public_html/index.html
<html>
<body>
<div style="width: 100%; font-size: 40px; font-weight: bold; text-align: center;">
Virtual Host Test Page
</div>
</body>
</html>
EOT