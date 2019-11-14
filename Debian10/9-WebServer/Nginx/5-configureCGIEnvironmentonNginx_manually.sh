# Configure CGI (Common Gate Interface) executable Environment on Nginx.

#
## Install FastCGI Wrap and Configure Nginx for it.
#

apt -y install fcgiwrap
cp /usr/share/doc/fcgiwrap/examples/nginx.conf /etc/nginx/fcgiwrap.conf
vi /etc/nginx/fcgiwrap.conf

cat <<EOT
location /cgi-bin/ {
  # Disable gzip (it makes scripts feel slower since they have to complete
  # before getting gzipped)
  gzip off;

  # Set the root to /usr/lib (inside this location this means that we are
  # giving access to the files under /usr/lib/cgi-bin)
  # change  <<====
  root  /var/www;

  # Fastcgi socket
  fastcgi_pass  unix:/var/run/fcgiwrap.socket;

  # Fastcgi parameters, include the standard ones
  include /etc/nginx/fastcgi_params;

  # Adjust non standard parameters (SCRIPT_FILENAME)
  # change  <<====
  fastcgi_param SCRIPT_FILENAME  $document_root$fastcgi_script_name;
}
EOT

mkdir /var/www/cgi-bin
chmod 755 /var/www/cgi-bin
vi /etc/nginx/sites-available/default
cat <<EOT
# add into the [server] section
server {
        .....
        .....
        include fcgiwrap.conf;
}
EOT
systemctl restart nginx

#
## Create a test scripts under the directory you set CGI executable (on this example, it's [var/www/cgi-bin]) abd Access to it to verify CGI works normally.
#

vi /var/www/cgi-bin/index.py
cat <<EOT
#!/usr/bin/env python

print "Content-type: text/html\n\n"
print "<html>\n<body>"
print "<div style=\"width: 100%; font-size: 40px; font-weight: bold; text-align: center;\">"
print "Python Script Test Page"
print "</div>\n</body>\n</html>"
EOT

chmod 705 /var/www/cgi-bin/index.py

# test on browser