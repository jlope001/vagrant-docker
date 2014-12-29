FROM       centos:centos7
MAINTAINER Jose Lopez "jlope001@gmail.com"

# install unzip dependencies
RUN yum install -y wget unzip net-tools

# download wordpress
RUN wget http://wordpress.org/latest.zip
RUN unzip -q latest.zip -d /var/www/
RUN mkdir -p /var/www/wordpress/wp-content/uploads

ADD ./assets/wp-config.php /var/www/wordpress/wp-config.php

ADD ./scripts/startup.sh /opt/startup.sh
CMD ["/bin/bash", "/opt/startup.sh"]
