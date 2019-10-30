# Install Desktop Virtualization "SPICE ( Simple Protocol for Independent Computing Environment )".
# It's possible to connect to virtual machines from remote client computer.

#
## Edit existing virtual machine's xml-file and start virtual machine with SPICE like follows.
#

# The example on this site shows to create a virtual machine without graphics,
# so it's OK to change settings like follows, but if you created virtual machine with graphics.
# Remove "<graphics>***" and " <video>***" sections in xml file because qxl is used for graphics.

# edit the configration of [debian]
virsh edit debian
cat <<EOT
<domain type='kvm'>
  <name>debian</name>
  <uuid>bd02b063-1330-4796-8c7e-8354a93eb0e3</uuid>
  <metadata>
    <libosinfo:libosinfo xmlns:libosinfo="http://libosinfo.org/xmlns/libvirt/domain/1.0">
  .....
  .....
    # add follows   <====
    # set any password for [passwd=***] section
    # set a uniq slot number for [slot=***]
    <graphics type='spice' port='5900' autoport='no' listen='0.0.0.0' passwd='password'>
      <listen type='address' address='0.0.0.0'/>
    </graphics>
    <video>
      <model type='qxl' ram='65536' vram='32768' heads='1'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x07' function='0x0'/>
    </video>
    <memballoon model='virtio'>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x06' function='0x0'/>
    </memballoon>
  </devices>
</domain>
EOT

# start VM
virsh start debian


#
## Enable SPICE on initial creating of virtual machine
#

# Then, it's possible to install Systems with SPICE which requires GUI like Windows without installing Desktop Environment on KVM Host computer.
virt-install \
--name Win2k19 \
--ram 6144 \
--disk path=/var/kvm/images/Win2k19.img,size=100 \
--vcpus=4 \
--os-type windows \
--os-variant=win2k19 \
--network bridge=br0 \
--graphics spice,listen=0.0.0.0,password=password,keymap=ja \
--video qxl \
--cdrom /tmp/Win2019_JA-JP.ISO
