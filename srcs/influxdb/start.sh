influxd run -config /etc/influxdb.conf

influx -execute "CREATE DATABASE telegraf"
influx -execute "CREATE USER telegraf WITH PASSWORD 'telegraf'"