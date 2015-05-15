#!/bin/bash

function cleanup {
echo Stopping postfix
postfix stop

echo Stopping syslog
kill $(cat /var/run/rsyslogd.pid)

exit
}

# TODO: trap SIGHUP and reload (postmap, etc)
trap cleanup SIGKILL SIGTERM SIGINT SIGHUP

echo Starting syslog
rsyslogd

echo Configuring postfix
echo $MAILNAME > /etc/mailname
postconf -e myhostname=$(hostname -f)
postconf -e mydestination="$(hostname -f), localhost.$MAILNAME, localhost.localdomain, localhost"
# Certificates
CERTNAME=`hostname -f | sed 's/\./-/g'`
cp /certs/$CERTNAME.pem /etc/ssl/certs/postfix.pem
cp /certs/$CERTNAME.key /etc/ssl/private/postfix.key
chmod 000 /certs # Make /certs inaccessible

# TODO milters
# TODO postmap

echo Starting postfix
postfix start

touch /var/log/mail.log
tail -F /var/log/mail.log &
wait
