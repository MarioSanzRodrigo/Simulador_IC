#!bin/bash

#sudo rm -r /home/mario/Documentos/TFM/Interfaz_Dinamica/suricata_logs

interface=$(docker network ls |  grep TFM | awk '{print $1}')
suricata_interface=$(echo br-$interface)

sed -i "s/^.*command: -i.*/    command: -i $suricata_interface/" docker-compose.yml

docker-compose up -d

