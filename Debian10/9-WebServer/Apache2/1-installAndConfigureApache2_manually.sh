# Install Apache2 to Configure HTTP Server. HTTP uses 80/TCP.

# install Apache2
apt -y install apache2

# configure Apache2
vi /etc/apache2/conf-enabled/security.conf
cat <<EOT
# line 25: change
ServerTokens Prod
EOT

vi /etc/apache2/mods-enabled/dir.conf
cat <<EOT
# line 2: add file name that it can access only with directory's name
DirectoryIndex index.html index.htm
EOT

vi /etc/apache2/apache2.conf
cat <<EOT
# line 70: add server name
ServerName www.srv.world
EOT

vi /etc/apache2/sites-enabled/000-default.conf
cat <<EOT
# line 11: change to admin's email
ServerAdmin webmaster@srv.world
EOT

systemctl restart apache2

# 	Access to [http://(your server's hostname or IP address)/] with web browser.