# Enable Userdir for common users to open their site in the home directories.

#
## configure nginx
#

vi /etc/nginx/sites-available/default
cat <<EOT
# add into [server] section
        location ~ ^/~(.+?)(/.*)?$ {
            alias /home/$1/public_html$2;
            index  index.html index.htm;
            autoindex on;
        }
EOT

systemctl restart nginx

#
## Create a test page with a common user to make sure it works normally.
#

chmod 711 /home/debian
mkdir ~/public_html
chmod 755 ~/public_html

vi ~/public_html/index.html
cat <<EOT
<html>
<body>
<div style="width: 100%; font-size: 40px; font-weight: bold; text-align: center;">
Nginx UserDir Test Page
</div>
</body>
</html>
EOT

# navigate to www.srv.world/~debian/ with browser