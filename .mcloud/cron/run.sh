#!/bin/bash

echo "Waiting while php starts"
while ! echo exit | nc -z php 9000; do
    echo ".";
    sleep 3;
done

echo "Starting cron"
crontab /var/www/.mcloud/cron/crontab.txt

@me ready in 3s
cron -f