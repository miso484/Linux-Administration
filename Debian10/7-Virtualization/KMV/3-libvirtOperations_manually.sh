#
## Start Virtual Machine
#

# start Virtual Machine [debian]
virsh start debian

# start and connect to console of [debian]
virsh start debian --console

#
## Stop Virtual Machine
#

# stop Virtual Machine [debian]
virsh shutdown debian

# stop Virtual Machine [debian] forcely
virsh destroy debian


#
## Set auto-start for Virtual Machines
#

# enable auto-start for [debian]
virsh autostart debian

# disable auto-start for [debian]
virsh autostart --disable debian

#
## List all Virtual Machines.
#

# list all active Virtual Machines
virsh list

# list all Virtual Machines included inactives
virsh list --all

#
## Switch console
#

# Move from HostOS to GuestOS with a command [virsh console (name of virtual machine)]
virsh console debian     # connect to [debian]
# >> GuestOS console

# Move from GuestOS to HostOS with Ctrl + ] key.
# Ctrl + ] key
# >> HostOS console

#
## Get help
#
virsh --help
