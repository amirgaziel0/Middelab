#!/bin/bash

# Pull Image From DockerHub
docker pull amirgaziel0/net4u_lab1:net4u_nginx


#Functions
create_continer() {

while [ true ]
do
	echo -e "Enter How many Continer you want --->"
	read continer
	for (( i = 1 ; i <=$continer ;  i++ )) {

		echo -e "Enter Port For the Continer $i --->"
		read port
		echo -e "Enter Name For The Continer $i --->"
		read name

		mkdir /home/amir/Middle_Lab/web/$name
		touch /home/amir/Middle_Lab/web/$name/index.html

		docker run --name $name -d -p $port -v /home/amir/Middle_Lab/web/$name:/usr/share/nginx/html amirgaziel0/net4u_lab1:net4u_nginx #2>/dev/null

	}
break
done
}

delete() {

docker ps

echo "With One you Want to delte?"
read continer

docker rm -f $continer


output=$(sudo COMPUTERNAME2=sudo docker ps | grep $continer | awk '{print $1}')


if [ "$output" == $continer ];  then
      echo "The Continer IS NOT DELETE !!!!"
   else
      echo "The Continer is Deleted"
   fi

}


start_stop_continer() {

echo -e "1) stop\n2) start\n3) EXIT"
read choice

if [ $choice == "1" ]
then
		output=$(docker ps | tail -n +2)
		if  [ "$output" == "" ]
                        then
				echo "Ther is not continer is Running"
			else
				docker ps 
				echo -e "with docker you want to stop -->"
                                read stop
                                docker stop $stop
			fi
elif  [ $choice == "2" ]
then
		output=$(docker ps -a | grep "Exited")
		if  [ "$output" == "" ]
			then
				echo -e "Ther is not continer is stop"
		else
               		docker ps -a | grep "Exited"
			echo "with docker you want to stop -->"
                	read start
                	docker start $start
		fi
fi
}


show_ip_port() {


echo -e "Running Continer:"

ip_web="$(ip -f inet addr show enp0s3 | sed -En -e 's/.*inet ([0-9.]+).*/\1/p')"

port_web="$(docker ps |  awk '{print $13  "/" $12}'  | sed 's/://g' | awk -v FS='->' '{print $1}')"


for i in $port_web
	do
		IFS='/' read -r -a array <<< "$i"
		echo -e "Name: ${array[0]}, IP: $ip_web, Port: ${array[1]}"
done


echo -e "Stoped Continer:"

ip_web="$(ip -f inet addr show enp0s3 | sed -En -e 's/.*inet ([0-9.]+).*/\1/p')"

port_web="$(docker ps -a | grep "Exited"  |  awk '{print $13  "/" $12}'  | sed 's/://g' | awk -v FS='->' '{print $1}')"


for i in $port_web
        do
                IFS='/' read -r -a array <<< "$i"
                echo -e "Name: ${array[1]}"
done



}





#Menu for Continer
while [ true ]
do
	echo -e "Enter your choise:\n1) Create continer\n2) Delete Continer\n3) Start OR Stop Continer\n4) Show ip & Port continer\n5)Uplode to GitHub\n6) Exit"
	echo "--->"
	read  choice

	case $choice in
		1) create_continer ;;
		2) delete ;;
		3) start_stop_continer ;;
		4) show_ip_port ;;
		5) python3 upload_github.py ;;
		6) break ;;
	esac
done
