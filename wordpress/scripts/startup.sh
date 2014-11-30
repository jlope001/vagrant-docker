#!/usr/bin/env bash

# update owncloud database ip if linked as this chnages based on docker
# NOTE - replace the IP holder with __MYSQL_IP__ so it will be properly replaced
sed -i "s~__MYSQL_IP__~"$MYSQL_PORT_3306_TCP_ADDR"~g" /var/www/blog/wp-config.php

cat /var/www/blog/wp-config.php
