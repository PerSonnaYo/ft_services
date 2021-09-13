if [ ! -d "/run/mysqld" ]; then
  mkdir -p /run/mysqld
fi
# cp -rp /var/run/mysqld /var/run/mysqld.bak
# mysql_install_db --user=root > /dev/null

# cat << EOF > /tmp/sql
# CREATE DATABASE wordpress;
# GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'groot' WITH GRANT OPTION;
# USE wordpress;
# FLUSH PRIVILEGES;
# EOF

# /usr/bin/mysqld --user=root --bootstrap --verbose=0 < /tmp/sql
# rm -f /tmp/sql

# exec /usr/bin/mysqld --user=root
mysql_install_db --user=root
/usr/bin/mysqld_safe & sleep 5
mysql -u root -e "CREATE DATABASE wordpress;"
mysql -u root -e "CREATE USER 'root'@'%' IDENTIFIED BY 'groot'; GRANT ALL PRIVILEGES ON *.* TO root@'%' WITH GRANT OPTION; USE wordpress; FLUSH PRIVILEGES;"
mysql -u root --skip-password < wp_databases.sql
killall mysqld
sleep 10s
/usr/bin/mysqld_safe --datadir=/var/lib/mysql
# mysql_install_db --user=root --ldata=/var/lib/mysql

# cat > /var/www/sql << eof
# CREATE DATABASE wordpress;
# FLUSH PRIVILEGES;
# GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;
# FLUSH PRIVILEGES;
# eof

# /usr/bin/mysqld --console --init_file=/var/www/sql
# if [ ! -f /var/lib/mysql/ibdata1 ]; then
# 	mysql_install_db --user=root

# 	/usr/bin/mysqld_safe --user=root &
# 	sleep 10s

#     echo "CREATE DATABASE wordpress;" | mysql && \
# 	echo "GRANT ALL PRIVILEGES ON *.* TO root@'%' IDENTIFIED BY 'root' WITH GRANT OPTION; USE wordpress; FLUSH PRIVILEGES;" | mysql

# 	killall mysqld
# 	sleep 10s
# fi

# /usr/bin/mysqld_safe --datadir=/var/lib/mysql

# /usr/bin/mysqld_safe
# openrc default
# /etc/init.d/mariadb setup
# rc-service mariadb start
# echo "CREATE DATABASE my_db" | mysql && \
# echo "GRANT ALL PRIVILEGES ON my_db.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION" | mysql && \
# echo "FLUSH PRIVILEGES;" | mysql

# rc-service mariadb stop
# exec mysqld_safe