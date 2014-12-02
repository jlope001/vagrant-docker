#!/usr/bin/env bash

# Script for ubuntu desktop systems that will rsync an owncloud data directory to
# a remote backup.  Its used to periodically backup all owncloud files for redundancy
#
# Required Environment Variables:
#
# OWNCLOUD_REMOTE_HOST: remote owncloud host
# OWNCLOUD_REMOTE_PORT: remote owncloud port. typically this is port 22
# OWNCLOUD_REMOTE_USER: ssh user we will be connecting with
# OWNCLOUD_REMOTE_FOLDER: remote folder housing the data
# OWNCLOUD_LOCAL_FOLDER: local folder where we will backup the information
#

# Makes sure we exit if flock fails.
set -e

(
  # Wait for lock on /var/lock/.myscript.exclusivelock (fd 200) for 10 seconds
  flock -n 200

  # verify owncloud environment variables
  if [[ -z "$OWNCLOUD_REMOTE_HOST" ]] || [[ -z "$OWNCLOUD_REMOTE_PORT" ]] || [[ -z "$OWNCLOUD_REMOTE_USER" ]] || [[ -z "$OWNCLOUD_LOCAL_FOLDER" ]]  || [[ -z "$OWNCLOUD_REMOTE_FOLDER" ]]; then
    notify-send -i owncloud "required environment variables not found"

  # verify folder exists
  elif [ ! -d "$OWNCLOUD_LOCAL_FOLDER" ]; then
    notify-send -i owncloud "local folder does not exist"

  elif [ -d "$OWNCLOUD_LOCAL_FOLDER" ]; then
    # Control will enter here if $DIRECTORY exists.
    notify-send -i owncloud "remote backup - started"

    rsync -azP --delete -e "ssh -p $OWNCLOUD_REMOTE_PORT" $OWNCLOUD_REMOTE_USER@$OWNCLOUD_REMOTE_HOST:$OWNCLOUD_REMOTE_FOLDER $OWNCLOUD_LOCAL_FOLDER

    notify-send -i owncloud "remote backup - completed"
  fi

) 200>/tmp/.owncloud.lock

