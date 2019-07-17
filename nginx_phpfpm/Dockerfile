FROM centos:centos7

MAINTAINER Rostyslav Kamach "ros.kamach@gmail.com"

COPY ./env.sh /
COPY ./template/nginx.repo /

RUN \
    ### Enviroment
    . /env.sh && \
    ### Nginx prerequisites and repo
    yum install yum-utils && \
    cat ./nginx.repo >> /etc/yum.repos.d/nginx.repo && rm ./nginx.repo && \
    ### EPEL & remi repo
    yum install -y epel-release && \
    yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
    yum-config-manager --enable remi-php72 && \
    ### Update pachages list
    yum update && \
    ## Install Nginx And PHP-FPM
    yum install nginx php72-php-fpm -y && \
    ###
    yum clean all && \
    rm -rf /var/cache/yum /var/log/yum.log && \
    ###
    sed -i -e 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php.ini && \
    sed -i -e 's/user = apache/user = nginx/g' /etc/php-fpm.d/www.conf && \
    sed -i -e 's/group = apache/group = nginx/g' /etc/php-fpm.d/www.conf && \
    ###
    rm -rf /usr/share/nginx/html/* /etc/nginx/nginx.conf && \
    # mkdir -p /run/php-fpm /etc/nginx/snippets /var/lib/php/session
    ### TimeZone
    ln -snf  /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime && \
	echo "${TIME_ZONE}" > /etc/timezone

COPY ./template/index.php /usr/share/nginx/html/
COPY ./template/default /etc/nginx/conf.d/default.conf
COPY ./template/nginx.conf /etc/nginx/nginx.conf

COPY ./template/script.sh /usr/local/bin
RUN chmod u+x /usr/local/bin/script.sh && \ 
    chown nginx:nginx /run/php-fpm /usr/share/nginx/html /var/lib/php/session

EXPOSE 80
ENTRYPOINT ["script.sh"]