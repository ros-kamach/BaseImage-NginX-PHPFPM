FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y nginx && \
    ###
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/ln

RUN apt-get update && \
    apt-get install -y \
    php7.0-cli php7.0-common php7.0-mysql php7.0-gd \
    php7.0-fpm  php7.0-xml php7.0-cgi php7.0-mcrypt \
    php7.0-curl php7.0-json php7.0-mbstring php7.0-intl && \
    ###
    sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php/7.0/cli/php.ini && \
    sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php/7.0/fpm/php.ini && \
    sed -i "s/display_errors = Off/display_errors = On/" /etc/php/7.0/fpm/php.ini && \
    sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php/7.0/fpm/php.ini && \
    sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php/7.0/fpm/php.ini && \
    sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.0/fpm/php.ini && \
    sed -i -e "s/pid =.*/pid = \/var\/run\/php7.0-fpm.pid/" /etc/php/7.0/fpm/php-fpm.conf && \
    sed -i -e "s/error_log =.*/error_log = \/proc\/self\/fd\/2/" /etc/php/7.0/fpm/php-fpm.conf && \
    sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php/7.0/fpm/php-fpm.conf && \
    sed -i "s/listen = .*/listen = 9000/" /etc/php/7.0/fpm/pool.d/www.conf && \
    sed -i "s/;catch_workers_output = .*/catch_workers_output = yes/" /etc/php/7.0/fpm/pool.d/www.conf && \
    ###
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/ln

RUN apt update && \
    apt install -y curl git && \
    ###
    git clone --branch 8.8.x https://github.com/ros-kamach/drupal.git && \
    rm -rf /var/www/html drupal/.git && mv drupal/ html && mv -f html /var/www/ && cd /var/www/html && \
    ###
    curl -sS https://getcomposer.org/installer -o composer-setup.php && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    composer install --no-progress --profile --prefer-dist && \
    chown -R www-data:www-data /var/www/html && \
    ###
    apt -y clean && \
    rm -rf /var/lib/apt/lists/*

COPY ./template/default /etc/nginx/sites-available/default

COPY ./script.sh /usr/local/bin/
RUN chmod u+x /usr/local/bin/script.sh

EXPOSE 80
CMD ["script.sh"]