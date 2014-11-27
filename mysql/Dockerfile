FROM       centos:centos7
MAINTAINER Jose Lopez "jlope001@gmail.com"

# setup base programs
RUN yum install -y wget
RUN wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
RUN rpm -ivh mysql-community-release-el7-5.noarch.rpm
RUN yum install -y mysql-server
ADD ./assets/my.cnf /etc/my.cnf
RUN chmod 644 /etc/my.cnf

VOLUME ["/var/lib/mysql"]

EXPOSE 3306

ADD ./scripts/startup.sh /opt/startup.sh
CMD ["/bin/bash", "/opt/startup.sh"]
