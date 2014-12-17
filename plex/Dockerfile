FROM       centos:centos7
MAINTAINER Jose Lopez "jlope001@gmail.com"

RUN yum -y update && yum -y clean all
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

ADD ./scripts/startup.sh /opt/startup.sh
CMD ["/bin/bash", "/opt/startup.sh"]

