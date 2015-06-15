FROM       centos:centos7
MAINTAINER Jose Lopez "jlope001@gmail.com"

# install plex media server
RUN yum -y update; yum clean all
RUN rpm -Uvh https://downloads.plex.tv/plex-media-server/0.9.12.3.1173-937aac3/plexmediaserver-0.9.12.3.1173-937aac3.x86_64.rpm

# create plex media user
RUN usermod -u 1000 plex
RUN groupmod -g 1000 plex

RUN mkdir -p /config/plex
RUN mkdir -p /data

RUN chown -R plex:plex /config
RUN chown -R plex:plex /data

ADD ./scripts/startup.sh /opt/startup.sh
USER plex
CMD ["/bin/bash", "/opt/startup.sh"]

