#!/bin/bash

# set webserver password
echo web:${WEBSERVER_PASSWORD-web} | /usr/sbin/chpasswd

# remove password forom environment
unset WEBSERVER_PASSWORD

# start ssh service
service ssh start

# Create webroot if not present to prevent warnings
sudo -u web mkdir -p /var/www/html/web

# finally, run apache
apache2-foreground
