FROM       centos:centos7
MAINTAINER Jose Lopez "jlope001@gmail.com"

RUN yum -y update && yum -y clean all
RUN yum --enablerepo=centosplus install -y postfix
RUN yum -y install dovecot dovecot-mysql

ADD ./scripts/startup.sh /opt/startup.sh
CMD ["/bin/bash", "/opt/startup.sh"]
