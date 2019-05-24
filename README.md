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

Uso inicial:

1. Acceder a la carpeta Interfaz_Control
> cd /Simulador_IC/Herramienta/Interfaz_Control/
2. Lanzar con python3 el fichero .py
> python3 interfaz_ELK.py
3. Inicializar el escenario selecionado
> Iniciar Escenario 1/2/3/4

Interfaces Web de los elementos SIEM:

-Interfaz Http Kibana http://localhost:5601 o http://192.168.1.130:5601
-Interfaz Http ElasticSearch http://localhost:9200 o http://192.168.1.110:9200
-Interfaz Http Kibana via Nginx http://localhost:8080

Suricata IDS:

- Funcionamiento en modo host, escuchando en la interfaz docker creada para la red privada donde se alojan todos los contenedores "br-xxxxxxxxx"
- Acceso vía "docker exec -it suricata_es1 bash"

Simulador IEC104_Client:

1. Acceso al interior del contenedor iec104_client
> Acceso vía "docker exec -it iec104_client bash"
2. Acceso al path j60870-1.2.1 para ejecutar el cliente
> Acceder al path "/home/admin/j60870-1.2.1/run-scripts"
3. Ejecutar ./j60870-console-client -h IP_SERVER -p PORT para realizar la conexion con iec104_server
> ./j60870-console-client -h 192.168.1.140 -p 2404
4. Conexion establecida entre client-servidor
- Opciones diponibles:
> interrogation C_IC_NA_1 \n
> synchronize clocks C_CS_NA_1
> counter interrogation C_CI_NA_1
> reset process command C_RP_NA_1
> read command C_RD_NA_1
> set value P_ME_NA_1
> set value P_ME_NB_1

Simulador IEC104_Server

- El servidor está activo escuchando en el puerto 2404.

Listado de imagenes Docker

- iec104_client  https://cloud.docker.com/u/msanz741/repository/docker/msanz741/iec104_client
- iec104_server  https://cloud.docker.com/u/msanz741/repository/docker/msanz741/iec104_server
- modBus_master  https://cloud.docker.com/u/msanz741/repository/docker/msanz741/modbus_master
- modBus_slave   https://cloud.docker.com/u/msanz741/repository/docker/msanz741/modbus_slave
- Suricata IDS   https://cloud.docker.com/u/msanz741/repository/docker/msanz741/suricata_mario
- ElasticSearch  https://hub.docker.com/_/elasticsearch
- Kibana         https://hub.docker.com/_/kibana
- Logstash       https://hub.docker.com/_/logstash
