FROM       centos:centos7
MAINTAINER Jose Lopez "jlope001@gmail.com"

# Enable additional repositories
RUN yum -y install http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-2.noarch.rpm

# install unzip dependencies
RUN yum -y install wget tar bzip2

# setup owncloud
WORKDIR /var/www
RUN wget --no-check-certificate https://download.owncloud.org/community/owncloud-7.0.3.tar.bz2
RUN tar xjf owncloud-7.0.3.tar.bz2
RUN mkdir -p owncloud/data
RUN rm -rf owncloud-7.0.3.tar.bz2
ADD ./assets/config.php /var/www/owncloud/config/config.php

# fix permissions - to something more standard
RUN chown -R 1000:1000 /var/www/owncloud

CMD ["echo", "owncloud container"]
