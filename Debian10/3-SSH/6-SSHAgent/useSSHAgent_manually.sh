read -p "Linux SSH User: " LINUX_USER
read -p "Linux SSH Server IP: " LINUX_IP

# start SSH-Agent
eval `ssh-agent`

# add identity
ssh-add

# confirm
ssh-add -l

# try to conenct with SSH without passphrase
ssh ssh "$LINUX_IP" hostname

# exit from SSH-Agent
eval `ssh-agent -k`