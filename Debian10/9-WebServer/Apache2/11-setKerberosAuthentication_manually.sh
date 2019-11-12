<<EXAMPLE
Limit accesses on specific web pages and use Windows Active Directory users for authentication with SSL/TLS connection.

It's necessarry to be running Windows Active Directory in your LAN.

This example based on the environment below.
Domain Server	: Windows Server 2019
NetBIOS Name	: FD3S01
Domain Name	: srv.world
Realm	: SRV.WORLD
Hostname	: fd3s.srv.world

Configure SSL/TLS Setting, refer to Certificates section.

For example, set Basic Authentication under the [/var/www/html/auth-kerberos] directory
EXAMPLE

apt -y install libapache2-mod-auth-kerb
cat <<INSTALATION
# specify Realm
 +------------------+ Configuring Kerberos Authentication +------------------+
 | When users attempt to use Kerberos and specify a principal or user name   |
 | without specifying what administrative Kerberos realm that principal      |
 | belongs to, the system appends the default realm.  The default realm may  |
 | also be used as the realm of a Kerberos service running on the local      |
 | machine.  Often, the default realm is the uppercase version of the local  |
 | DNS domain.                                                               |
 |                                                                           |
 | Default Kerberos version 5 realm:                                         |
 |                                                                           |
 | SRV.WORLD________________________________________________________________ |
 |                                                                           |
 |                                  <Ok>                                     |
 |                                                                           |
 +---------------------------------------------------------------------------+
# specify Active Directory's hostname
 +------------------+ Configuring Kerberos Authentication +------------------+
 | Enter the hostnames of Kerberos servers in the FD3S.SRV.WORLD Kerberos    |
 | realm separated by spaces.                                                |
 |                                                                           |
 | Kerberos servers for your realm:                                          |
 |                                                                           |
 | fd3s.srv.world___________________________________________________________ |
 |                                                                           |
 |                                  <Ok>                                     |
 |                                                                           |
 +---------------------------------------------------------------------------+
 
# specify Active Directory's hostname
 +------------------+ Configuring Kerberos Authentication +------------------+
 | Enter the hostname of the administrative (password changing) server for   |
 | the FD3S.SRV.WORLD Kerberos realm.                                        |
 |                                                                           |
 | Administrative server for your Kerberos realm:                            |
 |                                                                           |
 | fd3s.srv.world___________________________________________________________ |
 |                                                                           |
 |                                  <Ok>                                     |
 |                                                                           |
 +---------------------------------------------------------------------------+
INSTALATION

# create keytab HTTP/[AD's hostname or IP address]@[Realm name]
echo "HTTP/fd3s.srv.world@SRV.WORLD" > /etc/krb5.keytab

vi /etc/apache2/sites-available/auth-kerberos.conf
cat <<EOT
# create new
<Directory /var/www/html/auth-kerberos>
    SSLRequireSSL
    AuthType Kerberos
    AuthName "Kerberos Authntication"
    KrbAuthRealms SRV.WORLD
    Krb5Keytab /etc/krb5.keytab
    KrbMethodNegotiate Off
    KrbSaveCredentials Off
    KrbVerifyKDC Off
    Require valid-user
</Directory>
EOT

mkdir /var/www/html/auth-kerberos
a2ensite auth-kerberos
systemctl restart apache2

# create a test page
cat <<EOT > /var/www/html/auth-kerberos/index.html
<html>
<body>
<div style="width: 100%; font-size: 40px; font-weight: bold; text-align: center;">
Test Page for Kerberos Auth
</div>
</body>
</html>
EOT

# 	Access to the test page from a client computer with web browser. Then authentication is required.