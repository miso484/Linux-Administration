# Install PHP-FPM ( PHP FastCGI Process Manager ) to use PHP scripts on Nginx.

# PHP and PHP-FPM
apt -y install php php-fpm php-common php-pear php-mbstring

# configure Nginx for PHP-FPM
vi /etc/nginx/sites-available/default
cat <<EOT
# add into [server] section
        location ~ \.php$ {
               include snippets/fastcgi-php.conf;
               fastcgi_pass unix:/run/php/php7.3-fpm.sock;
        }
EOT

# create [PHPInfo] in Virtualhost's web-root you set PHP-FPM and access to it, then it's OK if [FPM/FastCGI] is displayed
echo "<?php phpinfo() ?>" > /var/www/html/info.php

# browse https://www.srv.world/info.php