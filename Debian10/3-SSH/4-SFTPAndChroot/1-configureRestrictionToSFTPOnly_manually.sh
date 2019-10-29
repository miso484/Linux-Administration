# create a group for SFTP
groupadd sftp_users

# apply to a user [devops] for SFTP only
usermod -G sftp_users devops

echo "# line 114: comment out and add a line like follows
#Subsystem sftp /usr/lib/openssh/sftp-server
Subsystem sftp internal-sftp
# add to the end
Match Group sftp_users
  X11Forwarding no
  AllowTcpForwarding no
  ChrootDirectory /home
  ForceCommand internal-sftp"

vi /etc/ssh/sshd_config

systemctl restart ssh