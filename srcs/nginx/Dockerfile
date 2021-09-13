FROM alpine:3.7

RUN apk update && apk upgrade

RUN apk add nginx --no-cache openssl openssh supervisor

ENV SSH_USER=jojo \
    SSH_PASS=test

RUN mkdir -p /var/run/sshd
RUN mkdir -p /run/nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/hek.key -out /etc/ssl/certs/hek.crt -subj "/C=RU/ST=Tatarstan/L=Kazan/O=school21/OU=student/CN=latkins"

COPY index.html /var/www/site/

# RUN adduser -D admin -g root -u 1000 test
# RUN echo 'admin:test' | chpasswd && ssh-keygen -A

RUN adduser -D $SSH_USER
RUN echo "$SSH_USER:$SSH_PASS" | chpasswd && ssh-keygen -A

COPY supervisord.conf /etc/supervisord.conf
EXPOSE 80 443 22
#CMD ["nginx", "-g", "daemon off;"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
