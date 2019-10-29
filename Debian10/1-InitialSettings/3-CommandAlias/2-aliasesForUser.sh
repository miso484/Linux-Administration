#!/bin/bash

# add to the end alias you'd like to set
echo "alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
" >> ~/.bashrc

source ~/.bashrc