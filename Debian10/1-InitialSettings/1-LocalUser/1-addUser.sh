#!/bin/bash

read -p "New user [devops]: " name
 name=${name:-devops}
 echo $name

# add a user [devops]
adduser $name
