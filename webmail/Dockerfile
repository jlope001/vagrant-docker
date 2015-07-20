FROM       centos:centos7
MAINTAINER Jose Lopez "jlope001@gmail.com"

RUN yum -y update && yum -y clean all
RUN yum -y install wget tar bzip2

# mysql
RUN rpm -ivh http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
RUN yum install -y mysql

WORKDIR /var/www

RUN wget https://downloads.sourceforge.net/project/roundcubemail/roundcubemail/1.1.2/roundcubemail-1.1.2-complete.tar.gz
RUN tar xfz roundcubemail-1.1.2-complete.tar.gz
RUN mkdir -p /var/www/webmail/config
RUN rm roundcubemail-1.1.2-complete.tar.gz
RUN wget http://svn.apache.org/repos/asf/httpd/httpd/trunk/docs/conf/mime.types && cp mime.types /var/www/roundcubemail-1.1.2/config/.


ADD ./assets/config.inc.php /var/www/roundcubemail-1.1.2/config/config.inc.php

ADD ./scripts/startup.sh /opt/startup.sh
CMD ["/bin/bash", "/opt/startup.sh"]
