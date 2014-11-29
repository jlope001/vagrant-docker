FROM       ubuntu:14.04
MAINTAINER Jose Lopez "jlope001@gmail.com"

# install system
RUN apt-get update

# sertup locales
RUN locale-gen en_US en_US.UTF-8
RUN dpkg-reconfigure locales

# setup dependencies
RUN apt-get install -y --force-yes apt-transport-https wget curl mysql-client-5.6 openssh-client

# setup cleverdb
RUN echo 'deb https://apt.cleverdb.io stable main' > /etc/apt/sources.list.d/cleverdb-agent.list
RUN wget -O - https://apt.cleverdb.io/key.asc | apt-key add -
RUN apt-get update
RUN apt-get install -y --force-yes cleverdb-agent

# setup folders
RUN mkdir -p /etc/cleverdb-agent
ADD ./assets/connect.conf /etc/cleverdb-agent/connect.conf
ADD ./assets/ports.conf /etc/cleverdb-agent/ports.conf

ADD ./scripts/startup.sh /opt/startup.sh
CMD ["/bin/bash", "/opt/startup.sh"]
