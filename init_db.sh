#!/bin/bash
/usr/bin/mysqld_safe &
sleep 5
DATABASE_USER=openmrs
DB_USER_PASSWD=Admin123
DATABASE_NAME=openmrs
MYSQL_PASSWD=Admin123
mysql -uroot -p$MYSQL_PASSWD -e "CREATE DATABASE openmrs"
mysql -uroot -p$MYSQL_PASSWD -e "GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO '$DATABASE_USER'@'localhost' IDENTIFIED BY '$DB_USER_PASSWD'; FLUSH PRIVILEGES;"
mysql -uroot -p$MYSQL_PASSWD -e "GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO '$DATABASE_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWD'; FLUSH PRIVILEGES;"

mysql -uroot -pAdmin123 openmrs < /tmp/openmrs_jg.sql
