read -p "Linux SSH User: " LINUX_USER
read -p "Linux SSH Server IP: " LINUX_IP
read -p "Linux SSH User PW: " LINUX_USER_PW

# -p password : from argument
# if initial connection, specify [StrictHostKeyChecking=no]
sshpass -p $LINUX_USER_PW ssh -o StrictHostKeyChecking=no $LINUX_IP hostname

# -f file : from file
echo "LINUX_USER_PW" > sshpass.txt
chmod 600 sshpass.txt
sshpass -f sshpass.txt ssh "$LINUX_IP" hostname

# -e : from env variable
export SSHPASS=$LINUX_USER_PW
sshpass -e ssh $LINUX_IP hostname