# SYNTAX: scp [Option] Source Target

read -p "Linux SSH User: " LINUX_USER
read -p "Linux SSH Server IP: " LINUX_IP

cd ~
touch ~/test.txt

# copy the [test.txt] on local to remote server [LINUX_IP]
scp ./test.txt "$LINUX_USER@$LINUX_IP":~/

# copy the [/home/<$LINUX_USER>/test.txt] on remote server [LINUX_IP] to the local
scp "$LINUX_USER@$LINUX_IP":"/home/$LINUX_USER/test.txt" ./test.txt
