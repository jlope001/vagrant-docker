FROM       centos:centos7
MAINTAINER Jose Lopez "jlope001@gmail.com"

RUN yum -y update && yum -y clean all

RUN useradd -s /bin/bash mysql
RUN usermod -u 1000 mysql
RUN groupmod -g 1000 mysql

# setup base programs
RUN rpm -ivh http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
RUN yum install -y mysql-server
ADD ./assets/my.cnf /etc/my.cnf

RUN chmod 644 /etc/my.cnf
RUN chown mysql:mysql /var/log/mysqld.log

VOLUME ["/var/lib/mysql"]

EXPOSE 3306

ADD ./scripts/startup.sh /opt/startup.sh
CMD ["/bin/bash", "/opt/startup.sh"]
