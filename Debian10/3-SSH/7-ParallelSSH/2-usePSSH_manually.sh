read -p "Linux SSH User: " LINUX_USER
read -p "Linux SSH Server1 IP: " LINUX_IP1
read -p "Linux SSH Server2 IP: " LINUX_IP2

# This is the case for SSH Key-pair authentication without passphrase. If passphrase is set in Key-pair, start SSH-Agent first to automate inputting passphrase.

# connect to hosts and execute hostname command
parallel-ssh -H "$LINUX_IP1 $LINUX_IP2" -i "hostname"

# it's possible to read host list from a file
vi pssh_hosts.txt

# write hosts per line like follows
#user@srv1
#user@srv2

parallel-ssh -h pssh_hosts.txt -i "uptime"

# it's possible to connect with password authentication too, but it needs passwords on all hosts are the same one
parallel-ssh -h pssh_hosts.txt -A -O PreferredAuthentications=password -i "uname -r"