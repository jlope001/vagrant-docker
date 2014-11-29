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

sed -i 's~;cgi.fix_pathinfo=1~cgi.fix_pathinfo=1~g' /etc/php.ini

# update ownership to common uid/gid
usermod -u 1000 apache
groupmod -g 1000 apache

php-fpm -F