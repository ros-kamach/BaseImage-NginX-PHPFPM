FROM centos:7

MAINTAINER Rostyslav Kamach "ros.kamach@gmail.com"

COPY ./env.sh /
COPY ./template/nginx.repo /

RUN \
    echo "Add Enviroment" && echo "###" && \
    . /env.sh && \
    ###
    echo "Install Nginx prerequisites and repo" && echo "###" && \
    yum install -y yum-utils > /dev/null 2>&1 && \
    cat ./nginx.repo >> /etc/yum.repos.d/nginx.repo && rm ./nginx.repo > /dev/null 2>&1 && \
    ###
    echo "Install EPEL & remi repo" && echo "###" && \
    yum install -y epel-release > /dev/null 2>&1 && \
    yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm > /dev/null 2>&1 && \
    yum-config-manager --enable remi-php72 > /dev/null 2>&1 && \
    ###
    echo "Update pachages list" && echo "###" && \
    yum update -y > /dev/null 2>&1 && \
    ###
    echo "Install Nginx And PHP-FPM" && echo "###" && \
    yum install -y nginx php-fpm > /dev/null 2>&1 && \
    mkdir -p /run/php-fpm /var/lib/php/session && \
    rm -rf /usr/share/nginx/html/* /etc/nginx/nginx.conf && \
    ###
    echo "PHP Configuration" && echo "###" && \
    sed -i -e 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php.ini && \
    sed -i -e 's/user = apache/user = nginx/g' /etc/php-fpm.d/www.conf && \
    sed -i -e 's/group = apache/group = nginx/g' /etc/php-fpm.d/www.conf && \
    ###
    echo "TimeZone Configuration" && echo "###" && \
    ln -snf  /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime && \
    echo "${TIME_ZONE}" > /etc/timezone && \
    ###
    echo "Clean packages and repo" && echo "###" && \
    yum clean all > /dev/null 2>&1 && \
    rm -rf /etc/yum.repos.d/nginx.repo \
    /var/cache/yum /var/log/yum.log /var/tmp/yum-* 

COPY ./template/index.php /usr/share/nginx/html/
COPY ./template/default /etc/nginx/conf.d/default.conf
COPY ./template/nginx.conf /etc/nginx/nginx.conf

COPY ./template/script.sh /usr/local/bin
RUN chmod u+x /usr/local/bin/script.sh && \ 
    chown nginx:nginx /run/php-fpm /usr/share/nginx/html /var/lib/php/session

EXPOSE 80
ENTRYPOINT ["script.sh"]
