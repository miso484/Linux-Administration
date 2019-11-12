# Install PHP-FPM (FPM : FastCGI Process Manager) to make PHP scripts be fast.

# install php first (refer to 3-usePHPScripts file)

# install php-fpm
apt -y install php-fpm

#
## Add Settings in Virtualhost you'd like to set PHP-FPM.
#

vi /etc/apache2/sites-available/default-ssl.conf
cat <<EOT 
# add into <VirtualHost> - </VirtualHost>
    <FilesMatch \.php$>
        SetHandler "proxy:unix:/var/run/php/php7.3-fpm.sock|fcgi://localhost/"
    </FilesMatch>
</VirtualHost>
EOT

a2enmod proxy_fcgi setenvif
a2enconf php7.3-fpm
systemctl restart php7.3-fpm apache2

#
## Create [phpinfo] in Virtualhost's web-root you set PHP-FPM and access to it with web browser.
## https://www.srv.world/info.php
#

echo '<?php phpinfo(); ?>' > /var/www/html/info.php
