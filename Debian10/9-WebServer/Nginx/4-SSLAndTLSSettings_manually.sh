# Enable SSL/TLS setting to use SSL connection.

# Get SSL certificates, refer to Certificates section.

#
## configure nginx
#
vi /etc/nginx/sites-available/default
cat <<EOT
# add to the end
# replace the path of certificates to your own one
server {
        listen 443 ssl default_server;
        listen [::]:443 ssl default_server;

        ssl_prefer_server_ciphers  on;
        ssl_ciphers  'ECDH !aNULL !eNULL !SSLv2 !SSLv3';
        ssl_certificate  /etc/letsencrypt/live/www.srv.world/fullchain.pem;
        ssl_certificate_key  /etc/letsencrypt/live/www.srv.world/privkey.pem;

        root /var/www/html;
        server_name www.srv.world;
        location / {
                try_files $uri $uri/ =404;
        }
}
EOT

systemctl restart nginx

#
## If you'd like to set HTTP connection to redirect to HTTPS (Always on SSL/TLS), configure like follows.
#

vi /etc/nginx/sites-available/default
cat <<EOT
# add into the section of listening 80 port
server {
        listen 80 default_server;
        listen [::]:80 default_server;
        return 301 https://$host$request_uri;
EOT

systemctl restart nginx

# Verify to access to the test page from a client computer with a Web browser via HTTPS. If you set Always On SSL/TLS, access with HTTP to verify the connection is redirected to HTTPS normally, too.