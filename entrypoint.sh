#!/bin/bash

#Run the basic setup script
./setup.sh

ln -s /home/core/mentees_domain.txt /var/www/html/mentees_domain.txt

service cron start
service apache2 start