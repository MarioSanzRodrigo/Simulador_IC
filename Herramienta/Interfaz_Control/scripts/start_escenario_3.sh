#!/bin/bash

sudo sysctl -w vm.max_map_count=262144

# Init SIEM
cd escenarios/escenario3 && docker-compose up -d

sleep 5

# Init Suricata IDS
cd ../../suricata/escenario3 && sh init.sh

# Init VMs IEC Simulator

sh /home/mario/Documentos/TFM/VMs/modify_vm.sh
sleep 1
sh /home/mario/Documentos/TFM/VMs/init_vm.sh

