#!/bin/sh
cd /home/webuser/shannonline/current
/usr/bin/rake db2s3:backup:full RAILS_ENV=production