FROM       centos:centos7
MAINTAINER Jose Lopez "jlope001@gmail.com"

# install unzip dependencies
RUN yum install -y wget unzip net-tools

# setup wordpress
WORKDIR /var/www
RUN wget http://wordpress.org/latest.zip
RUN unzip -q latest.zip -d /var/www/
RUN mv /var/www/wordpress /var/www/blog
ADD ./assets/wp-config.php /var/www/blog/wp-config.php
RUN mkdir -p /var/www/blog/wp-content/uploads

# fix permissions - to something more standard
RUN chown -R 1000:1000 /var/www/blog

ADD ./scripts/startup.sh /opt/startup.sh
CMD ["/bin/bash", "/opt/startup.sh"]
