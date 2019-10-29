#!/bin/bash

# Configure SSH server to login with Key-Pair Authentication
# logon with common user you'd like to set SSH key-pair

# run [ssh-keygen] command to generate SSH key-pair
ssh-keygen

# go to home dir
cd ~
ls

mv ~/.ssh/id_rsa.pub ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys