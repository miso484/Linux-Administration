nfs4_getfacl /mnt/test.txt

# replace EVERYONE's ACE to read/execute
nfs4_setfacl -m A::EVERYONE@:tcy A::EVERYONE@:RX /mnt/test.txt

nfs4_getfacl /mnt/test.txt