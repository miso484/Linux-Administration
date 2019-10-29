#!/bin/bash

# create a new file
touch /etc/profile.d/command_alias.sh

# add alias you'd like to set
echo "alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
" >> /etc/profile.d/command_alias.sh

# reload
source /etc/profile.d/command_alias.sh