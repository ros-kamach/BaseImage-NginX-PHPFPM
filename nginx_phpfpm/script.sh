#!/bin/bash
supervisord --nodaemon --configuration /etc/supervisor/conf.d/supervisord.conf
FILE=/db_connect.sh
if test -f "$FILE"; then
    echo "$FILE exist"
    bash /db_connect.sh
fi
