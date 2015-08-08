FROM       centos:centos7
MAINTAINER Jose Lopez "jlope001@gmail.com"

# used to help use ssl setup on all containers that require ssl information
#
# example folder setup:
#
#
# assets/
#  - domains/
#    - sub.host.com/
#      - sub.host.com.crt
#      - sub.host.com.ca
#      - sub.host.com.key
#

RUN mkdir -p /etc/ssl
ADD ./assets/domains /etc/ssl/.

