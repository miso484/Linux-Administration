# Get SSL Certificates from Let's Encrypt who provides Free SSL Certificates.

# Refer to the details for Let's Encrypt official site below.
# ⇒ https://letsencrypt.org/

# By the way, expiration date of a cert is 90 days, so you must update within next 90 days later.

#
## Install Certbot Client which is the tool to get certificates from Let's Encrypt.
#
apt -y install certbot

#
## 	Get certificates.
#

# It needs Web server like Apache httpd or Nginx must be runing on the server you work.
# If no Web server is running, skip this section and Refer to the next one
# Furthermore, it needs that it's possible to access from the Internet to your working server on port 80 because of verification from Let's Encrypt.

# for the option [--webroot], use a directory under the webroot on your server as a working temp
# -w [document root] -d [FQDN you'd like to get certs]
# FQDN (Fully Qualified Domain Name) : Hostname.Domainname

# if you'd like to get certs for more than 2 FQDNs, specify all like below
# ex : if get [srv.world] and [www.srv.world]
# ⇒ -d srv.world -d dlp.srv.world
certbot certonly --webroot -w /var/www/html -d srv.world

# for only initial using, register your email address and agree to terms of use
# specify valid email address: root@mail.srv.world 

# agree to the terms of use

# success if [Congratulations] is shown
# certs are created under the [/etc/letsencrypt/live/(FQDN)/] directory

# cert.pem       ⇒ SSL Server cert(includes public-key)
# chain.pem      ⇒ intermediate certificate
# fullchain.pem  ⇒ combined file cert.pem and chain.pem
# privkey.pem    ⇒ private-key file

#
## 	If no Web Server is running on your working server
#

#  it's possbile to get certs with using Certbot's Web Server feature. Anyway, it needs that it's possible to access from the Internet to your working server on port 80 because of verification from Let's Encrypt.

# for the option [--standalone], use Certbot's Web Server feature
# -d [FQDN you'd like to get certs]
# FQDN (Fully Qualified Domain Name) : Hostname.Domainname
certbot certonly --standalone -d dlp.srv.world

#
## 	For Updating existing certs, Do like follows.
#


# update all certs which has less than 30 days expiration
# if you'd like to update certs which has more than 30 days expiration, add [--force-renew] option
certbot renew
