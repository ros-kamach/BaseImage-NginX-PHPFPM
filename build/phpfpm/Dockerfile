FROM ubuntu:16.04

RUN apt update && \
    apt install -y \
    mc nano curl \
    php7.0-cli \
    php7.0-common \
    php7.0-mysql \
    php7.0-gd \
    php7.0-fpm \
    php7.0-cgi \
    php7.0-mcrypt \
    php7.0-curl \
    php7.0-json \
    php7.0-mbstring \
    php7.0-intl

RUN sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php/7.0/cli/php.ini && \
    sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php/7.0/fpm/php.ini && \
    sed -i "s/display_errors = Off/display_errors = On/" /etc/php/7.0/fpm/php.ini && \
    sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php/7.0/fpm/php.ini && \
    sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php/7.0/fpm/php.ini && \
    sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.0/fpm/php.ini && \
    sed -i -e "s/pid =.*/pid = \/var\/run\/php7.0-fpm.pid/" /etc/php/7.0/fpm/php-fpm.conf && \
    sed -i -e "s/error_log =.*/error_log = \/proc\/self\/fd\/2/" /etc/php/7.0/fpm/php-fpm.conf && \
    sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php/7.0/fpm/php-fpm.conf && \
    sed -i "s/listen = .*/listen = 9000/" /etc/php/7.0/fpm/pool.d/www.conf && \
    sed -i "s/;catch_workers_output = .*/catch_workers_output = yes/" /etc/php/7.0/fpm/pool.d/www.conf


RUN curl -sS https://getcomposer.org/installer | php && \
    chmod 755 composer.phar && \
    mv composer.phar /usr/local/bin/composer

EXPOSE 9000

CMD ["php-fpm7.0"]