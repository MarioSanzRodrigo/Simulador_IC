#!/bin/bash

# Down SIEM
cd escenarios/escenario2 && docker-compose down

sleep 5

# Down Suricata IDS
cd ../../suricata/escenario2 && docker-compose down



