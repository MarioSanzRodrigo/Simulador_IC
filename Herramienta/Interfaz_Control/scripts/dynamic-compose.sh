path=escenarios/escenario_dinamico

rm $path/docker-compose.yml
touch $path/docker-compose.yml


echo "version: '2.2'\n" >> $path/docker-compose.yml
echo "services:" >> $path/docker-compose.yml
echo "\n¿Introducir nuevo servicio? [1-Si 0-No]\n"
read add_service
while [ $add_service -eq 1 ]; 
do
	echo "\nIntroduce el nombre del nuevo servicio:\n"
	echo ' 1. KaliLinux\n 2. ElasticSearch\n 3. Kibana\n 4. Ubuntu\n 5. ModBus\n'
	read service
	if [ $service -eq 1 ];
	then
		echo "   kali_linux:" >> $path/docker-compose.yml
		echo "Introduce el nombre de contenedor"
		read name_1
		echo "      container_name: $name_1" >> $path/docker-compose.yml
		echo "      image: kalilinux/kali-linux-docker" >> $path/docker-compose.yml
		echo "      command: tail -F anything" >> $path/docker-compose.yml
		echo "      networks:"  >> $path/docker-compose.yml
		echo "        - TFM_lab_network" >> $path/docker-compose.yml
		echo "\n" >> $path/docker-compose.yml

		echo "\n¿Introducir nuevo servicio? [1-Si 0-No]\n"
		read add_service

	elif [ $service -eq "2" ];
	then
		echo "   elasticsearch:" >> $path/docker-compose.yml
		echo "Introduce el nombre de contenedor"
		read name_2
		echo "      container_name: $name_2" >> $path/docker-compose.yml
		#echo "      image: docker.elastic.co/elasticsearch/elasticsearch:6.5.0" >> $path/docker-compose.yml
		echo "      image: ubuntu:16.04" >> $path/docker-compose.yml
		echo "      command: tail -F anything" >> $path/docker-compose.yml
		echo "      networks:"  >> $path/docker-compose.yml
		echo "        - TFM_lab_network" >> $path/docker-compose.yml
		echo "        - TFM_IDS_network" >> $path/docker-compose.yml
		echo "\n" >> $path/docker-compose.yml

		echo "\n¿Introducir nuevo servicio? [1-Si 0-No]\n"
		read add_service

	elif [ $service -eq "3" ];
	then
		echo "   kibana:" >> $path/docker-compose.yml
		echo "Introduce el nombre de contenedor"
		read name_3
		echo "      container_name: $name_3" >> $path/docker-compose.yml
		#echo "      image: docker.elastic.co/kibana/kibana-oss:6.5.0" >> $path/docker-compose.yml
		echo "      image: ubuntu:16.04" >> $path/docker-compose.yml
		echo "      command: tail -F anything" >> $path/docker-compose.yml
		echo "      networks:"  >> $path/docker-compose.yml
		echo "        - TFM_lab_network" >> $path/docker-compose.yml
		echo "\n" >> $path/docker-compose.yml

		echo "\n¿Introducir nuevo servicio? [1-Si 0-No]\n"
		read add_service

	elif [ $service -eq "4" ];
	then
		echo "   ubuntu:" >> $path/docker-compose.yml
		echo "Introduce el nombre de contenedor"
		read name_4
		echo "      container_name: $name_4" >> $path/docker-compose.yml
		echo "      image: ubuntu:16.04" >> $path/docker-compose.yml
		echo "      command: tail -F anything" >> $path/docker-compose.yml
		echo "      networks:"  >> $path/docker-compose.yml
		echo "        - TFM_lab_network" >> $path/docker-compose.yml
		echo "\n" >> $path/docker-compose.yml

		echo "\n¿Introducir nuevo servicio? [1-Si 0-No]\n"
		read add_service

	elif [ $service -eq "5" ];
	then
		echo "   modbus:" >> $path/docker-compose.yml
		echo "Introduce el nombre de contenedor"
		read name_5
		echo "      container_name: $name_5" >> $path/docker-compose.yml
		echo "      image: modbus" >> $path/docker-compose.yml
		echo "      command: tail -F anything" >> $path/docker-compose.yml
		echo "      networks:"  >> $path/docker-compose.yml
		echo "        - TFM_lab_network" >> $path/docker-compose.yml
		echo "\n" >> $path/docker-compose.yml

		echo "\n¿Introducir nuevo servicio? [1-Si 0-No]\n"
		read add_service
	fi
