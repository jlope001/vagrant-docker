FROM centos:centos7

MAINTAINER Jose Lopez "jlope001@gmail.com"

RUN yum -y update && yum -y clean all

# install dependencies
RUN yum install -y wget mysql which openssh-clients
RUN yum -y install rsyslog && echo 'input(type="imuxsock" HostName="localhost" Socket="/dev/log")' >> /etc/rsyslog.conf

# install agent
ADD ./assets/yum.repo.conf /etc/yum.repos.d/cleverdb-agent.repo
RUN  yum -y install cleverdb-agent

# setup folders
RUN mkdir -p /etc/cleverdb-agent
ADD ./assets/connect.conf /etc/cleverdb-agent/connect.conf
ADD ./assets/ports.conf /etc/cleverdb-agent/ports.conf

ADD ./scripts/startup.sh /opt/startup.sh
CMD ["/bin/bash", "/opt/startup.sh"]
