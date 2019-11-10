# download and add virtual machine images
# for downloadable image, refer to the official site below
# ⇒ https://app.vagrantup.com/boxes/search
vagrant box add generic/debian10
# choose provider

# initialize ([Vagrantfile] is created on the current path)\
vagrant init generic/debian10

# start virtual machine
vagrant up

# show state of virtual machine
vagrant status

# connect to virtual machine with SSH
vagrant ssh

# stop virtual machine
vagrant halt

# if you'd like to change settings of virtual machine, edit Vagrantfile
vi Vagrantfile
cat <<EOT
# for example to change CPU and Memory settings
# uncomment line 57 like follows and add or change values
  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM: <===
     vb.memory = "4096"
     vb.cpus = 2
  end
EOT