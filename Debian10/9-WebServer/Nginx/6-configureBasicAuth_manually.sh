# Enable Basic Authentication to restrict access on specific web pages.

# For example, set Basic Auth under the [/auth-basic] directory.

vi /etc/nginx/sites-available/default
cat <<EOT
# add into the [server] section
        location /auth-basic/ {
            auth_basic            "Basic Auth";
            auth_basic_user_file  "/etc/nginx/.htpasswd";
        }
EOT

mkdir /var/www/html/auth-basic
systemctl restart nginx

# add user for Basic authentication
htpasswd -c /etc/nginx/.htpasswd debian
# set password

# 	Access to the test page with Web browser from any Client and authenticate with a user which is added with htpasswd.