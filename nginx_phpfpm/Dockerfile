FROM ubuntu:16.04

MAINTAINER Rostyslav Kamach "ros.kamach@gmail.com"

COPY ./env.sh /

RUN \
    echo "Add Enviroment" && echo "###" && \
    . /env.sh && \
    ###
    echo "Update pachages list" && echo "###" && \
    apt-get update -y > /dev/null 2>&1 && \
    ###
    echo "Install Nginx prerequisites and repo" && echo "###" && \
    apt-get install -y curl gnupg2 ca-certificates lsb-release software-properties-common apt-utils > /dev/null 2>&1 && \
    echo "deb http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" \
    | tee /etc/apt/sources.list.d/nginx.list > /dev/null 2>&1 && \
    curl -fsSL https://nginx.org/keys/nginx_signing.key | apt-key add - > /dev/null 2>&1 && \
    ###
    echo "Install PHP Repo" && echo "###" && \
    LC_ALL=C.UTF-8 add-apt-repository -y -u ppa:ondrej/php > /dev/null 2>&1 && \
    ###
    echo "Update pachages list" && echo "###" && \
    apt-get update -y > /dev/null 2>&1 && \
    ###
    echo "Install Nginx And PHP-FPM" && echo "###" && \
    apt-get install -y --no-install-recommends \
    nginx php7.2-fpm > /dev/null 2>&1 && \
    ###
    echo "Clean packages and repo" && echo "###" && \
    apt-get remove -y curl gnupg2 ca-certificates lsb-release software-properties-common apt-utils > /dev/null 2>&1 && \
    apt-get clean autoclean autoremove && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /env.sh > /dev/null 2>&1 && \
    ###
    echo "PHP Configuration" && echo "###" && \
    sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=${PHP_CGI_PATHINFO}/" /etc/php/7.2/fpm/php.ini && \
    sed -i "s/listen = .*/${PHP_LISTEN}/" /etc/php/7.2/fpm/pool.d/www.conf && \
    ###
    echo "TimeZone Configuration" && echo "###" && \
    ln -snf  /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime && \
	echo "${TIME_ZONE}" > /etc/timezone

COPY ./template/index.php /usr/share/nginx/html/
COPY ./template/default /etc/nginx/conf.d/default.conf

COPY ./template/script.sh /usr/local/bin/
RUN chmod u+x /usr/local/bin/script.sh

EXPOSE 80
ENTRYPOINT ["script.sh"]
HEALTHCHECK --interval=5m --timeout=3s CMD curl -f http://localhost/ || exit 1
