#!/bin/sh

cat <<EOF | sudo tee /etc/vsftpd/vsftpd.conf
listen=YES
local_enable=YES
background=NO
xferlog_enable=YES
connect_from_port_20=YES
max_login_fails=15
pam_service_name=vsftpd
local_root=home/user/
seccomp_sandbox=NO
pasv_address=192.168.99.125
pasv_min_port=60060
pasv_max_port=60060
local_umask=022
dirmessage_enable=YES
xferlog_enable=YES
# Enable upload by local user.
write_enable=YES
use_localtime=YES
xferlog_file=/var/log/vsftpd.log

# Enable read by anonymous user (without username and password).
anonymous_enable=YES
anon_root=/srv/ftp
no_anon_password=YES
anon_upload_enable=YES

#SSL
pam_service_name=vsftpd
ssl_enable=YES
allow_anon_ssl=NO
force_local_data_ssl=YES
force_local_logins_ssl=YES
ssl_sslv2=YES
ssl_sslv3=YES
rsa_cert_file=/etc/ssl/certs/hek.pem
rsa_private_key_file=/etc/ssl/private/hek.key
EOF

addgroup -g 222 -S $FTP_USER
adduser -u 111 -D -G $FTP_USER -h /home/$FTP_USER -s /bin/false  $FTP_USER

echo "$FTP_USER:$FTP_PASS" | /usr/sbin/chpasswd
chown --recursive $FTP_USER:$FTP_USER /home/$FTP_USER/ -R

/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf