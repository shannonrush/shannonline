#!/bin/sh 
cd /home/webuser/shannonline/current/
/usr/bin/mongrel_rails cluster::restart -C /home/webuser/shannonline/shared/config/mongrel_cluster.yml

