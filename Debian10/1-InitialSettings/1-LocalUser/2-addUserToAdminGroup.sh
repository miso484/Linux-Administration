#!/bin/bash

read -p "User that will be added to adm group [devops]: " name
 name=${name:-devops}
 echo $name

# confgure that only devops user can switch to root account with 'su' command

# add devops user to adm group
usermod -G adm $name

read -p "Press enter to open the /etc/pam.d/su file"
read -p "When the file opens uncomment line 15 and add the 'group=adm' to it"

vi /etc/pam.d/su
