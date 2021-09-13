FROM alpine:3.12

RUN apk update && apk upgrade

RUN apk add influxdb curl

COPY start.sh .

RUN chmod +x start.sh

VOLUME [ "/var/lib/influxdb" ]
EXPOSE 8086

# CMD [ "./start.sh" ]
CMD ./start.sh