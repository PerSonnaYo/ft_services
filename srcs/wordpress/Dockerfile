FROM alpine:3.12

RUN apk upgrade
RUN	apk add wget sudo nginx php7 php7-fpm php7-mysqli php7-mbstring php7-json php7-session supervisor \
	lighttpd php7-common php7-iconv php7-gd php7-curl php7-xml php7-imap php7-cgi \
	fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix \
	php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom
#RUN apk add wget nginx supervisor lighttpd php7-common php7-session php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom

RUN mkdir -p /run/nginx
RUN mkdir -p /var/run/php
#COPY www.conf /etc/php7/php-fpm.d

# # Установка wordpress
RUN mkdir -p /usr/share/webapps/ && cd /usr/share/webapps/ && \
    wget http://wordpress.org/latest.tar.gz && tar -xzvf latest.tar.gz && \
    rm latest.tar.gz && chown -R lighttpd /usr/share/webapps/ && \
    ln -s /usr/share/webapps/wordpress/ /var/www/localhost/htdocs/wordpress

# # Копирование и предоставление прав
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY supervisor.conf /etc/supervisord.conf
COPY wp-config.php /usr/share/webapps/wordpress/
RUN sudo chmod -R 777 /usr/share/webapps/wordpress/wp-content
# RUN addgroup root root
# RUN chown -R root:root /usr/share/webapps/wordpress/wp-content
# RUN mkdir -p /usr/share/webapps/ && cd /usr/share/webapps/ && \
#     wget https://wordpress.org/latest.tar.gz && tar -xzvf latest.tar.gz && \
#     rm -rf latest.tar.gz && chown -R lighttpd /usr/share/webapps/ && \
#     ln -s /usr/share/webapps/wordpress/ /var/www/localhost/htdocs/wordpress

# COPY ./wp-config.php /usr/share/webapps/wordpress/
# COPY ./supervisor.conf /etc/supervisord.conf
# RUN rm /etc/nginx/conf.d/default.conf
# COPY ./nginx.conf /etc/nginx/conf.d/default.conf
# RUN mkdir -p /run/nginx
# RUN mkdir -p /var/run/php

# Открытие портов
EXPOSE 5050

# Запуск
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]