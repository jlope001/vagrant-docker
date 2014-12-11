#!/usr/bin/env bash

# remove stale files from previous run
rm -rf /var/run/*
rm -f "/config/Library/Application Support/Plex Media Server/plexmediaserver.pid"

# create plex media user
usermod -u 1000 media
groupmod -g 1000 media

# setup folders
mkdir -p /config/plex
chown -R media:media /config/plex
chown -R media:media /media

su media -c "cd /usr/lib/plexmediaserver && HOME=/config/plex ./start.sh"
