FROM alpine:3.12

RUN apk update && apk upgrade


RUN apk add --no-cache mysql mysql-client sudo

# RUN mkdir -p /run/mysqld/

# RUN addgroup mysql mysql
COPY my.cnf /etc/mysql/my.cnf
# COPY mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY wp_databases.sql .
COPY mys.sh .
RUN sudo chmod -R 755 /var/lib/mysql/
RUN chmod +x mys.sh

VOLUME ["/var/lib/mysql"]

EXPOSE 3306

ENTRYPOINT ./mys.sh
