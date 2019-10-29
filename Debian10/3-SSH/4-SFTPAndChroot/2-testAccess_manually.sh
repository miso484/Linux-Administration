read -p "Linux SSH User: " LINUX_USER
read -p "Linux SSH Server IP: " LINUX_IP

# this is denied
ssh "$LINUX_USER@$LINUX_IP" 

# this is allowed
sftp "$LINUX_USER@$LINUX_IP"