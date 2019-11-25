# Configure Client computer to connect to FTP Server. The example below is for Debian.

#
## install ftp client
#

apt -y install lftp

#
## The connection with root account is prohibited by default, so access with a common user to FTP Server.
#

# lftp [option] [hostname]
lftp -u debian www.srv.world

# show current directory on FTP server
  pwd

<<OUTPUT
ftp://debian@www.srv.world
OUTPUT

# show current directory on local server
  !pwd

<<OUTPUT
/home/debian
OUTPUT

# show files in current directory on FTP server
  ls

# show files in current directory on local server
  !ls -l

# change directory
  cd public_html
  pwd

# upload a file to FTP server
# "-a" means ascii mode ( default is binary mode )
  put -a debian.txt test.txt
  ls

# upload some files to FTP server
  mput -a test.txt test2.txt
  ls

# download a file from FTP server
# "-a" means ascii mode ( default is binary mode )
  get -a test.py

# download some files from FTP server
  mget -a test.txt test2.txt

# create a directory in current directory on FTP Server
  mkdir testdir
  ls

# delete a directory in current directory on FTP Server
  rmdir testdir
  ls

# delete a file in current directory on FTP Server
  rm test2.txt
  ls

# delete some files in current directory on FTP Server
  mrm debian.txt test.txt
  ls

# execute commands with ![command]
  !cat /etc/passwd

# exit
quit
