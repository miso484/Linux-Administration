#
## Install and start PostgreSQL.
#

# install 
apt -y install postgresql

# configure
vi /etc/postgresql/11/main/postgresql.conf
cat <<EOT
# line 59: uncomment and change if you allow accesses from remote hosts
listen_addresses = '*'
EOT

systemctl restart postgresql

#
## Set PostgreSQL admin user's password and add a user and also add a test database.
#

# set password
su - postgres
psql -c "alter user postgres with password 'password'"

# add DB user [debian] as an example
createuser debian

# create a test database (owner is the user above)
createdb testdb -O debian

#
## Login as a user just added above and operate DataBase as test operation.
#

# show Databases
psql -l

<<OUTPUT
                                  List of databases
   Name    |  Owner   | Encoding |   Collate   |    Ctype    |   Access privileges
-----------+----------+----------+-------------+-------------+-----------------------
 postgres  | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 template0 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
           |          |          |             |             | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
           |          |          |             |             | postgres=CTc/postgres
 testdb    | debian   | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
(4 rows)
OUTPUT

# connect to test DB
psql testdb

# set password
 alter user debian with password 'password'; 

# create a test table
 create table test ( no int,name text ); 

# insert test data
 insert into test (no,name) values (1,'debian');

# show tables
 select * from test; 

<<OUTPUT
 no |  name
----+--------
  1 | debian
(1 row)
OUTPUT

# delete test table
 drop table test; 

# quit
 \q

# delete test database
dropdb testdb