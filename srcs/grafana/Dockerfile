FROM alpine:3.12

RUN apk update && apk upgrade
RUN apk add wget

RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.32-r0/glibc-2.32-r0.apk
RUN apk add glibc-2.32-r0.apk

RUN	wget https://dl.grafana.com/oss/release/grafana-7.3.6.linux-amd64.tar.gz \
		&& tar -zxvf grafana-7.3.6.linux-amd64.tar.gz && rm grafana-7.3.6.linux-amd64.tar.gz

ADD srcs/datasources.yaml /grafana-7.3.6/conf/provisioning/datasources/
ADD srcs/dashboard.yaml /grafana-7.3.6/conf/provisioning/dashboards/
ADD ./dashboards/ /grafana-7.3.6/conf/provisioning/dashboards/
EXPOSE 3000
CMD cd grafana-7.3.6/bin/ && ./grafana-server