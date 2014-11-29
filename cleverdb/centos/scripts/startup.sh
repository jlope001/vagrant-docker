#!/usr/bin/env bash

# start up required syslog dependency
service rsyslog start

# we used a mysql linked container and grab variable
if [ ! -z "$MYSQL_ENV_MYSQL_SETUP" ]; then
  CLEVERDB_DB_HOST=$MYSQL_PORT_3306_TCP_ADDR
  CLEVERDB_DB_PORT=$MYSQL_PORT_3306_TCP_PORT

  CLEVERDB_DB_ROOT_PASSWORD=$MYSQL_ENV_MYSQL_ROOT_PASSWORD
fi

# update configuration files
sed -i 's~__CLEVERDB_API_KEY__~'"$CLEVERDB_API_KEY"'~g' /etc/cleverdb-agent/connect.conf
sed -i 's~__CLEVERDB_DB_ID__~'"$CLEVERDB_DB_ID"'~g' /etc/cleverdb-agent/connect.conf
sed -i 's~__CLEVERDB_CONNECT_HOST__~'"$CLEVERDB_CONNECT_HOST"'~g' /etc/cleverdb-agent/connect.conf

sed -i 's~__CLEVERDB_DB_HOST__~'"$CLEVERDB_DB_HOST"'~g' /etc/cleverdb-agent/ports.conf
sed -i 's~__CLEVERDB_DB_PORT__~'"$CLEVERDB_DB_PORT"'~g' /etc/cleverdb-agent/ports.conf


# update password push
if [ -n "$CLEVERDB_DB_ROOT_PASSWORD" ]; then
    CLEVERDB_DB_ROOT_PASSWORD="-p$CLEVERDB_DB_ROOT_PASSWORD"
fi

# setup replication
mysql \
-u root \
$CLEVERDB_DB_ROOT_PASSWORD \
-h $CLEVERDB_DB_HOST \
-P $CLEVERDB_DB_PORT \
-e " \
    CREATE DATABASE IF NOT EXISTS $CLEVERDB_DB_NAME; \
    GRANT REPLICATION SLAVE ON *.* TO '$CLEVERDB_DB_USERNAME'@'%' IDENTIFIED BY '$CLEVERDB_DB_PASSWORD'; \
    FLUSH PRIVILEGES; \
    USE $CLEVERDB_DB_NAME; FLUSH TABLES WITH READ LOCK;"

# must be root for this one
mysqldump \
-u root \
$CLEVERDB_DB_ROOT_PASSWORD \
-h $CLEVERDB_DB_HOST \
-P $CLEVERDB_DB_PORT \
--opt --master-data \
$CLEVERDB_DB_NAME > /root/$CLEVERDB_DB_NAME.sql

mysql \
-u root \
$CLEVERDB_DB_ROOT_PASSWORD \
-h $CLEVERDB_DB_HOST \
-P $CLEVERDB_DB_PORT \
-e "UNLOCK TABLES;"

# upload first dump (which is probably empty)
if [ "$CLEVERDB_UPLOAD_DB_DUMP" = true ]; then
  cleverdb-upload /root/$CLEVERDB_DB_NAME.sql
fi

rm /root/$CLEVERDB_DB_NAME.sql

# start up agent
/usr/bin/cleverdb-agent -l debug
