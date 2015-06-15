#!/usr/bin/env bash

# remove stale files from previous run
rm -f "/config/Library/Application Support/Plex Media Server/plexmediaserver.pid"

# # setup folders
mkdir -p /config/plex
mkdir -p /data
chown -R plex:plex /config/plex
chown -R plex:plex /data

cd /usr/lib/plexmediaserver && HOME=/config/plex  ./start.sh
