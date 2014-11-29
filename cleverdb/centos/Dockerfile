FROM centos:centos7

MAINTAINER Jose Lopez "jlope001@gmail.com"

# install dependencies
RUN yum install -y wget mysql rsyslog which openssh-clients

RUN wget http://rpms.adiscon.com/v7-stable/rsyslog.repo -O /etc/yum.repos.d/rsyslog.repo
RUN yum -y install rsyslog rsyslog-docs

# install agent
ADD ./assets/yum.repo.conf /etc/yum.repos.d/cleverdb-agent.repo
RUN  yum -y install cleverdb-agent

# setup folders
RUN mkdir -p /etc/cleverdb-agent
ADD ./assets/connect.conf /etc/cleverdb-agent/connect.conf
ADD ./assets/ports.conf /etc/cleverdb-agent/ports.conf

ADD ./scripts/startup.sh /opt/startup.sh
CMD ["/bin/bash", "/opt/startup.sh"]
