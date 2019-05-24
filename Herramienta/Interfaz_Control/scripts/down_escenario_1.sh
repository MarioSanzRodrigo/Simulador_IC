#!/bin/bash

pwd
# Down SIEM
cd escenarios/escenario1 && docker-compose down 
sleep 5

# Down Suricata IDS
cd ../../suricata/escenario1 && docker-compose down 

# Down VMs IEC Simulator

#sh /home/mario/Documentos/TFM/VMs/stop_vm.sh 
