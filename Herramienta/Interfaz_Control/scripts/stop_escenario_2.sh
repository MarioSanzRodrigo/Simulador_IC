#!/bin/bash

# Stop SIEM
cd escenarios/escenario2 && docker-compose stop 

# Stop Suricata IDS
cd ../../suricata/escenario2 && docker-compose stop 

# Stop VMs IEC Simulator

#sh /home/mario/Documentos/TFM/VMs/stop_vm.sh 
