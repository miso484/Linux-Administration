<<EXAMPLE
This is the example to configure WebDAV with SSL connection.

Configure SSL/TLS Setting, refer to Certificates section.

For example, Create a directory [webdav] and it makes possible to connect to WebDAV directory only by SSL/TLS.
EXAMPLE

apt -y install apache2-utils
mkdir /home/webdav
chown www-data. /home/webdav
chmod 770 /home/webdav

vi /etc/apache2/sites-available/webdav.conf
cat <<EOT
Alias /webdav /home/webdav
<Location /webdav>
    DAV On
    SSLRequireSSL
    Options None
    AuthType Basic
    AuthName WebDAV
    AuthUserFile /etc/apache2/.htpasswd
    <RequireAny>
        Require method GET POST OPTIONS
        Require valid-user
    </RequireAny>
</Location>
EOT

a2enmod dav*
a2ensite webdav
systemctl restart apache2

# add a user : create a new file with "-c" ("-c" is needed only for the initial registration)
htpasswd -c /etc/apache2/.htpasswd debian

#
## Configure WebDAV client on client computer. This example is on Windows 10.
#

# Open [PC] and move to [Computer] tab and Click [Add a network location] icon.
# Click [Next] button.
# Click [Next] button.
# Input the URL of WebDav folder.
# Authentication is required, input username and password you added by htpasswd.
# Input WebDav Folder Name. Any name is OK, it's used on your Windows Computer.
# Click [Finish] button.
# Just accessed to WebDav Folder.