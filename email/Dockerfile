FROM       centos:centos7
MAINTAINER Jose Lopez "jlope001@gmail.com"

# postfix / dovecot
RUN yum -y update && yum -y clean all
RUN yum --enablerepo=centosplus install -y postfix
RUN yum -y install dovecot dovecot-mysql cyrus-sasl-plain mailx

# rsyslog
RUN yum -y install rsyslog && echo 'input(type="imuxsock" HostName="localhost" Socket="/dev/log")' >> /etc/rsyslog.conf

# mysql
RUN rpm -ivh http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
RUN yum install -y mysql

ADD ./assets/my.cnf /etc/my.cnf
ADD ./assets/mysql-virtual_domains.cf /etc/postfix/mysql-virtual_domains.cf
ADD ./assets/mysql-virtual_forwardings.cf /etc/postfix/mysql-virtual_forwardings.cf
ADD ./assets/mysql-virtual_mailboxes.cf /etc/postfix/mysql-virtual_mailboxes.cf
ADD ./assets/mysql-virtual_email2email.cf /etc/postfix/mysql-virtual_email2email.cf
RUN chmod o= /etc/postfix/mysql-virtual_*.cf
RUN chgrp postfix /etc/postfix/mysql-virtual_*.cf

ADD ./assets/dovecot.conf /etc/dovecot/dovecot.conf
ADD ./assets/dovecot-sql.conf.ext /etc/dovecot/dovecot-sql.conf.ext

ADD ./assets/aliases /etc/aliases

RUN groupadd -g 5000 vmail
RUN useradd -g vmail -u 5000 vmail -d /home/vmail -m

# dovecot settings
RUN postconf -e 'myhostname = server.example.com'
RUN postconf -e 'mydestination = $myhostname, localhost, localhost.localdomain'
RUN postconf -e 'mynetworks = 127.0.0.0/8'
RUN postconf -e 'inet_interfaces = all'
RUN postconf -e 'message_size_limit = 30720000'
RUN postconf -e 'virtual_alias_domains ='
RUN postconf -e 'virtual_alias_maps = proxy:mysql:/etc/postfix/mysql-virtual_forwardings.cf, mysql:/etc/postfix/mysql-virtual_email2email.cf'
RUN postconf -e 'virtual_mailbox_domains = proxy:mysql:/etc/postfix/mysql-virtual_domains.cf'
RUN postconf -e 'virtual_mailbox_maps = proxy:mysql:/etc/postfix/mysql-virtual_mailboxes.cf'
RUN postconf -e 'virtual_mailbox_base = /home/vmail'
RUN postconf -e 'virtual_uid_maps = static:5000'
RUN postconf -e 'virtual_gid_maps = static:5000'
RUN postconf -e 'smtpd_sasl_type = dovecot'
RUN postconf -e 'smtpd_sasl_path = private/auth'
RUN postconf -e 'smtpd_sasl_auth_enable = yes'
RUN postconf -e 'broken_sasl_auth_clients = yes'
RUN postconf -e 'smtpd_sasl_authenticated_header = yes'
RUN postconf -e 'smtpd_recipient_restrictions = permit_mynetworks, permit_sasl_authenticated, reject_unauth_destination'
RUN postconf -e 'smtpd_use_tls = yes'
RUN postconf -e 'smtpd_tls_cert_file = </etc/pki/dovecot/certs/dovecot.pem'
RUN postconf -e 'smtpd_tls_key_file = </etc/pki/dovecot/private/dovecot.pem'
RUN postconf -e 'proxy_read_maps = $local_recipient_maps $mydestination $virtual_alias_maps $virtual_alias_domains $virtual_mailbox_maps $virtual_mailbox_domains $relay_recipient_maps $relay_domains $canonical_maps $sender_canonical_maps $recipient_canonical_maps $relocated_maps $transport_maps $mynetworks'
RUN postconf -e 'virtual_transport = dovecot'
RUN postconf -e 'dovecot_destination_recipient_limit = 1'

# sendgrid settings
RUN postconf -e 'smtp_sasl_auth_enable = yes'
RUN postconf -e 'smtp_sasl_security_options = noanonymous'
RUN postconf -e 'smtp_tls_security_level = encrypt'
RUN postconf -e 'header_size_limit = 4096000'
RUN postconf -e 'relayhost = [smtp.sendgrid.net]:587'

RUN chgrp dovecot /etc/dovecot/dovecot-sql.conf.ext
RUN chmod o= /etc/dovecot/dovecot-sql.conf.ext

EXPOSE 110 25

ADD ./scripts/startup.sh /opt/startup.sh
CMD ["/bin/bash", "/opt/startup.sh"]
