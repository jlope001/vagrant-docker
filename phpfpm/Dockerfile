FROM       centos:centos7
MAINTAINER Jose Lopez "jlope001@gmail.com"

# setup EPEL7
RUN yum -y install http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-2.noarch.rpm
RUN rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
ADD ./assets/repo/remi.repo /etc/yum.repos.d/remi.repo

# remove uneeded files
RUN yum -y remove mysql* mysql-server mysql-devel mysql-libs

# install dependencies
RUN yum -y install php-fpm php-gd php-ldap php-pear php-xml php-xmlrpc php-magickwand php-magpierss php-mbstring php-mcrypt php-shout php-snmp php-soap php-tidy php-pgsql php-pdo php-mysql php-memcached php-opcache php-curl

RUN mkdir -p /tmp/php/{session,wsdlcache}
RUN chmod -R 777 /tmp

# setup php
RUN sed -ri 's/memory_limit = 128M/memory_limit = 2G/g' /etc/php.ini
RUN sed -ri 's/post_max_size = 8M/post_max_size = 10G/g' /etc/php.ini
RUN sed -ri 's/upload_max_filesize = 2M/upload_max_filesize = 10G/g' /etc/php.ini
RUN sed -ri 's/;cgi.force_redirect = 1/cgi.force_redirect = 0/g' /etc/php.ini

# setup owncloud
ADD ./assets/config/owncloud.conf /etc/php-fpm.d/owncloud.conf
ADD ./assets/config/wordpress.conf /etc/php-fpm.d/wordpress.conf
RUN rm /etc/php-fpm.d/www.conf

EXPOSE 9000 9001

ADD ./scripts/startup.sh /opt/startup.sh
CMD ["/bin/bash", "/opt/startup.sh"]
