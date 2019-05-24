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

	printf("\nElija una opcion : \n\n 1. Down Escenario Industrial 1 [IEC] \n 2. Down Escenario Industrial 2 [ModBus] \n 3. Down Escenario Industrial 3 [DNP] \n 4. Down Escenario personalizado \n\n");

	gets(message);
	int aux=atoi(message);

	switch(aux){
		case 1:
			system("sh scripts/down_escenario_1.sh");
		
			break;
		case 2:
			system("sh scripts/down_escenario_2.sh");
			
			break;
		case 3:
			system("sh scripts/down_escenario_3.sh");

			break;
		case 4:
			system("sh scripts/down_escenario_4.sh");

			break;
	}

    return 0;
}
