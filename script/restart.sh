#!/bin/sh 
cd /home/webuser/shannonline/current/
/usr/bin/mongrel_rails cluster::start -C /etc/mongrel_cluster/mongrel_cluster.yml

