FROM ubuntu:16.04

WORKDIR /home/modbus

RUN apt-get update && apt-get install -y nano wget 

RUN wget https://www.modbusdriver.com/downloads/modpoll.tgz
RUN wget https://www.modbusdriver.com/downloads/diagslave.tgz 

RUN tar -zxvf diagslave.tgz
RUN tar -zxvf modpoll.tgz


