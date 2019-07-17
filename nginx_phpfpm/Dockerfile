FROM ubuntu:16.04

MAINTAINER Rostyslav Kamach "ros.kamach@gmail.com"

COPY ./env.sh /

    ### Enviroment
RUN . /env.sh && \
    ### Update pachages list
    apt-get update -y && \
    ### Nginx prerequisites
    apt-get install -y curl gnupg2 ca-certificates lsb-release software-properties-common apt-utils && \
    echo "deb http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" \
    | tee /etc/apt/sources.list.d/nginx.list && \
    curl -fsSL https://nginx.org/keys/nginx_signing.key | apt-key add - && \
    ### PHP Repo
    LC_ALL=C.UTF-8 add-apt-repository -y -u ppa:ondrej/php && \
    ### Update pachages list
    apt-get update -y && \
    ### Install Nginx & PHP-FPM
    apt-get install -y --no-install-recommends \
    nginx \
    php7.2-fpm && \
    ### Remove packages and clean
    apt-get remove -y curl gnupg2 ca-certificates lsb-release software-properties-common apt-utils && \
    apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /env.sh && \
    ### PHP Configuration
    sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=${PHP_CGI_PATHINFO}/" /etc/php/7.2/fpm/php.ini && \
    sed -i "s/listen = .*/${PHP_LISTEN}/" /etc/php/7.2/fpm/pool.d/www.conf && \
    ### TimeZone
    ln -snf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime && echo ${TIME_ZONE} > /etc/timezone

COPY ./template/index.php /usr/share/nginx/html/
COPY ./template/default /etc/nginx/conf.d/default.conf

COPY ./template/script.sh /usr/local/bin/
RUN chmod u+x /usr/local/bin/script.sh

EXPOSE 80
ENTRYPOINT ["script.sh"]