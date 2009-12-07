#!/bin/sh 
cd /home/webuser/shannonline/current/
/usr/bin/mongrel_rails cluster::configure -e production -p 3001 -N 1 -c /home/webuser/shannonline/current -a 127.0.0.1
/usr/bin/mongrel_rails cluster::start

