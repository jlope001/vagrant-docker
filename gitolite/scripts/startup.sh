#!/usr/bin/env bash

# update ownership to common uid/gid
usermod -u 1000 git
groupmod -g 1000 git

# copy pub key and finish setup
echo $GIT_ID_RSA_PUB > /tmp/git-admin.pub
mkdir -p /home/git/repositories
chown -R git:git /home/git/repositories
cd /home/git; su git -c "bin/gitolite setup -pk /tmp/git-admin.pub"

# fire up ssh daemon
/usr/sbin/sshd -D -e
