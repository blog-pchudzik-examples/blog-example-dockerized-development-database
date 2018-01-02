#!/usr/bin/env bash

set -e

DATADIR="/var/lib/mysql"

mysql_install_db --datadir="$DATADIR" --rpm
chown -R mysql:mysql $DATADIR

gosu mysql mysqld&
PID="$!"

echo "Wiating for mysql to start"
while ! mysqladmin ping --silent; do
    sleep 0.5
done
echo "MySQL ready"

mysql -e "GRANT ALL ON *.* TO root@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' WITH GRANT OPTION"
echo "User root created with password ${MYSQL_ROOT_PASSWORD}"

mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE}"
echo "Database $MYSQL_DATABASE created"

echo "Starting data import"
tar -xzOf /mydb.sql.tar.gz | mysql "$MYSQL_DATABASE"
rm /mydb.sql.tar.gz
echo "MySQL data imported"

mysqladmin shutdown
wait "$PID"
echo "MySQL process stopped"

tar czvf default_mysql.tar.gz "$DATADIR"
