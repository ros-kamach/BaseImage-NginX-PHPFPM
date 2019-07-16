FROM alpine

COPY ./env.sh /
RUN apk update && apk upgrade && \
    source ./env.sh && \
    apk add \
	curl \
        bash \
	tzdata \
	php7-cli php7-common php7-mysqlnd php7-mysqli php7-gd \
    	php7-fpm  php7-xml php7-cgi php7-mcrypt \
    	php7-curl php7-json php7-mbstring php7-intl php7-opcache && \
 	cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
	echo "${TIMEZONE}" > /etc/timezone && \
	apk del tzdata && \
 	rm -rf /var/cache/apk/*

RUN mkdir -p /usr/local/var/log/php7/
RUN mkdir -p /usr/local/var/run/
COPY ./template/php-fpm.conf /etc/php7/
COPY ./template/www.conf /etc/php7/php-fpm.d/

RUN sed -i "s|;*date.timezone =.*|date.timezone = ${TIMEZONE}|i" /etc/php7/php.ini && \
	sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php7/php.ini && \
	sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${MAX_UPLOAD}|i" /etc/php7/php.ini && \
	sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php7/php.ini && \
	sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php7/php.ini && \
	sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= 0|i" /etc/php7/php.ini

RUN apk add nginx
COPY ./template/default.conf /etc/nginx/conf.d/
COPY ./template/nginx.conf /etc/nginx/

RUN mkdir -p /usr/share/nginx/html/ && chown -R nginx:nginx /usr/share/nginx/html
COPY ./template/index.php /usr/share/nginx/html/

RUN apk add supervisor \
 && rm -rf /var/cache/apk/*

COPY ./template/supervisor.conf /etc/supervisor/conf.d/supervisord.conf
COPY ./script.sh /
RUN chmod u+x /script.sh

#CMD ["supervisord", "--nodaemon", "--configuration", "/etc/supervisor/conf.d/supervisord.conf"]
ENTRYPOINT ["./script.sh"]
