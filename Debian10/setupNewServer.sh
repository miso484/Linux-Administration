#!/bin/bash

# Create devops user
source ./1-InitialSettings/1-LocalUser/1-AddUser.sh

# Add devops user to adm group
source ./1-InitialSettings/1-LocalUser/2-addUserToAdminGroup.sh

# Install sudo
source ./1-InitialSettings/2-SudoSettings/1-installSudo.sh

