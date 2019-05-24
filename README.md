# Simulador_IC
Simulador de protocolos industriales (IEC104, ModBus, DNP3)

Requisitos:
- Python3 
- sudo apt-get install python3-pil python3-pil.imagetk

Simulador de protocolos industriales basado en Docker para el análisis mediante sistemas IDS (Intrusion Detection System) y SIEM (Security Information and Event Management).

Escenario 1 [IEC 104]:

- IDS Suricata  [Docker]
- ElasticSearch [Docker]
- Logstash      [Docker]
- Kibana        [Docker]
- Nginx Server  [Docker]
- Kali Linux    [Docker]
- IEC104 Client [Docker]
- IEC104 Server [Docker]

Escenario 2 [ModBus]:

- IDS Suricata  [Docker]
- ElasticSearch [Docker]
- Logstash      [Docker]
- Kibana        [Docker]
- Kali Linux    [Docker]
- Nginx Server  [Docker]
- ModBus Master [Docker]
- ModBus Slave  [Docker]

Escenario 3 [DNP3]:

- IDS Suricata  [Docker]
- ElasticSearch [Docker]
- Logstash      [Docker]
- Kibana        [Docker]
- Kali Linux    [Docker]
- Nginx Server  [Docker]
- DNP3 Client   [VirtualBox]
- DNP3 Server   [VirtualBox]

Escenario 4 [Escenario Personalizable]

Listado de imagenes Docker

- iec104_client  https://cloud.docker.com/u/msanz741/repository/docker/msanz741/iec104_client
- iec104_server  https://cloud.docker.com/u/msanz741/repository/docker/msanz741/iec104_server
- modBus_master  https://cloud.docker.com/u/msanz741/repository/docker/msanz741/modbus_master
- modBus_slave   https://cloud.docker.com/u/msanz741/repository/docker/msanz741/modbus_slave
- Suricata IDS   https://cloud.docker.com/u/msanz741/repository/docker/msanz741/suricata_mario
- ElasticSearch  https://hub.docker.com/_/elasticsearch
- Kibana         https://hub.docker.com/_/kibana
- Logstash       https://hub.docker.com/_/logstash
