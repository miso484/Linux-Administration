<<EXAMPLE
Configure SSL/TLS setting to use secure encrypt HTTPS connection.

Refer to: Certificates section
EXAMPLE

# configure apache2
vi /etc/apache2/sites-available/default-ssl.conf
cat <<EOT
# line 3: change admin email
ServerAdmin webmaster@srv.world

# line 32,33: change to the certs gotten in section [1]
SSLCertificateFile      /etc/letsencrypt/live/www.srv.world/cert.pem
SSLCertificateKeyFile   /etc/letsencrypt/live/www.srv.world/privkey.pem

# line 42: uncomment and change to the chain-file gotten in section [1]
SSLCertificateChainFile /etc/letsencrypt/live/www.srv.world/chain.pem
EOT

a2ensite default-ssl
a2enmod ssl

systemctl restart apache2

#
## If you'd like to set HTTP connection to redirect to HTTPS (Always on SSL/TLS), configure each Virtualhost like follows. It's also OK to set it in [.htaccess] not in httpd.conf.
#

vi /etc/apache2/sites-available/000-default.conf
cat <<EOT
<VirtualHost *:80>
    RewriteEngine On
    RewriteCond %{HTTPS} off
    RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [R=301,L]
EOT

a2enmod rewrite
systemctl restart apache2

#
## Verify to access to the test page from a client computer with a Web browser via HTTPS. If you set Always On SSL/TLS, access with HTTP to verify the connection is redirected to HTTPS normally, too.
#