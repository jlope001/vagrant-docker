FROM       centos:centos7
MAINTAINER Jose Lopez "jlope001@gmail.com"

RUN yum install -y php php-pdo php-mysql php-mbstring php-dom php-gd php-posix cronie

RUN useradd --create-home -s /bin/bash vagrant

RUN usermod -u 1000 vagrant
RUN groupmod -g 1000 vagrant

ADD scripts/owncloud /etc/cron.d/owncloud-cron
RUN chmod 0644 /etc/cron.d/owncloud-cron

RUN touch /var/log/cron.log
RUN chmod 777 /var/log/cron.log

CMD crond & tail -f /var/log/cron.log
