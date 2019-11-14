# This is the Virtual Hostings setting for Nginx.
# For example, configure additional domainame [virtual.host].

#
## configure nginx
#

vi /etc/nginx/sites-available/virtual.host.conf
cat <<EOT
# create new
server {
    listen       80;
    server_name  www.virtual.host;

    location / {
        root   /var/www/virtual.host;
        index  index.html index.htm;
    }
}
EOT

mkdir /var/www/virtual.host
cd /etc/nginx/sites-enabled
ln -s /etc/nginx/sites-available/virtual.host.conf ./

systemctl restart nginx

#
## Create a test page to make sure it works normally.
#

vi /var/www/virtual.host/index.html
cat <<EOT
<html>
<body>
<div style="width: 100%; font-size: 40px; font-weight: bold; text-align: center;">
Nginx Virtual Host Test Page
</div>
</body>
</html>
EOT