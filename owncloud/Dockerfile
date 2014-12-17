FROM       centos:centos7
MAINTAINER Jose Lopez "jlope001@gmail.com"

# install unzip dependencies
RUN yum -y install wget tar bzip2

# setup owncloud
WORKDIR /var/www
RUN wget --no-check-certificate https://download.owncloud.org/community/owncloud-7.0.4.tar.bz2
RUN tar xjf owncloud-7.0.4.tar.bz2
RUN mkdir -p owncloud/data
RUN rm -rf owncloud-7.0.4.tar.bz2
ADD ./assets/config.php /var/www/owncloud/config/config.php

# fix permissions - to something more standard
RUN chown -R 1000:1000 /var/www/owncloud

ADD ./scripts/startup.sh /opt/startup.sh
CMD ["/bin/bash", "/opt/startup.sh"]
