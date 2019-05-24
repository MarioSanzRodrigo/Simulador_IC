
**Requisitos:**
------------
- > Python3 
- > sudo apt-get install python3-pil python3-pil.imagetk

# Simulador_IC



Simulador de protocolos industriales basado en Docker para el análisis mediante sistemas IDS (Intrusion Detection System) y SIEM (Security Information and Event Management).

**Escenario 1 [IEC 104]:**

- IDS Suricata  [Docker]
- ElasticSearch [Docker]
- Logstash      [Docker]
- Kibana        [Docker]
- Nginx Server  [Docker]
- Kali Linux    [Docker]
- IEC104 Client [Docker]
- IEC104 Server [Docker]

**Escenario 2 [ModBus]:**

- IDS Suricata  [Docker]
- ElasticSearch [Docker]
- Logstash      [Docker]
- Kibana        [Docker]
- Kali Linux    [Docker]
- Nginx Server  [Docker]
- ModBus Master [Docker]
- ModBus Slave  [Docker]

**Escenario 3 [DNP3]:**

- IDS Suricata  [Docker]
- ElasticSearch [Docker]
- Logstash      [Docker]
- Kibana        [Docker]
- Kali Linux    [Docker]
- Nginx Server  [Docker]
- DNP3 Client   [VirtualBox]
- DNP3 Server   [VirtualBox]

Escenario 4 [Escenario Personalizable]


**Funcionamiento Escenario 1. Uso inicial:**
------------

1. Acceder a la carpeta Interfaz_Control
> cd /Simulador_IC/Herramienta/Interfaz_Control/
2. Lanzar con python3 el fichero .py
> python3 interfaz_ELK.py
3. Inicializar el escenario selecionado
> Iniciar Escenario 1
4. Introducir contraseña root en la terminal

Interfaces Web de los elementos SIEM:

- Interfaz Http Kibana http://localhost:5601 o http://192.168.1.130:5601 \
- Interfaz Http ElasticSearch http://localhost:9200 o http://192.168.1.110:9200 \
- Interfaz Http Kibana via Nginx http://localhost:8080

Suricata IDS:

- Funcionamiento en modo host, escuchando en la interfaz docker creada para la red privada donde se alojan todos los contenedores "br-xxxxxxxxx"
- Acceso vía "docker exec -it suricata_es1 bash"

Simulador IEC104_Client:

1. Acceso al interior del contenedor iec104_client
> Acceso vía "docker exec -it iec104_client_es1 bash"
2. Acceso al path j60870-1.2.1 para ejecutar el cliente
> Acceder al path "/home/admin/j60870-1.2.1/run-scripts"
3. Ejecutar ./j60870-console-client -h IP_SERVER -p PORT para realizar la conexion con iec104_server
> ./j60870-console-client -h 192.168.1.140 -p 2404
4. Conexion establecida entre client-servidor
- Opciones diponibles:
> 1 interrogation C_IC_NA_1 \
> 2 synchronize clocks C_CS_NA_1 \
> 3 counter interrogation C_CI_NA_1 \
> 4 reset process command C_RP_NA_1 \
> 5 read command C_RD_NA_1 \
> 6 set value P_ME_NA_1 \
> 7 set value P_ME_NB_1 

Simulador IEC104_Server

- El servidor está activo escuchando en el puerto 2404.


**Funcionamiento Escenario 2. Uso inicial:**
------------

1. Acceder a la carpeta Interfaz_Control
> cd /Simulador_IC/Herramienta/Interfaz_Control/
2. Lanzar con python3 el fichero .py
> python3 interfaz_ELK.py
3. Inicializar el escenario selecionado
> Iniciar Escenario 2
4. Introducir contraseña root en la terminal

Interfaces Web de los elementos SIEM:

- Interfaz Http Kibana http://localhost:5601 o http://192.168.1.30:5601 \
- Interfaz Http ElasticSearch http://localhost:9200 o http://192.168.1.10:9200 \
- Interfaz Http Kibana via Nginx http://localhost:8080

Suricata IDS:

- Funcionamiento en modo host, escuchando en la interfaz docker creada para la red privada donde se alojan todos los contenedores "br-xxxxxxxxx"
- Acceso vía "docker exec -it suricata_es2 bash"

Simulador modbus_slave

1. Acceso al interior del contenedor modbus_slave_es2
> Acceso vía "docker exec -it modbus_slave_es2 bash"
2. Acceso al path modbus_simulator para ejecutar el cliente
> Acceder al path "/home/admin/modbus_simulator"
3. Ejecutar ./mbtcp_slv PORT
> ./mbtcp_slv 504
4. Introducir nuevo identificador
> Enter Unit ID : 01
5. Seleccionar el tipo de nodo:
> 1   Coil Status \
> 2   Input Status \
> 3   Holding Registers \
> 4   Input Registers 
6. Fijar la direccion de inicio
> Set Start addr (start from 0): 
7. Fijar la longitud de datos
> Set Data Length: 20
8. Se queda a la escucha para realizar la conexion desde modbus_master_es2

Simulador modbus_master:

1. Acceso al interior del contenedor modbus_master_es2
> Acceso vía "docker exec -it modbus_master_es2 bash"
2. Acceso al path modbus_simulator para ejecutar el cliente
> Acceder al path "/home/admin/modbus_simulator"
3. Ejecutar ./mbtcp_mstr IP_SLAVE PORT
> ./mbtcp_mstr 192.168.1.80 504
4. Introducir identificador
> Enter Unit ID :
5. Seleccionar el tipo de funcion a realizar
> Function code : \
> 1		Read Coil Status \
> 2		Read Input Status \
> 3		Read Holding Register \
> 4		Read Input Register \
> 5		Force Single Coil \
> 6		Preset Single Register \
> 15	Force multi-Coil \
> 16	Preset multi-Register 
6. Fijar la direccion de inicio
> Set Start addr (start from 0): 
7. Fijar la longitud de datos
> Set Data Length: 20
8. Fijar el delay entre mensajes (segundos)
> Setup delay between each command (seconds): 
9. Conexion establecida entre modbus_master_es2 y modbus_slave_es2


**Listado de imagenes Docker**
------------

- iec104_client  https://cloud.docker.com/u/msanz741/repository/docker/msanz741/iec104_client
- iec104_server  https://cloud.docker.com/u/msanz741/repository/docker/msanz741/iec104_server
- modBus_master  https://cloud.docker.com/u/msanz741/repository/docker/msanz741/modbus_master
- modBus_slave   https://cloud.docker.com/u/msanz741/repository/docker/msanz741/modbus_slave
- Suricata IDS   https://cloud.docker.com/u/msanz741/repository/docker/msanz741/suricata_mario
- ElasticSearch  https://hub.docker.com/_/elasticsearch
- Kibana         https://hub.docker.com/_/kibana
- Logstash       https://hub.docker.com/_/logstash
