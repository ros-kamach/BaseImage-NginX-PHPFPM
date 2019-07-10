FROM ubuntu:16.04

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    apt-get update -y && \
    apt-get install -y \
    nginx \
    curl \
    git \
    unzip \
    ###
    php7.0-cli php7.0-common php7.0-mysql php7.0-gd \
    php7.0-fpm  php7.0-xml php7.0-cgi php7.0-mcrypt \
    php7.0-curl php7.0-json php7.0-mbstring php7.0-intl && \
    ###
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    ###
    sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php/7.0/fpm/php.ini && \
    sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php/7.0/fpm/php.ini && \
    sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.0/fpm/php.ini && \
    sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php/7.0/fpm/php-fpm.conf && \
    sed -i "s/listen = .*/listen = 9000/" /etc/php/7.0/fpm/pool.d/www.conf

COPY ./drupal-8.7.4.zip /var/www/

WORKDIR /var/www/
RUN unzip drupal-8.7.4.zip && \
    rm -rf html drupal-8.7.4/.git && mv drupal-8.7.4/ html && rm drupal-8.7.4.zip && cd html/ && \
    ###
    curl -sS https://getcomposer.org/installer -o composer-setup.php && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    composer install --no-progress --profile --prefer-dist && \
    chown -R www-data:www-data /var/www/html
  
COPY ./script.sh /usr/local/bin/
COPY ./template/default /etc/nginx/sites-available/default

RUN chmod u+x /usr/local/bin/script.sh

EXPOSE 80
CMD ["script.sh"]