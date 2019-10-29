ll /mnt
nfs4_getfacl /mnt/test.txt

# add generic read/execute for [buster] user to [/mnt/test.txt] file
nfs4_setfacl -a A::buster@srv.world:rxtncy /mnt/test.txt

nfs4_getfacl /mnt/test.txt

# verify with [buster] user
ll /mnt

cat /mnt/test.txt

# delete generic read/execute for [buster] user from [/mnt/test.txt] file
nfs4_setfacl -x A::1000:rxtcy /mnt/test.txt

nfs4_getfacl /mnt/test.txt