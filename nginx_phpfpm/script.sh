#!/bin/bash
php-fpm7 --nodaemonize -R
nginx -g 'daemon off;' 