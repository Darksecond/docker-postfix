FROM debian:jessie
MAINTAINER Tim Peters <mail@darksecond.nl>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y postfix
RUN apt-get install -y rsyslog

ADD postfix /etc/postfix

ADD entrypoint.sh /entrypoint.sh

VOLUME ["/certs"]

ENTRYPOINT ["/entrypoint.sh"]

# SMTP
EXPOSE 25
# SUBMISSION
EXPOSE 587
# SMTPS
EXPOSE 465
