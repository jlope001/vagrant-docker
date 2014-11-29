#!/usr/bin/env bash

# create plex media user
usermod -u 1000 media
groupmod -g 1000 media

# setup folders
mkdir -p /config/plex
chown -R media:media /config/plex
chown -R media:media /media

cd /usr/lib/plexmediaserver && HOME=/config/plex ./start.sh
