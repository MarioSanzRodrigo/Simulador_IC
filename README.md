# Simulador de protocolos para Infraestructuras Críticas

## Indice
- [Resumen](https://github.com/MarioSanzRodrigo/Simulador_IC#Resumen)
- [Requisitos](https://github.com/MarioSanzRodrigo/Simulador_IC#Requisitos)
- [Escenarios](https://github.com/MarioSanzRodrigo/Simulador_IC#Escenarios)
- [Autor](https://github.com/MarioSanzRodrigo/Simulador_IC#Autor)
- [Referencias](https://github.com/MarioSanzRodrigo/Simulador_IC#Referencias)

## Resumen

 ![alt text](https://github.com/MarioSanzRodrigo/Simulador_IC/blob/master/Capturas/simulador.png)

Simulador de protocolos industriales basado en Docker para el análisis mediante sistemas IDS (Intrusion Detection System) y SIEM (Security Information and Event Management).


## Requisitos

- > Python3 
- > sudo apt-get install python3-pil python3-pil.imagetk

## Escenarios

- [Escenario 1 [IEC-60870-5-104]](https://github.com/MarioSanzRodrigo/Simulador_IC/wiki/Escenario-1.-Protocolo-IEC-60870-5-104). 
- [Lista de elementos del escenario](https://github.com/MarioSanzRodrigo/Simulador_IC/wiki/Elementos-escenario-1)

- [Escenario 2 [Modbus]](https://github.com/MarioSanzRodrigo/Simulador_IC/wiki/Escenario-2.-Protocolo-Modbus)

- [Lista de elementos del escenario](https://github.com/MarioSanzRodrigo/Simulador_IC/wiki/Elementos-escenario-2)

- [Escenario 3 [DNP3]](https://github.com/MarioSanzRodrigo/Simulador_IC/wiki/Escenario-3.-Protocolo-DNP3)

- [Lista de elementos del escenario](https://github.com/MarioSanzRodrigo/Simulador_IC/wiki/Elementos-escenario-3)

- [Escenario 4 [Personalizable]](https://github.com/MarioSanzRodrigo/Simulador_IC/wiki/Escenario-4.-Personalizable)


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
