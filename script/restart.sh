#!/bin/sh 
cd /home/webuser/shannonline/current/
/usr/bin/mongrel_rails cluster::start -C config/mongrel_cluster.yml

