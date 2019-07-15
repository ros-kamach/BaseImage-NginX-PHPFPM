FROM centos:centos7

MAINTAINER Rostylav Kamach <ros.kamach@gmail.com>

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    yum install -y epel-release && yum update -y && \
    yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
    yum-config-manager --enable remi-php70 && \
    yum install nginx yum-utils -y && \
    yum --enablerepo=remi,remi-php70 install -y \
    php-cli php-common php-mysql php-gd \
    php-fpm  php-xml php-cgi php-mcrypt \
    php-curl php-json php-mbstring php-intl && \
    ###
    yum clean all && \
    rm -rf /var/cache/yum /var/log/yum.log && \
    ###
    sed -i -e 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php.ini && \
    sed -i -e 's/user = apache/user = nginx/g' /etc/php-fpm.d/www.conf && \
    sed -i -e 's/group = apache/group = nginx/g' /etc/php-fpm.d/www.conf && \
    ###
    rm -rf /usr/share/nginx/html/* /etc/nginx/nginx.conf && \
    mkdir -p /run/php-fpm /etc/nginx/snippets /var/lib/php/session

COPY ./template/index.php /usr/share/nginx/html/
COPY ./template/default /etc/nginx/conf.d/default.conf
COPY ./template/nginx.conf /etc/nginx/nginx.conf

COPY ./template/script.sh /usr/local/bin
RUN chmod u+x /usr/local/bin/script.sh && \ 
    chown nginx:nginx /run/php-fpm /usr/share/nginx/html /var/lib/php/session

EXPOSE 80
ENTRYPOINT ["script.sh"]