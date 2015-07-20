#!/usr/bin/env bash

# move over installation files
cp -rf /var/www/roundcubemail-1.1.2/* /var/www/webmail/.

# setup admin credentials
ADMIN_USERNAME=$WEBMAIL_DB_ADMIN_USERNAME
ADMIN_PASSWORD=$WEBMAIL_DB_ADMIN_PASSWORD
ADMIN_HOST=$EMAIL_DB_ADMIN_HOST

DB_USERNAME=$WEBMAIL_DB_USERNAME
DB_PASSWORD=$WEBMAIL_DB_PASSWORD
DB_NAME=$WEBMAIL_DB_NAME
DB_HOST=$WEBMAIL_DB_HOST
DB_PORT=$WEBMAIL_DB_PORT

IMAP_HOST=$WEBMAIL_IMAP_HOST
IMAP_PORT=$WEBMAIL_IMAP_PORT

if [ ! -z "$MYSQL_ENV_MYSQL_SETUP" ]; then
  ADMIN_USERNAME="root"
  ADMIN_PASSWORD=$MYSQL_ENV_MYSQL_ROOT_PASSWORD
  ADMIN_HOST=$MYSQL_PORT_3306_TCP_ADDR
  ADMIN_PORT=$MYSQL_PORT_3306_TCP_PORT

  DB_HOST=$MYSQL_PORT_3306_TCP_ADDR
  DB_PORT=$MYSQL_PORT_3306_TCP_PORT
fi

if [ ! -z "$EMAIL_ENV_EMAIL_SETUP" ]; then
  IMAP_HOST=$EMAIL_PORT_993_TCP_ADDR
  IMAP_PORT=$EMAIL_PORT_993_TCP_PORT
fi

if [ "$WEBMAIL_SEED_DATA" = true ]; then
  mysql -h $ADMIN_HOST -P $ADMIN_PORT -u $ADMIN_USERNAME -p$ADMIN_PASSWORD -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
  mysql -h $ADMIN_HOST -P $ADMIN_PORT -u $ADMIN_USERNAME -p$ADMIN_PASSWORD -e "use $DB_NAME; GRANT SELECT, INSERT, UPDATE, DELETE, CREATE ON $DB_NAME.* TO '$DB_USERNAME'@'%' IDENTIFIED BY '$DB_PASSWORD'; FLUSH PRIVILEGES;"
fi

sed -i "s~__MYSQL_DB_HOST__~"$DB_HOST"~g" /var/www/webmail/config/config.inc.php
sed -i "s~__MYSQL_DB_PORT__~"$DB_PORT"~g" /var/www/webmail/config/config.inc.php
sed -i "s~__MYSQL_DB_USERNAME__~"$DB_USERNAME"~g" /var/www/webmail/config/config.inc.php
sed -i "s~__MYSQL_DB_PASSWORD__~"$DB_PASSWORD"~g" /var/www/webmail/config/config.inc.php
sed -i "s~__MYSQL_DB_NAME__~"$DB_NAME"~g" /var/www/webmail/config/config.inc.php

sed -i "s~__WEBMAIL_SMTP_HOST__~"$WEBMAIL_SMTP_HOST"~g" /var/www/webmail/config/config.inc.php
sed -i "s~__WEBMAIL_SMTP_PORT__~"$WEBMAIL_SMTP_PORT"~g" /var/www/webmail/config/config.inc.php
sed -i "s~__WEBMAIL_SMTP_USERNAME__~"$WEBMAIL_SMTP_USERNAME"~g" /var/www/webmail/config/config.inc.php
sed -i "s~__WEBMAIL_SMTP_PASSWORD__~"$WEBMAIL_SMTP_PASSWORD"~g" /var/www/webmail/config/config.inc.php
sed -i "s~__WEBMAIL_PRODUCT_NAME__~"$WEBMAIL_PRODUCT_NAME"~g" /var/www/webmail/config/config.inc.php
sed -i "s~__WEBMAIL_SECRET_KEY__~"$WEBMAIL_SECRET_KEY"~g" /var/www/webmail/config/config.inc.php

sed -i "s~__WEBMAIL_IMAP_HOST__~"$EMAIL_PORT_143_TCP_ADDR"~g" /var/www/webmail/config/config.inc.php
sed -i "s~__WEBMAIL_IMAP_PORT__~"$EMAIL_PORT_143_TCP_PORT"~g" /var/www/webmail/config/config.inc.php

cat /var/www/webamil/config/config.inc.php
env

# fix permissions - to something more standard
chown -R 1000:1000 /var/www/webmail
