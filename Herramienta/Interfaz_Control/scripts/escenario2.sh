#!/bin/bash

sudo sysctl -w vm.max_map_count=262144

# Init SIEM
cd escenarios/escenario2 && docker-compose up -d

sleep 5

# Init Suricata IDS
cd ../../suricata/escenario2 && sh init.sh

