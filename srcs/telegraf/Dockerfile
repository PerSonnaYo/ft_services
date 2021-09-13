FROM alpine:3.12

RUN apk update && apk upgrade
RUN apk add wget

ADD	https://dl.influxdata.com/telegraf/releases/telegraf-1.13.3-static_linux_amd64.tar.gz ./

RUN tar -C . -xzf telegraf-1.13.3-static_linux_amd64.tar.gz && \
        chmod +x telegraf/* && \
        cp telegraf/telegraf /usr/bin/ && \
        rm -rf *.tar.gz* telegraf/ 

#ADD telegraf.conf	/etc/telegraf/telegraf.conf

CMD exec /usr/bin/telegraf $@