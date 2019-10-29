# SYNTAX: # sftp [Option] [user@hostname]

read -p "Linux SSH User: " LINUX_USER
read -p "Linux SSH Server IP: " LINUX_IP

cd ~
mkdir public_html
cd public_html
touch test.txt debian.txt
cd ..

sftp "$LINUX_USER@$LINUX_IP"

    # show current directory on remote server
    pwd

    # show current directory on local server
    !pwd

    # show files in current directory on FTP server
    ls -l

    # show files in current directory on local server
    !ls -l

    # change directory
    cd public_html
    pwd

    # upload a file to remote server
    put test.txt debian.txt

    # upload some files to remote server
    put *.txt
    ls -l

    # download a file from remote server
    get test.txt

    # download some files from remote server
    get *.txt

    # create a directory on remote server
    mkdir testdir
    ls -l

    # delete a directory on remote server
    rmdir testdir
    ls -l

    # delete a file on remote server
    rm test2.txt
    ls -l

    # execute commands with ![command]
    !cat /etc/passwd

    # exit
    quit