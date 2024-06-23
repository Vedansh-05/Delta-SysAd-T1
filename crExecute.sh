#!/bin/bash

echo "0 0 * * * displayStatus" >> /etc/crontab

echo "10 10 * 5-7 */3,0 crDeregister.sh" >> /etc/crontab