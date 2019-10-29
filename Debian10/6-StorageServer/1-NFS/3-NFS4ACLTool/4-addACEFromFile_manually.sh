# create ACL list
echo "A::buster@srv.world:RX
A::debian@srv.world:RWX" >> ~/acl.txt

# add ACL from the file
nfs4_setfacl -A acl.txt /mnt/test.txt

nfs4_getfacl /mnt/test.txt