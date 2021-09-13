FROM alpine:3.12

# RUN apk add --no-cache vsftpd vim openrc openssl

# COPY vsftpd.conf /etc/
# COPY index.html /var/www/
# COPY start.sh .

# RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/ftps-selfsigned-rsa.key -out /etc/ssl/certs/ftps-selfsigned-rsa.crt -subj "/C=FR/L=Paris/O=42/CN=ft_services.com"

# RUN chmod +x start.sh
# CMD ./start.sh

RUN apk update && apk upgrade &&  apk --update --no-cache add vsftpd openssl sudo

ENV FTP_USER=user \
    FTP_PASS=test

RUN openssl req -x509 -nodes -days 10 -subj "/C=RU/ST=Kazan/L=Kazan/O=21/OU=21School/CN=localhost" \
    -newkey rsa:1024 -keyout /etc/ssl/private/hek.key -out /etc/ssl/certs/hek.pem

COPY start.sh /usr/sbin/
# RUN rm -rf /etc/vsftpd/vsftpd.conf
# RUN touch /etc/vsftpd/vsftpd.conf
EXPOSE 21 60060

RUN chmod +x /usr/sbin/start.sh

CMD /usr/sbin/start.sh