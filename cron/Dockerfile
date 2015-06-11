FROM       centos:centos7
MAINTAINER Jose Lopez "jlope001@gmail.com"

RUN yum install -y openssh-server sudo php php-pdo php-mysql php-mbstring php-dom php-gd php-posix cronie

ADD scripts/owncloud /etc/cron.d/owncloud-cron
RUN chmod 0644 /etc/cron.d/owncloud-cron

RUN touch /var/log/cron.log

CMD crond && tail -f /var/log/cron.log
