FROM alpine

MAINTAINER Rostyslav Kamach "ros.kamach@gmail.com"

COPY ./env.sh /
COPY ./script.sh /

RUN \
    echo "Add Enviroment" && echo "###" && \
	source ./env.sh && \
	echo "Update pachages" && echo "###" && \
    apk update > /dev/null 2>&1 && apk upgrade > /dev/null 2>&1 && \
    echo "Install required packages" && echo "###" && \
	apk add --no-cache bash curl tzdata supervisor > /dev/null 2>&1 && \
    echo "Install PHP Repo" && echo "###" && \
    curl -o /etc/apk/keys/phpearth.rsa.pub https://repos.php.earth/alpine/phpearth.rsa.pub > /dev/null 2>&1 && \
    echo "https://repos.php.earth/alpine/v3.9" >> /etc/apk/repositories && \
	echo "Install Nginx prerequisites and repo" && echo "###" && \
	printf "%s%s%s\n" \
    "http://nginx.org/packages/alpine/v" \
    `egrep -o '^[0-9]+\.[0-9]+' /etc/alpine-release` \
    "/main" | tee -a /etc/apk/repositories && \
	curl -o /tmp/nginx_signing.rsa.pub https://nginx.org/keys/nginx_signing.rsa.pub > /dev/null 2>&1 && \
	mv /tmp/nginx_signing.rsa.pub /etc/apk/keys/ && \
	echo "Install Nginx And PHP-FPM" && echo "###" && \
	apk add --no-cache nginx php7.2-fpm > /dev/null 2>&1 && \
	cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
	echo "${TIMEZONE}" > /etc/timezone && \
	echo "Clean packages and cache" && echo "###" && \
	apk del curl tzdata > /dev/null 2>&1 && rm -rf /var/cache/apk/* > /dev/null 2>&1 && \
    echo "PHP Configuration" && echo "###" && \
	sed -i "s|;*date.timezone =.*|date.timezone = ${TIMEZONE}|i" /etc/php/7.2/php.ini && \
	sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php/7.2/php.ini && \
	sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${MAX_UPLOAD}|i" /etc/php/7.2/php.ini && \
	sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php/7.2/php.ini && \
	sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php/7.2/php.ini && \
	sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= 0|i" /etc/php/7.2/php.ini && \
    mkdir -p /usr/local/var/log/php7.2/ \
	/usr/local/var/run/ /usr/share/nginx/html/ && \
	chown -R nginx:nginx /usr/share/nginx/html && chmod u+x /script.sh

COPY ./template/php-fpm.conf /etc/php/7.2/
COPY ./template/www.conf /etc/php/7.2/php-fpm.d/
COPY ./template/default.conf /etc/nginx/conf.d/
COPY ./template/nginx.conf /etc/nginx/
COPY ./template/index.php /usr/share/nginx/html/
COPY ./template/supervisor.conf /etc/supervisor/conf.d/supervisord.conf

#CMD ["supervisord", "--nodaemon", "--configuration", "/etc/supervisor/conf.d/supervisord.conf"]
ENTRYPOINT ["./script.sh"]
