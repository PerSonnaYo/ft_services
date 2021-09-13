FROM alpine:3.7
RUN apk update && apk upgrade
RUN apk add wget supervisor nginx php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session

RUN wget http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.2-all-languages.tar.gz \
	&& tar zxvf phpMyAdmin-5.0.2-all-languages.tar.gz \
	&& rm phpMyAdmin-5.0.2-all-languages.tar.gz \
	&& mv phpMyAdmin-5.0.2-all-languages /usr/share/phpmyadmin \
	&& rm -rf /var/cache/apk/*

COPY ./config.inc.php /usr/share/phpmyadmin/config.inc.php
COPY ./supervisor.conf /etc/supervisord.conf
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

RUN mkdir -p /run/nginx
EXPOSE 5000

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
