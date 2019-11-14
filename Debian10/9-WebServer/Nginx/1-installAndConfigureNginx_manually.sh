# Install fast HTTP Server [Nginx] and configure HTTP/Proxy Server with it.

# install nginx
apt -y install nginx

# configure nginx
vi /etc/nginx/sites-available/default
cat <<EOT
# line 46: change to your hostname
server_name www.srv.world;
EOT

systemctl restart nginx

# access to the default page of Nginx from a Client with Web browser