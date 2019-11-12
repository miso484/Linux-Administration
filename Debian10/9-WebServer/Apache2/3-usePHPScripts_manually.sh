# Configure Apache2 to use PHP scripts.
#
## install php
#

apt -y install php php-cgi libapache2-mod-php php-common php-pear php-mbstring

#
## configure apache2
#

a2enconf php7.3-cgi

vi /etc/php/7.3/apache2/php.ini
cat <<EOT
# line 960: uncomment and add your timezone
date.timezone = "Asia/Tokyo"
EOT

systemctl restart apache2

#
## Create a PHP test page and access to it from client PC with web browser. It's OK if following page is shown.
#

cat <<EOT > /var/www/html/index.php
<html>
<body>
<div style="width: 100%; font-size: 40px; font-weight: bold; text-align: center;">
<?php
    print "PHP Test Page";
?>
</div>
</body>
</html>
EOT

# Navigate to www.srv.world/index.php to test