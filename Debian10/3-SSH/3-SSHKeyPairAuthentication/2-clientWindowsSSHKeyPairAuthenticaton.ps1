$WINDOWS_USER = Read-Host -Prompt "Windows SSH User: "
$WINDOWS_IP = Read-Host -Prompt "Windows SSH Server IP: "

# setup ssh directory
New-Item -ItemType Directory -Path ~\.ssh
Set-Location ~\.ssh

# copy the secret key to the local ssh directory
sftp "$WINDOWS_USER@$WINDOWS_IP"
Set-Location ~\.ssh
Get-ChildItem
get id_rsa
exit

# test connection
ssh "$WINDOWS_USER@$WINDOWS_IP" powershell -c "ls C:\Users\$WINDOWS_USER"