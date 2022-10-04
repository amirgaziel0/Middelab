#!/bin/bash


######################## ci


#Build Image from file
docker build -t net4u_nginx . 2>/dev/null

#Create continer Frome the image

docker run --name net4u_continer -d -p 80 -v /home/amir/Middle_Lab/web/:/usr/share/nginx/html net4u_nginx 2>/dev/null

port_web="$(docker ps | grep net4u_ | awk '{print $11}' | sed 's/://g' | awk -v FS='->' '{print $1}')"
ip_web="$(ip -f inet addr show enp0s3 | sed -En -e 's/.*inet ([0-9.]+).*/\1/p')"



#Check  health  (http, telnet, curl, wget)

echo "Check  CURL"
curl  $ip_web:$port_web

echo "Check PORT " $port_web
nmap -sT -p- $ip_web | grep $port_web



#Uplode to  DockerHub

sudo docker login

docker tag net4u_nginx amirgaziel0/net4u_lab1:net4u_nginx

docker push amirgaziel0/net4u_lab1:net4u_nginx

