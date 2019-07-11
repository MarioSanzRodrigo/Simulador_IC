# Simulador de protocolos industriales basado en Docker para el análisis mediante sistemas IDS (Intrusion Detection System) y SIEM (Security Information and Event Management).

## Indice
- [Resumen](https://github.com/MarioSanzRodrigo/Simulador_IC#Resumen)
- [Requisitos](https://github.com/MarioSanzRodrigo/Simulador_IC#Requisitos)
- [Escenarios](https://github.com/MarioSanzRodrigo/Simulador_IC#Escenarios)
- [Autor](https://github.com/MarioSanzRodrigo/Simulador_IC#Autor)
- [Referencias](https://github.com/MarioSanzRodrigo/Simulador_IC#Referencias)

## Resumen

Este desarrollo viene motivado por la importancia de dotar de seguridad a las infraestructuras críticas de un país, muchas de ellas basadas en sistemas **SCADA (Supervisory Control and Data Acquisition)**, los cuales no se desarrollaron originalmente bajo la perspectiva de la ciberseguridad.

Por ello en este TFM se propone primeramente un análisis exhaustivo, desde la perspectiva de la ciberseguridad, de los protocolos industriales más comunes en este tipo de escenarios, los cuales engloban los protocolos definidos por la normal internacional **IEC 60870-5** en sus variantes 101 y 104, **DNP3 Protocol** (Distributed Network Protocol) y **ModBus**.

Seguido de un estudio de sistemas **IDS (Intrusion Detection System)** como son SNORT o Suricata, con el fin de aplicar y crear reglas que permitan la detección de anomalías en los protocolos anteriormente mencionados.

Finalmente se propone la utilización de herramientas **SIEM (Security Information and Event Management)** como ELK (Elasticsearch, Logstash, Kibana) o OSSIM, para poder analizar correctamente los eventos recogidos por los IDS y visualizarlos con la herramienta Kibana, encargada de manejar visualmente los datos indexados por Elastic Search. 

También se estudiará la opción de dotar de capacidad de respuesta a la plataforma, con el fin de poder aplicar acciones sencillas ante ataques o patrones anómalos detectados.

De forma complementaria al estudio de los elementos mencionados anteriormente, se realizará el desarrollo de un laboratorio / simulador, que permita generar diferentes escenarios para validar el correcto funcionamiento de todo el sistema y obtener conclusiones. Estos escenarios estarán compuestos por microservicios virtualizados, principalmente en contenedores Docker, salvo los casos en los que sea estrictamente necesario el uso de Windows, para el cual se utilizarán máquinas virtuales.

<p align="center">
<img src="https://github.com/MarioSanzRodrigo/Simulador_IC/blob/master/Capturas/simulador.png" width="50%">
</p>

## Requisitos

- > Python3 
- > sudo apt-get install python3-pil python3-pil.imagetk

## Escenarios

- [Escenario 1 [IEC-60870-5-104]](https://github.com/MarioSanzRodrigo/Simulador_IC/wiki/Escenario-1.-Protocolo-IEC-60870-5-104). Simulación del protocolo IEC-60870-5-104 utilizando el software OpenSource [j60870](https://www.openmuc.org/iec-60870-5-104/) posteriormente Dockerizado. Realizando conexiones cliente - servidor iec104 para validar el funcionamiento de reglas Suricata y el sistema SIEM basado en ELK ante los ataques seleccionados mediante Kali Linux. 
- [Lista de elementos del escenario 1](https://github.com/MarioSanzRodrigo/Simulador_IC/wiki/Elementos-escenario-1)

- [Escenario 2 [Modbus]](https://github.com/MarioSanzRodrigo/Simulador_IC/wiki/Escenario-2.-Protocolo-Modbus). Simulación del protocolo Modbus utilizando el software OpenSource [ModBus_Simulator](https://github.com/soso7885/modbus_simulator) posteriormente Dockerizado. Realizando conexiones master - slave modbus para validar el funcionamiento de reglas Suricata y el sistema SIEM basado en la pila ELK ante los ataques seleccionados mediante Kali Linux.

- [Lista de elementos del escenario 2](https://github.com/MarioSanzRodrigo/Simulador_IC/wiki/Elementos-escenario-2)

- [Escenario 3 [DNP3]](https://github.com/MarioSanzRodrigo/Simulador_IC/wiki/Escenario-3.-Protocolo-DNP3). Simulación del protocolo DNP3 utilizando el software [DNP3-Simulator](http://www.freyrscada.com/dnp3-ieee-1815-Server-Simulator.php) instalado en máquina virtual. Realizando conexiones Outstation - Server DNP3 para validar el funcionamiento de reglas Suricata y el sistema SIEM basado en la pila ELK ante los ataques seleccionados mediante Kali Linux.

- [Lista de elementos del escenario 3](https://github.com/MarioSanzRodrigo/Simulador_IC/wiki/Elementos-escenario-3)

- [Escenario 4 [Personalizable]](https://github.com/MarioSanzRodrigo/Simulador_IC/wiki/Escenario-4.-Personalizable). Simulación totalmente personalizable por el usuario, permitiendo elegir entre honeynets, protocolos industriales, máquinas linux, etc. 

- [Lista de elementos del escenario 4](https://github.com/MarioSanzRodrigo/Simulador_IC/wiki/Elementos-escenario-4)


## Autor

Este proyecto ha sido desarrollado por [Mario Sanz Rodrigo](https://www.linkedin.com/in/mario-sanz-rodrigo-8757a2a0/) como resultado del Trabajo de Fin de Master de Ciberseguridad en la Universidad Politécnica de Madrid.


## Referencias

- iec104_client  https://cloud.docker.com/u/msanz741/repository/docker/msanz741/iec104_client
- iec104_server  https://cloud.docker.com/u/msanz741/repository/docker/msanz741/iec104_server
- modBus_master  https://cloud.docker.com/u/msanz741/repository/docker/msanz741/modbus_master
- modBus_slave   https://cloud.docker.com/u/msanz741/repository/docker/msanz741/modbus_slave
- Suricata IDS   https://cloud.docker.com/u/msanz741/repository/docker/msanz741/suricata_mario
- ElasticSearch  https://hub.docker.com/_/elasticsearch
- Kibana         https://hub.docker.com/_/kibana
- Logstash       https://hub.docker.com/_/logstash
