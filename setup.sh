#! /bin/sh

tmp=1
retr=0
while true
do
	minikube delete;
	minikube start --vm-driver=virtualbox --cpus=4 --memory=3G --disk-size=30G
	minikube status
	tmp=$?
	((retr++))
	if [ $tmp -eq "0" ]
	then
		echo 	">>>>>>>>>>>>>>>> MINIKUBE STARTED <<<<<<<<<<<<<<<<<<<<< "
		break
	fi
		echo	">>>>>>>>>> MINIKUBE FAILED TO START. RETRY... <<<<<<<<<< "
done


kubectl delete --all svc
kubectl delete --all deployments
kubectl delete --all pods
kubectl delete --all PersistentVolumeClaim
kubectl delete --all PersistentVolume
minikube addons enable metrics-server
minikube addons enable dashboard
minikube addons enable metallb


# Docker containers
kubectl apply -f srcs/metallb-configmap.yaml
eval $(minikube docker-env)
printf "ftps: "
docker build -t ftp-web3 ./srcs/ftps > /dev/null 2>>errlog.txt && { printf "Success!\n"; kubectl apply -f ./srcs/ftps/ftps.yaml >> log.log 2>> errlog.txt; } || printf "Fail!\n"
printf "mysql: "
docker build -t mysql1 ./srcs/mysql > /dev/null 2>>errlog.txt && { printf "Success!\n"; kubectl apply -f ./srcs/mysql/mysql.yaml >> log.log 2>> errlog.txt; } || printf "Fail!\n"
printf "wordpress: "
docker build -t wordpress-web5 ./srcs/wordpress > /dev/null 2>>errlog.txt && { printf "Success!\n"; kubectl apply -f ./srcs/wordpress/wordpress.yaml >> log.log 2>> errlog.txt; } || printf "Fail!\n"
printf "phpmyadmin: "
docker build -t phpmyadmin-web3 ./srcs/phpmyadmin > /dev/null 2>>errlog.txt && { printf "Success!\n"; kubectl apply -f ./srcs/phpmyadmin/phpmyadmin.yaml >> log.log 2>> errlog.txt; } || printf "Fail!\n";
printf "influxdb: "
docker build -t influxdb-web srcs/influxdb > /dev/null 2>>errlog.txt && { printf "Success!\n"; kubectl apply -f srcs/influxdb/influxdb.yaml >> log.log 2>> errlog.txt; } || printf "Fail!\n"
printf "telegraf: "
docker build -t telegraf-web srcs/telegraf > /dev/null 2>>errlog.txt && { printf "Success!\n"; kubectl apply -f ./srcs/telegraf/telegraf-config.yaml && kubectl apply -f ./srcs/telegraf/telegraf-secrets.yaml && kubectl apply -f ./srcs/telegraf/telegraf-deployment.yaml >> log.log 2>> errlog.txt; } || printf "Fail!\n"
printf "grafana: "
docker build -t grafana ./srcs/grafana > /dev/null 2>>errlog.txt && { printf "Success!\n"; kubectl apply -f ./srcs/grafana/grafana.yaml >> log.log 2>> errlog.txt; } || printf "Fail!\n"
printf "nginx: "
docker build -t nginx-web4 ./srcs/nginx > /dev/null 2>>errlog.txt && printf "Success!\n" || printf "Fail!\n"; kubectl apply -f ./srcs/nginx/nginx.yaml >> log.log 2>> errlog.txt


# Make Minikube launch the Web Dashboard everytime the Minikube VM starts
MKB_IP=`minikube ip`;
echo "Minikube ip address = $MKB_IP"
minikube dashboard
