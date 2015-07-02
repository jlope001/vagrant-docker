#!/usr/bin/env bash

# look up memcache env variable override
if [ "$MEMCACHED_ENV_MEMCACHED_SETUP" = true ]; then
  PHPFPM_MEMCACHED_IP=$MEMCACHED_PORT_11211_TCP_ADDR
  PHPFPM_MEMCACHED_PORT=$MEMCACHED_PORT_11211_TCP_PORT
fi

# update php-fpm config to use memcached
sed -i 's~/tmp/php/session~"'"$PHPFPM_MEMCACHED_IP"':'"$PHPFPM_MEMCACHED_PORT"'"~g' /etc/php-fpm.d/owncloud.conf
sed -i 's~php_value\[session\.save_handler\] = files~php_value\[session\.save_handler\] = memcached~g' /etc/php-fpm.d/owncloud.conf

# update php-fpm config to use memcached
sed -i 's~/tmp/php/session~"'"$PHPFPM_MEMCACHED_IP"':'"$PHPFPM_MEMCACHED_PORT"'"~g' /etc/php-fpm.d/wordpress.conf
sed -i 's~php_value\[session\.save_handler\] = files~php_value\[session\.save_handler\] = memcached~g' /etc/php-fpm.d/wordpress.conf

# update php-fpm config to use memcached
sed -i 's~/tmp/php/session~"'"$PHPFPM_MEMCACHED_IP"':'"$PHPFPM_MEMCACHED_PORT"'"~g' /etc/php-fpm.d/webmail.conf
sed -i 's~php_value\[session\.save_handler\] = files~php_value\[session\.save_handler\] = memcached~g' /etc/php-fpm.d/webmail.conf

sed -i 's~;cgi.fix_pathinfo=1~cgi.fix_pathinfo=1~g' /etc/php.ini
sed -i 's~;default_charset = "UTF-8"~default_charset = "UTF-8"~g' /etc/php.ini

# update .htaccess
sed -i 's~php_value upload_max_filesize 513M~php_value upload_max_filesize 10G~g' /var/www/owncloud/.htaccess
sed -i 's~php_value post_max_size 513M~php_value post_max_size 10G~g' /var/www/owncloud/.htaccess

sed -i 's~upload_max_filesize=513M~upload_max_filesize=10G~g' /var/www/owncloud/.user.ini
sed -i 's~post_max_size=513M~post_max_size=10G~g' /var/www/owncloud/.user.ini
sed -i 's~memory_limit=512M~memory_limit=10G~g' /var/www/owncloud/.user.ini

# update ownership to common uid/gid
usermod -u 1000 apache
groupmod -g 1000 apache

php-fpm -F
