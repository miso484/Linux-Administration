#!/bin/bash

read -p "Username that will be deleted [devops]: " name
 name=${name:-devops}
 echo $name

# remove a user account 'devops' and his home directory
deluser $name --remove-home