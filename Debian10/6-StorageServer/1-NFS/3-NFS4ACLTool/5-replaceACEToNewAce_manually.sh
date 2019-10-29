# create ACL list
echo "A::OWNER@:rwaxtTcCy
A::GROUP@:tcy
A::EVERYONE@:tcy" >> ~/acl.txt

# replace ACL from the file
nfs4_setfacl -S acl.txt /mnt/test.txt

nfs4_getfacl /mnt/test.txt