# Install Vsftpd to configure FTP server to transfer files.

# install Vsftpd
apt -y install vsftpd

vi /etc/vsftpd.conf
cat <<EOT
# line 31: uncomment
write_enable=YES

# line 99,100: uncomment ( allow ascii mode transfer )
ascii_upload_enable=YES
ascii_download_enable=YES

# line 122: uncomment ( enable chroot )
chroot_local_user=YES

# line 123: uncomment ( enable chroot list )
chroot_list_enable=YES

# line 125: uncomment ( enable chroot list )
chroot_list_file=/etc/vsftpd.chroot_list

# line 131: uncomment
ls_recurse_enable=YES

# add to the end : specify chroot directory
# if not specified, users' home directory equals FTP home directory
local_root=public_html

# turn off seccomp filter if cannot login normally
seccomp_sandbox=NO
EOT

vi /etc/vsftpd.chroot_list
cat <<EOT
# add users you allow to move over their home directory
debian
EOT

systemctl restart vsftpd