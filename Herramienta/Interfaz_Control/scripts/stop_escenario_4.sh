#!/bin/bash

# Stop SIEM
cd escenarios/escenario_dinamico && docker-compose stop 

# Stop Suricata IDS
cd ../../suricata/escenario_dinamico && docker-compose stop 

# Stop VMs IEC Simulator

#sh /home/mario/Documentos/TFM/VMs/stop_vm.sh 
