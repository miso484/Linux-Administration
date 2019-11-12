# Enable userdir, users can create websites with this setting.

# configure apache2
a2enmod userdir
systemctl restart apache2

# Create a test page with a common user and access to it from client PC with web browser
mkdir ~/public_html
cat <<EOT > ~/public_html/index.html
<html>
<body>
<div style="width: 100%; font-size: 40px; font-weight: bold; text-align: center;">
UserDir Test Page
</div>
</body>
</html>
EOT