#!/usr/bin/env bash

# syslog
rsyslogd

# setup mysql credentials
ADMIN_USERNAME=$EMAIL_DB_ADMIN_USERNAME
ADMIN_PASSWORD=$EMAIL_DB_ADMIN_USERNAME
ADMIN_HOST=$EMAIL_DB_ADMIN_HOST
if [ ! -z "$MYSQL_ENV_MYSQL_SETUP" ]; then
  ADMIN_USERNAME='root'
  ADMIN_PASSWORD=$MYSQL_ENV_MYSQL_ROOT_PASSWORD
  ADMIN_HOST=$MYSQL_PORT_3306_TCP_ADDR
fi

# setup mysql db user
DB_USERNAME=$EMAIL_DB_USERNAME
DB_PASSWORD=$EMAIL_DB_PASSWORD

sed -i "s~__MYSQL_IP__~"$ADMIN_HOST"~g" /etc/my.cnf

# db setup
if [ ! -z "$EMAIL_DB_SEED_DATA" ]; then
  mysql -h $ADMIN_HOST -u $ADMIN_USERNAME -p$ADMIN_PASSWORD -e "CREATE DATABASE IF NOT EXISTS $EMAIL_DB_NAME;"
  mysql -h $ADMIN_HOST -u $ADMIN_USERNAME -p$ADMIN_PASSWORD -e "use $EMAIL_DB_NAME; GRANT SELECT, INSERT, UPDATE, DELETE, CREATE ON $EMAIL_DB_NAME.* TO '$DB_USERNAME'@'%' IDENTIFIED BY '$DB_PASSWORD'; FLUSH PRIVILEGES;"
  mysql -h $ADMIN_HOST -u $ADMIN_USERNAME -p$ADMIN_PASSWORD -e "use $EMAIL_DB_NAME; CREATE TABLE IF NOT EXISTS domains (domain varchar(50) NOT NULL, PRIMARY KEY (domain));"
  mysql -h $ADMIN_HOST -u $ADMIN_USERNAME -p$ADMIN_PASSWORD -e "use $EMAIL_DB_NAME; CREATE TABLE IF NOT EXISTS forwardings (source varchar(80) NOT NULL, destination TEXT NOT NULL, PRIMARY KEY (source));"
  mysql -h $ADMIN_HOST -u $ADMIN_USERNAME -p$ADMIN_PASSWORD -e "use $EMAIL_DB_NAME; CREATE TABLE IF NOT EXISTS users (email varchar(80) NOT NULL, password varchar(20) NOT NULL, PRIMARY KEY (email));"
  mysql -h $ADMIN_HOST -u $ADMIN_USERNAME -p$ADMIN_PASSWORD -e "use $EMAIL_DB_NAME; CREATE TABLE IF NOT EXISTS transport (domain varchar(128) NOT NULL default '', transport varchar(128) NOT NULL default '', UNIQUE KEY domain (domain));"
  mysql -h $ADMIN_HOST -u $ADMIN_USERNAME -p$ADMIN_PASSWORD -e "use $EMAIL_DB_NAME; INSERT INTO domains (domain) VALUES ('$EMAIL_HOST');"
fi

# setup users
accounts=$(echo $EMAIL_ACCOUNTS | tr " " "\n")
for account in $accounts
do
  set -- "${account}"

  EMAIL=${1%:*}
  PASSWORD=${1#*:}

  mysql -h $ADMIN_HOST -u $ADMIN_USERNAME -p$ADMIN_PASSWORD -e "use $EMAIL_DB_NAME; INSERT INTO users (email, password) VALUES ('$EMAIL', ENCRYPT('$PASSWORD'));"
done

# postfix-mysql config
sed -i "s~__MYSQL_IP__~"$ADMIN_HOST"~g" /etc/postfix/mysql-virtual_domains.cf
sed -i "s~__MYSQL_IP__~"$ADMIN_HOST"~g" /etc/postfix/mysql-virtual_forwardings.cf
sed -i "s~__MYSQL_IP__~"$ADMIN_HOST"~g" /etc/postfix/mysql-virtual_mailboxes.cf
sed -i "s~__MYSQL_IP__~"$ADMIN_HOST"~g" /etc/postfix/mysql-virtual_email2email.cf
sed -i "s~__MYSQL_IP__~"$ADMIN_HOST"~g" /etc/dovecot/dovecot-sql.conf.ext

sed -i "s~__MYSQL_USERNAME__~"$DB_USERNAME"~g" /etc/postfix/mysql-virtual_domains.cf
sed -i "s~__MYSQL_USERNAME__~"$DB_USERNAME"~g" /etc/postfix/mysql-virtual_forwardings.cf
sed -i "s~__MYSQL_USERNAME__~"$DB_USERNAME"~g" /etc/postfix/mysql-virtual_mailboxes.cf
sed -i "s~__MYSQL_USERNAME__~"$DB_USERNAME"~g" /etc/postfix/mysql-virtual_email2email.cf
sed -i "s~__MYSQL_USERNAME__~"$DB_USERNAME"~g" /etc/dovecot/dovecot-sql.conf.ext

sed -i "s~__MYSQL_PASSWORD__~"$DB_PASSWORD"~g" /etc/postfix/mysql-virtual_domains.cf
sed -i "s~__MYSQL_PASSWORD__~"$DB_PASSWORD"~g" /etc/postfix/mysql-virtual_forwardings.cf
sed -i "s~__MYSQL_PASSWORD__~"$DB_PASSWORD"~g" /etc/postfix/mysql-virtual_mailboxes.cf
sed -i "s~__MYSQL_PASSWORD__~"$DB_PASSWORD"~g" /etc/postfix/mysql-virtual_email2email.cf
sed -i "s~__MYSQL_PASSWORD__~"$DB_PASSWORD"~g" /etc/dovecot/dovecot-sql.conf.ext

sed -i "s~__MYSQL_DB_NAME__~"$EMAIL_DB_NAME"~g" /etc/postfix/mysql-virtual_domains.cf
sed -i "s~__MYSQL_DB_NAME__~"$EMAIL_DB_NAME"~g" /etc/postfix/mysql-virtual_forwardings.cf
sed -i "s~__MYSQL_DB_NAME__~"$EMAIL_DB_NAME"~g" /etc/postfix/mysql-virtual_mailboxes.cf
sed -i "s~__MYSQL_DB_NAME__~"$EMAIL_DB_NAME"~g" /etc/postfix/mysql-virtual_email2email.cf
sed -i "s~__MYSQL_DB_NAME__~"$EMAIL_DB_NAME"~g" /etc/dovecot/dovecot-sql.conf.ext

sed -i "s~__EMAIL_HOST__~"$EMAIL_HOST"~g" /etc/dovecot/dovecot.conf
sed -i "s~__EMAIL_HOST__~"$EMAIL_HOST"~g" /etc/aliases

postconf -e "myhostname = $EMAIL_HOST"
postconf -e "smtp_sasl_password_maps = static:$EMAIL_SENDGRID_USERNAME:$EMAIL_SENDGRID_PASSWORD"

# update postfix with devcot
echo "dovecot   unix  -       n       n       -       -       pipe
    flags=DRhu user=vmail:vmail argv=/usr/libexec/dovecot/deliver -f \${sender} -d \${recipient}" >> /etc/postfix/master.cf

/usr/sbin/postfix start
dovecot

newaliases
/usr/sbin/postfix stop
/usr/sbin/postfix start

tail -f /var/log/maillog
