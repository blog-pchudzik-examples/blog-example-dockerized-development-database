#!/usr/bin/env bash

set -e

if [ "$(ls -A /var/lib/mysql)" ]; then
	echo "Running with existing database in /var/lib/mysql"
else
	echo 'Populate initial db';
	tar xpzvf default_mysql.tar.gz	
fi

gosu mysql mysqld
