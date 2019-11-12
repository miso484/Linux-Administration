# Enable CGI and Use Python Scripts on Apache2.

# install python
apt -y install python

# enable cgi module
a2enmod cgid
systemctl restart apache2

#
## After enabeling CGI, CGI scripts are allowed to execute under [/usr/lib/cgi-bin] directory by default. 
## Therefore, for example, if a Python script [index.cgi] is put under the directory, it's possible to access to the URL [http://(Apache2 Server)/cgi-bin/index.cgi] from Clients.
#

# create a test script
cat > /usr/lib/cgi-bin/test_script <<'EOF'
#!/usr/bin/env python
print "Content-type: text/html\n\n"
print "Hello CGI\n"
EOF

chmod 705 /usr/lib/cgi-bin/test_script

# try to access
curl http://localhost/cgi-bin/test_script

#
## If you'd like to allow CGI in other directories except default, configure like follows.
## For example, allow in [/var/www/html/cgi-enabled].
#

vi /etc/apache2/conf-available/cgi-enabled.conf

cat <<EOT
# create new
# processes [.cgi] and [.py] as CGI scripts
<Directory "/var/www/html/cgi-enabled">
    Options +ExecCGI
    AddHandler cgi-script .cgi .py
</Directory>
EOT

mkdir /var/www/html/cgi-enabled
a2enconf cgi-enabled
systemctl restart apache2

#
## Create a CGI test page and access to it from client PC with web browser
#

cat <<EOT > /var/www/html/cgi-enabled/index.py
print "Content-type: text/html\n\n"
print "<html>\n<body>"
print "<div style=\"width: 100%; font-size: 40px; font-weight: bold; text-align: center;\">"
print "Python Script Test Page"
print "</div>\n</body>\n</html>"
EOT

chmod 705 /var/www/html/cgi-enabled/index.py