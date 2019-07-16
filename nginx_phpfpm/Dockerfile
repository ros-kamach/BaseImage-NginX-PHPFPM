FROM alpine

# Environments
ENV TIMEZONE            Europe/Kiev
ENV PHP_MEMORY_LIMIT    512M
ENV MAX_UPLOAD          50M
ENV PHP_MAX_FILE_UPLOAD 200
ENV PHP_MAX_POST        100M
ENV COMPOSER_ALLOW_SUPERUSER 1

RUN apk update \
	&& apk upgrade \
	&& apk add tzdata bash \
	php7-fpm\
	php7 \
	php7-dev \
	php7-apcu \
	php7-bcmath \
	php7-xmlwriter \
	php7-ctype \
	php7-curl \
	php7-exif \
	php7-iconv \
	php7-intl \
	php7-json \
	php7-mbstring\
	php7-opcache \
	php7-openssl \
	php7-pcntl \
	php7-pdo \
	php7-mysqlnd \
	php7-mysqli \
	php7-pdo_mysql \
	php7-pdo_pgsql \
	php7-phar \
	php7-posix \
	php7-session \
	php7-xml \
	php7-simplexml \
	php7-mcrypt \
	php7-xsl \
	php7-zip \
	php7-zlib \
	php7-dom \
	php7-redis\
	php7-tokenizer \
	php7-gd \
	php7-fileinfo \
	php7-zmq \
	php7-memcached \
	php7-xmlreader \
	# php7-cli php7-common php7-mysqlnd php7-mysqli php7-gd \
    # php7-fpm  php7-xml php7-cgi php7-mcrypt \
    # php7-curl php7-json php7-mbstring php7-intl php7-opcache && \
	cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
	echo "${TIMEZONE}" > /etc/timezone && \
	apk del tzdata && rm -rf /var/cache/apk/*

RUN mkdir -p /usr/local/var/log/php7/
RUN mkdir -p /usr/local/var/run/
COPY ./php/php-fpm.conf /etc/php7/
COPY ./php/www.conf /etc/php7/php-fpm.d/

RUN sed -i "s|;*date.timezone =.*|date.timezone = $TIMEZONE|i" /etc/php7/php.ini && \
	sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php7/php.ini && \
	sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${MAX_UPLOAD}|i" /etc/php7/php.ini && \
	sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php7/php.ini && \
	sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php7/php.ini && \
	sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= 0|i" /etc/php7/php.ini

#4.ADD-NGINX
RUN apk add nginx
COPY ./nginx/conf.d/default.conf /etc/nginx/conf.d/
COPY ./nginx/nginx.conf /etc/nginx/
COPY ./nginx/cert/ /etc/nginx/cert/

RUN mkdir -p /usr/share/nginx/html/public/
COPY ./php/index.php /usr/share/nginx/html/public/

VOLUME ["/usr/share/nginx/html", "/usr/local/var/log/php7", "/var/run/"]
WORKDIR /usr/share/nginx/html

COPY ./script.sh /usr/local/bin
RUN chmod u+x /usr/local/bin/script.sh

ENTRYPOINT ["sh","/usr/local/bin/script.sh"]