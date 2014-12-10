FROM       centos:centos7
MAINTAINER Jose Lopez "jlope001@gmail.com"

# Enable EPEL Repository and base packages
RUN yum -y install http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-2.noarch.rpm
RUN yum -y update
RUN yum -y install policycoreutils wget

# install plex media server
RUN wget https://downloads.plex.tv/plex-media-server/0.9.11.1.678-c48ffd2/plexmediaserver-0.9.11.1.678-c48ffd2.x86_64.rpm
RUN yum localinstall -y --nogpgcheck plexmediaserver-0.9.11.1.678-c48ffd2.x86_64.rpm
RUN yum clean all
RUN rm plexmediaserver-0.9.11.1.678-c48ffd2.x86_64.rpm

# create plex media user
RUN useradd media
RUN usermod -u 1000 media
RUN groupmod -g 1000 media

# setup folders
RUN mkdir -p /config/plex
RUN chown -R media:media /config/plex
RUN chown -R media:media /media

EXPOSE 32400 1900 5353 32410 32412 32413 32414 32469

ADD ./scripts/startup.sh /opt/startup.sh
CMD ["/bin/bash", "/opt/startup.sh"]

