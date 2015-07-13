FROM       centos:centos7
MAINTAINER Jose Lopez "jlope001@gmail.com"

# setup EPEL7
RUN yum -y install http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
RUN rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
ADD ./assets/repo/remi.repo /etc/yum.repos.d/remi.repo

RUN yum install -y php php-pdo php-mysql php-mbstring php-dom php-gd php-posix php-apcu cronie

RUN useradd --create-home -s /bin/bash vagrant

RUN usermod -u 1000 vagrant
RUN groupmod -g 1000 vagrant

ADD scripts/owncloud /etc/cron.d/owncloud-cron
RUN chmod 0644 /etc/cron.d/owncloud-cron

RUN touch /var/log/cron.log
RUN chmod 777 /var/log/cron.log

CMD crond & tail -f /var/log/cron.log
