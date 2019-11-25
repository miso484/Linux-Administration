<<EXAMPLE
Configure PostgreSQL Streaming Replication.
This configuration is Master/Slave settings.
EXAMPLE

#
## Install PostgreSQL Server on all Nodes
#

# Refer to 1-installAndConfigurePostgreSQL_manually.sh

#
## Configure Master Host.
#

vi /etc/postgresql/11/main/postgresql.conf
cat <<EOT
# line 59: uncomment and change
listen_addresses = '*'

# line 184: uncomment
wal_level = replica

# line 189: uncomment
synchronous_commit = on

# line 239: uncomment (max number of concurrent connections from streaming clients)
max_wal_senders = 10

# line 241: uncomment and change (minimum number of past log file segments)
wal_keep_segments = 10

# line 253: uncomment and change
synchronous_standby_names = '*'
EOT

vi /etc/postgresql/11/main/pg_hba.conf
cat <<EOT
# end line : change like follows
# host replication [replication user] [allowed IP addresses] trust
#host    replication     all             127.0.0.1/32            md5
#host    replication     all             ::1/128                 md5
host    replication     rep_user         127.0.0.1/32            trust
host    replication     rep_user         10.0.0.30/32            trust
host    replication     rep_user         10.0.0.51/32            trust
EOT

# create a user for replication
su - postgres
createuser --replication -P rep_user
exit

mkdir /var/lib/postgresql/11/archive
chown postgres. /var/lib/postgresql/11/archive
systemctl restart postgresql

#
## Configure Slave Host.
#

systemctl stop postgresql
rm -rf /var/lib/postgresql/11/main/*
su - postgres

# get backup from Master Server
pg_basebackup -R -h dlp.srv.world -U rep_user -D /var/lib/postgresql/11/main -P
exit

vi /etc/postgresql/11/main/postgresql.conf
cat  <<EOT
# line 59: uncomment and change
listen_addresses = '*'

# line 263: uncomment
hot_standby = on
EOT

vi /var/lib/postgresql/11/main/recovery.conf
cat <<EOT
# add application_name (any name : specify hostname and so on)
standby_mode = 'on'
primary_conninfo = 'user=rep_user passfile=''/var/lib/postgresql/.pgpass'' host=dlp.srv.world port=5432 sslmode=prefer sslcompression=0 krbsrvname=postgres target_session_attrs=any application_name=node01'
EOT

systemctl start postgresql

#
## Make sure the setting works normally to create databases on Master Server.
#

psql -c "select usename, application_name, client_addr, state, sync_priority, sync_state from pg_stat_replication;"

<<OUTPUT
 usename  | application_name | client_addr |   state   | sync_priority | sync_state
----------+------------------+-------------+-----------+---------------+------------
 rep_user | node01           | 10.0.0.51   | streaming |             1 | sync
(1 row)
OUTPUT