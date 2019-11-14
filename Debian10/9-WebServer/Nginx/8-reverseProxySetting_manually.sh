# Configure Nginx as a Reverse Proxy Server.

# For example, Configure Nginx like that HTTP accesses to [www.srv.world] are forwarded to [dlp.srv.world].
vi /etc/nginx/sites-available/default
cat <<EOT
# change like follows in [server] section
    server {
        listen      80 default_server;
        listen      [::]:80 default_server;
        server_name www.srv.world;

        proxy_redirect           off;
        proxy_set_header         X-Real-IP $remote_addr;
        proxy_set_header         X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header         Host $http_host;

        location / {
            proxy_pass http://dlp.srv.world/;
        }
    }
EOT

systemctl restart nginx

# set log_format on Backend Nginx Server to log X-Forwarded-For header
vi /etc/nginx/nginx.conf
cat <<EOT
# add into [http] section
http {
        log_format main '$remote_addr - $remote_user [$time_local] "$request" '
                        '$status $body_bytes_sent "$http_referer" '
                        '"$http_user_agent" "$http_x_forwarded_for"';
EOT

vi /etc/nginx/sites-available/default
cat <<EOT
# add into [server] section
# specify your local network for [set_real_ip_from]
server {
        listen 80 default_server;
        listen [::]:80 default_server;
        set_real_ip_from   10.0.0.0/24;
        real_ip_header     X-Forwarded-For;
EOT

systemctl restart nginx

# Verify it works fine to access to frontend Nginx from any Client Host with HTTP.