done

echo "\n¿Quieres introducir una honeynet? [1-Si 0-No]:\n"
read honeynet
if [ $honeynet -eq 1 ];
then
	echo "   honeynet:" >> $path/docker-compose.yml
	echo "Introduce el nombre de contenedor"
	read name_honeynet
	echo "      container_name: $name_honeynet" >> $path/docker-compose.yml
	echo "      image: honeynet/conpot" >> $path/docker-compose.yml
	echo "      ports:" >> $path/docker-compose.yml
	echo "       - '80:8080'" >> $path/docker-compose.yml
	echo "       - '102:10201'" >> $path/docker-compose.yml
	echo "       - '502:5020'" >> $path/docker-compose.yml
	echo "       - '161:16100/udp'" >> $path/docker-compose.yml
	echo "       - '47808:47808/udp'" >> $path/docker-compose.yml
	echo "       - '623:6230/udp'" >> $path/docker-compose.yml
	echo "       - '69:6969/udp'" >> $path/docker-compose.yml
	echo "       - '44818:44818'" >> $path/docker-compose.yml
	echo "      restart: always" >> $path/docker-compose.yml
	echo "      networks:"  >> $path/docker-compose.yml
	echo "        - TFM_lab_network" >> $path/docker-compose.yml
	echo "\n" >> $path/docker-compose.yml

else
	echo "\n" >> $path/docker-compose.yml
fi

# Craecion de IDS
echo "   suricata:" >> $path/docker-compose.yml
echo "      container_name: suricata" >> $path/docker-compose.yml
echo "      image: ubuntu:16.04" >> $path/docker-compose.yml
echo "      command: tail -F anything" >> $path/docker-compose.yml
echo "\n" >> $path/docker-compose.yml

# Creacion de Network LAB

echo "networks:" >> $path/docker-compose.yml
echo "   TFM_lab_network:" >> $path/docker-compose.yml
echo "      name: tfg_lab_network" >> $path/docker-compose.yml
echo "      driver: bridge" >> $path/docker-compose.yml
echo "      ipam:" >> $path/docker-compose.yml
echo "        driver: default" >> $path/docker-compose.yml
echo "        config:" >> $path/docker-compose.yml
echo "        -" >> $path/docker-compose.yml
echo "          subnet: '172.35.0.0/24'" >> $path/docker-compose.yml
echo "          gateway: '172.35.0.1'" >> $path/docker-compose.yml
echo "\n" >> $path/docker-compose.yml

# Creacion de Network IDS

echo "   TFM_IDS_network:" >> $path/docker-compose.yml
echo "      name: tfg_ids_network" >> $path/docker-compose.yml
echo "      driver: bridge" >> $path/docker-compose.yml
echo "      ipam:" >> $path/docker-compose.yml
echo "        driver: default" >> $path/docker-compose.yml
echo "        config:" >> $path/docker-compose.yml
echo "        -" >> $path/docker-compose.yml
echo "          subnet: '172.36.0.0/24'" >> $path/docker-compose.yml
echo "          gateway: '172.36.0.1'" >> $path/docker-compose.yml
echo "\n" >> $path/docker-compose.yml

# Creacion de Network SIEM

echo "   TFM_Control_network:" >> $path/docker-compose.yml
echo "      name: tfg_control_network" >> $path/docker-compose.yml
echo "      driver: bridge" >> $path/docker-compose.yml
echo "      ipam:" >> $path/docker-compose.yml
echo "        driver: default" >> $path/docker-compose.yml
echo "        config:" >> $path/docker-compose.yml
echo "        -" >> $path/docker-compose.yml
echo "          subnet: '172.37.0.0/24'" >> $path/docker-compose.yml
echo "          gateway: '172.37.0.1'" >> $path/docker-compose.yml

cd $path
docker-compose up -d 


#echo "IP $name_2: " && docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $name_2
#echo "IP $name_3: " && docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $name_3
#echo "IP $name_4: " && docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $name_4
#echo "IP $name_5: " && docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $name_5
