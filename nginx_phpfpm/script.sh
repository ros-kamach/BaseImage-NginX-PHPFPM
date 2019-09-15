#!/bin/bash
supervisord --nodaemon --configuration /etc/supervisor/conf.d/supervisord.conf
FILE=/drush.sh
if test -f "$FILE"; then
    echo "$FILE exist"
    bash /drush.sh
fi
