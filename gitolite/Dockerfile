FROM centos:centos7

MAINTAINER Jose Lopez "jlope001@gmail.com"

# setup ssh server
RUN yum install -y openssh-server sudo
RUN ssh-keygen -b 1024 -t rsa -f /etc/ssh/ssh_host_key
RUN ssh-keygen -b 1024 -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -b 1024 -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN mkdir /var/run/sshd
RUN sed -ri 's/#PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
RUN sed -ri 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
RUN localedef --no-archive -i en_US -f UTF-8 en_US.UTF-8

# create git user
RUN useradd --system --create-home --shell /bin/bash git
RUN echo -n 'git:git' | chpasswd
RUN chown git:git /home/git
RUN chmod 700 /home/git

# install git-to-lite
RUN yum install -y 'perl(Data::Dumper)'
RUN yum install -y git-core

# run setup as git user
USER git
ENV HOME /home/git
WORKDIR /home/git
RUN mkdir bin
RUN git clone git://github.com/sitaramc/gitolite
RUN gitolite/install -ln

# revert back to root to complete setup
USER root

EXPOSE 22

ADD ./scripts/startup.sh /opt/startup.sh
CMD ["/bin/bash", "/opt/startup.sh"]
