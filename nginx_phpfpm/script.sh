#!/bin/bash
supervisord --nodaemon --configuration /etc/supervisor/conf.d/supervisord.conf
FILE=/usr/share/nginx/drush.sh	
if test -f "$FILE"; then	
    echo "$FILE exist"	
    bash /usr/share/nginx/drush.sh	
fi
