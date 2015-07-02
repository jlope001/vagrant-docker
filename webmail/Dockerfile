FROM       centos:centos7
MAINTAINER Jose Lopez "jlope001@gmail.com"

RUN yum -y update && yum -y clean all
RUN yum -y install unzip wget

WORKDIR /var/www

RUN wget http://www.afterlogic.org/download/webmail_php.zip
RUN unzip webmail_php.zip
RUN rm -rf webmail_php.zip

ADD ./scripts/startup.sh /opt/startup.sh
CMD ["/bin/bash", "/opt/startup.sh"]
