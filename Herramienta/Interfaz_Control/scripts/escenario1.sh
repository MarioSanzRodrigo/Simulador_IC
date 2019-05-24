#!/bin/bash

sudo sysctl -w vm.max_map_count=262144

pwd
# Init SIEM
cd escenarios/escenario1 && docker-compose up -d
sleep 5

# Init Suricata IDS
cd ../../suricata/escenario1 && sh init.sh
# Init VMs IEC Simulator

#sh /home/mario/Documentos/TFM/VMs/modify_vm.sh
#sleep 1
#sh /home/mario/Documentos/TFM/VMs/init_vm.sh

