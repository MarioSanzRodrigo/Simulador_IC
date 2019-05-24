#include<stdio.h> //printf
#include<string.h> //memset
#include<stdlib.h> //exit(0);


#define BUFLEN 512  //Max length of buffer


int main(void)
{
    printf("############################################################\n");
    printf("## Generador de escenarios para Infraestructuras Criticas ##\n");
    printf("############################################################\n");

    char message[BUFLEN] = "";

	printf("\nElija una opcion : \n\n 1. Escenario Industrial 1 [IEC] \n 2. Escenario Industrial 2 [ModBus] \n 3. Escenario Industrial 3 [DNP] \n 4. Escenario personalizado \n\n");

	gets(message);
	int aux=atoi(message);

	switch(aux){
		case 1:
			printf("\nElementos del escenario 1:\n\n - [Docker]\t\tSimulador IEC Client\n - [Docker]\t\tSimulador IEC Server\n - [Docker]\tElasticSearch\n - [Docker]\tKibana\n - [Docker]\tIDS Suricata\n - [Docker]\tELK_Client\n\n");
			printf("Levantando Escenario Industrial 1\n\n");

			system("sh scripts/escenario1.sh");

			printf("\nIPs del escenario 1:\n\n - [Docker] Simulador IEC Client \t 192.168.1.141\n - [Docker] Simulador IEC Server \t 192.168.1.140 \n - [Docker] ElasticSearch_1 \t 192.168.1.110\n - [Docker] Kibana \t\t 192.168.1.130\n - [Docker] IDS Suricata \t localhost\n - [Docker] ELK_Client \t\t 192.168.1.160\n\n");
			break;
		case 2:
			printf("\nElementos del escenario 2:\n\n - [Docker]\tSimulador ModBus Server\n - [Docker]\tSimulador ModBus Client\n - [Docker]\tElasticSearch\n - [Docker]\tKibana\n - [Docker]\tIDS Suricata\n - [Docker]\tELK_Client\n\n");
			printf("Levantando Escenario Industrial 2\n\n");

			system("sh scripts/escenario2.sh");

			printf("\nIPs del escenario 1:\n\n - [Docker] Simulador ModBus Server\t192.168.1.70\n - [Docker] Simulador ModBus Client\t192.168.1.80 \n - [Docker] ElasticSearch_1\t\t192.168.1.10\n - [Docker] ElasticSearch_2\t\t192.168.1.11\n - [Docker] ElasticSearch_3\t\t192.168.1.12\n - [Docker] Kibana\t\t\t192.168.1.30\n - [Docker] IDS Suricata\t\t192.168.1.140\n - [Docker] ELK_Client\t\t\t192.168.1.60\n\n");
			break;
		case 3:
			printf("\nElementos del escenario 1:\n\n - [VM]\t\tSimulador DNP Client\n - [VM]\t\tSimulador DNP Server\n - [Docker]\tElasticSearch\n - [Docker]\tKibana\n - [Docker]\tIDS Suricata\n - [Docker]\tELK_Client\n\n");
			printf("Levantando Escenario Industrial 3\n");

			system("sh scripts/escenario3.sh");

			printf("\nIPs del escenario 1:\n\n - [VM] Simulador DNP Client \t 192.168.1.101\n - [VM] Simulador DNP Server \t 192.168.1.102 \n - [Docker] ElasticSearch_1 \t 192.168.1.200\n - [Docker] ElasticSearch_2 \t 192.168.1.201\n - [Docker] ElasticSearch_3 \t 192.168.1.202\n - [Docker] Kibana \t\t 192.168.1.203\n - [Docker] IDS Suricata \t 192.168.1.140\n - [Docker] ELK_Client \t\t 192.168.1.206\n\n");
			break;
		case 4:
			printf("Creando Escenario Personalizado\n");
			system("sh scripts/dynamic-compose.sh");
			break;
	}

    return 0;
}
