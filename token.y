%{
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

 
int r[10];
int PC;
int memoria[500];

/* Identificado e procurador de Label*/
char *labelAtual;
char *labelAux;
bool labelAtivo;


int hashInt(int valor)
{
	valor=valor%500;
	return valor;
}

void insereMemoria(int chave, int dado)
{
	memoria[hashInt(chave)] = dado;
}

int recuperaMemoria(int chave)
{
	return memoria[hashInt(chave)];
}

bool comparaChar(char *um, char *dois)
{
	bool retorno=true;
	int tam = 999;
	if(strlen(um)<tam)
		tam=strlen(um);
	if(strlen(dois)<tam)
		tam=strlen(dois);
		
	for(int i=0; i<tam; i++)
	{
		if(um[i]==dois[i])
		{
			retorno=true;
		}
		else{
			retorno=false;
			break;
		}
	}
	return retorno;
}

void incrementaPC()
{
	PC++;
}

int procuraLabel(char label)
{
	/* implementação do mecanismo que procura a tal label*/
}

void reset()
{
	printf("---- [ RESET ]----\n");
	FILE *f = fopen("cmd_correto.txt", "r");
	yyrestart(f);
	yyparse();
}

%}
/*
%union{
	int Integer;
	char Char;
}*/


%token NOP 
%token AND ANDI OR ORI XOR XORI
%token ADD SUB DIV MULT ADDI MULTI SUBI RSUBI DIVI RDIVI
%token LSHIFT LSHIFTI RSHIFT RSHIFTI
%token LOAD LOADAI LOADAO CLOAD CLOADAI CLOADAO LOADI
%token STORE STOREAI STOREAO CSTORE CSTOREAI CSTOREAO
%token I2I C2C C2I I2C
%token CMP_LT CMP_LE CMP_EQ CMP_GE CMP_GT CMP_NE CBR
%token CCMP CBR_LT CBR_LE CBR_EQ CBR_GE CBR_GT CBR_NE
%token JUMPI JUMP TBL
%token NUMBER
%token REGISTER
%token LABEL
%token CC
%token VIRGULA PRINT RESET EOFL



/*%type <i> instrucao lista_instrucoes*/
%%


lista_instrucoes: instrucao fim_linha lista_instrucoes
|
;

fim_linha: EOFL  {}
|
;

instrucao:	PRINT /*printf("\n Vetor de Registradores \n r0 %d \n r1 %d \n r2 %d \n r3 %d \n r4 %d \n r5 %d \n r6 %d \n r7 %d \n r8 %d \n r9 %d \n",r[0],r[1],r[2],r[3],r[4],r[5],r[6],r[7],r[8],r[9]);*/
{ 
	fflush(stdin);
	printf("---- [ REGISTRADORES ]----\n");
	for(int i=0; i<10; i++)
		printf("R[%d] = %d \n",i,r[i]);
	
	printf("---- [ REGISTRADORES ]----\n");
}
| RESET
{
	fflush(stdin);
	/*printf("---- [ RESET ]----\n");
	FILE *f = fopen("cmd_correto.txt", "r");
	yyrestart(f);
	yyparse();*/
	reset();
}
| ADDI REGISTER VIRGULA NUMBER VIRGULA REGISTER 
{
	if(labelAtivo==0)
	{
		r[$6] = r[$2]+$4;
		printf("O valor %d e o resultado da soma entre o valores do registrador (%d) e o digitado (%d).\n",r[$6],r[$2],$4);
	}
	else{
	}
}
| SUBI REGISTER VIRGULA NUMBER VIRGULA REGISTER
{
	if(labelAtivo==0)
	{
		r[$6] = r[$2]-$4;
		printf("O valor %d e o resultado da subtracao entre o valores do registrador (%d) e o digitado (%d).\n",$6,$2,$4);
	}
	else{
	}
	
}
| MULTI REGISTER VIRGULA NUMBER VIRGULA REGISTER
{
	if(labelAtivo==0)
	{
		r[$6] = r[$2]*$4;
		printf("O valor %d e o resultado da multiplicacao entre o valores do registrador (%d) e o digitado (%d).\n",$6,$2,$4);
	}
	else{
	}
} 
| DIVI REGISTER VIRGULA NUMBER VIRGULA REGISTER
{
	if(labelAtivo==0)
	{
		r[$6] = r[$2]/$4;
		printf("O valor %d e o resultado da divisao entre o valores do registrador (%d) e o digitado (%d).\n",$6,$2,$4);
	}
	else{
	}
} 
| LSHIFTI REGISTER VIRGULA NUMBER VIRGULA REGISTER
{
	if(labelAtivo==0)
	{
		r[$6] = r[$2]<<$4;
	}
	else{
	}
}
| RSHIFTI REGISTER VIRGULA NUMBER VIRGULA REGISTER
{
	if(labelAtivo==0)
	{
		r[$6] = r[$2]>>$4;
	}
	else{
	}
}
| ANDI REGISTER VIRGULA NUMBER VIRGULA REGISTER
{
	if(labelAtivo==0)
	{
		r[$6]= r[$2]&$4;
	}
	else{
	}
}
| ORI REGISTER VIRGULA NUMBER VIRGULA REGISTER
{
	if(labelAtivo==0)
	{
		r[$6]= r[$2]|$4;
	}
	else{
	}
}
| XORI REGISTER VIRGULA NUMBER VIRGULA REGISTER
{
	
	if(labelAtivo==0)
	{
		r[$6]= r[$2]^$4;
	}
	else{
	}
}
| RSUBI REGISTER VIRGULA NUMBER VIRGULA REGISTER 
{
	
	if(labelAtivo==0)
	{
		r[$6] = $4-r[$2];
	}
	else{
	}
} 
| RDIVI REGISTER VIRGULA NUMBER VIRGULA REGISTER
{
	
	if(labelAtivo==0)
	{
		r[$6] = $4/r[$2];
	}
	else{
	}
} 
| LOADI NUMBER VIRGULA REGISTER 
{
	fflush(stdin);
	if(labelAtivo==0)
	{
		r[$4] = $2;
		printf("Load imediato de %d em R%d \n",$2,$4);
	}
	else{
	}
} 
| ADD REGISTER VIRGULA REGISTER VIRGULA REGISTER
{
	
	if(labelAtivo==0)
	{
		r[$6] = r[$2]+r[$4];
	}
	else{
	}
}
| SUB REGISTER VIRGULA REGISTER VIRGULA REGISTER
{
	
	if(labelAtivo==0)
	{
		r[$6] = r[$2]-r[$4];
	}
	else{
	}
}
| MULT REGISTER VIRGULA REGISTER VIRGULA REGISTER 
{
	
	if(labelAtivo==0)
	{
		r[$6] = r[$2]*r[$4];
	}
	else{
	}
} 
| DIV REGISTER VIRGULA REGISTER VIRGULA REGISTER 
{
	
	if(labelAtivo==0)
	{
		r[$6] = r[$2]/r[$4];
	}
	else{
	}
} 
| LSHIFT REGISTER VIRGULA REGISTER VIRGULA REGISTER
{
	
	if(labelAtivo==0)
	{
		r[$6] = r[$2]<<r[$4];
	}
	else{
	}
}
| RSHIFT REGISTER VIRGULA REGISTER VIRGULA REGISTER
{
	
	if(labelAtivo==0)
	{
		r[$6] = r[$2]>>r[$4];
	}
	else{
	}
}
| AND REGISTER VIRGULA REGISTER VIRGULA REGISTER
{
	
	if(labelAtivo==0)
	{
		r[$6]= r[$2]&$4;
	}
	else{
	}
}
| OR REGISTER VIRGULA REGISTER VIRGULA REGISTER
{
	
	if(labelAtivo==0)
	{
		printf("registradores %d e %d com valores %d e %d \n",$2,$4,r[$2],r[$4]);
		r[$6]= r[$2]|r[$4];
	}
	else{
	}
}
| XOR REGISTER VIRGULA REGISTER VIRGULA REGISTER
{
	
	if(labelAtivo==0)
	{
		printf("registradores %d e %d com valores %d e %d \n",$2,$4,r[$2],r[$4]);
		r[$6]= r[$2]^r[$4];
	}
	else{
	}
}
| LOAD REGISTER VIRGULA REGISTER /* Puxar da Hash d memoria */
{
	if(labelAtivo==0)
	{
		printf("Conteudo carregado %d \n",recuperaMemoria(r[$2]));
		r[$4]=recuperaMemoria(r[$2]);
	}
	else{
	}
} 
| LOADAI REGISTER VIRGULA NUMBER VIRGULA REGISTER /* Puxar da Hash d memoria */
{
	if(labelAtivo==0)
	{
		printf("Conteudo carregado %d \n",recuperaMemoria(r[$4]+$2));
		r[$6]=recuperaMemoria(r[$4]+$2);
	}
	else{
	}
}
| LOADAO REGISTER VIRGULA REGISTER VIRGULA REGISTER /* Puxar da Hash d memoria */
{
	if(labelAtivo==0)
	{
		printf("Conteudo carregado %d \n",recuperaMemoria(r[$4]+r[$2]));
		r[$6]=recuperaMemoria(r[$4]+r[$2]);
	}
	else{
	}
}
| CLOAD CC VIRGULA REGISTER /* Puxar da Hash d memoria */
| CLOADAI REGISTER VIRGULA CC VIRGULA REGISTER /* Puxar da Hash d memoria */
| CLOADAO REGISTER VIRGULA REGISTER VIRGULA REGISTER /* Puxar da Hash d memoria */
| STORE REGISTER VIRGULA REGISTER /* Criar um hash para usar como memoria*/
{
	if(labelAtivo==0)
	{
		insereMemoria(r[$4],r[$2]);
		printf("salvo na memoria: %d \n",memoria[hashInt(r[$4])]);
	}
	else{
	}
} 
| STOREAI REGISTER VIRGULA NUMBER VIRGULA REGISTER /* Memoria */
{
	if(labelAtivo==0)
	{
		insereMemoria($4+r[$6],r[$2]);
		printf("salvo na memoria: %d \n",memoria[hashInt($4+r[$6])]);
	}
	else{
	}
}
| STOREAO REGISTER VIRGULA REGISTER /* Memoria */
{
	if(labelAtivo==0)
	{
		insereMemoria(r[$4]+r[$6],r[$2]);
		printf("salvo na memoria: %d \n",memoria[hashInt(r[$4]+r[$6])]);
	}
	else{
	}
}
| CSTORE REGISTER VIRGULA REGISTER VIRGULA REGISTER /* Memoria */
| CSTOREAI REGISTER VIRGULA NUMBER VIRGULA REGISTER /* Memoria */
| CSTOREAO REGISTER VIRGULA REGISTER VIRGULA REGISTER /* Memoria */
| I2I REGISTER VIRGULA REGISTER 
{
	
	if(labelAtivo==0)
	{
		r[$4] = r[$2];
	}
	else{
	}
}
| C2C REGISTER VIRGULA REGISTER 
{
	
	if(labelAtivo==0)
	{
		r[$4] = r[$2];
	}
	else{
	}
}
| C2I REGISTER VIRGULA REGISTER 
{
	
	if(labelAtivo==0)
	{
		r[$4] = r[$2];
	}
	else{
	}
}
| I2C REGISTER VIRGULA REGISTER 
{
	
	if(labelAtivo==0)
	{
		r[$4] = r[$2];
	}
	else{
	}
}
| CMP_LT REGISTER VIRGULA REGISTER VIRGULA REGISTER 
{
	if(labelAtivo==0)
	{
		if(r[$2]<r[$4]) 
		{
			r[$6]=true;
			printf("resultado verdadeiro");
		} 
		else 
		{
			r[$6]=false;
			printf("resultado falso");
		} 
	}
	else{
	}
	
 } 
| CMP_LE REGISTER VIRGULA REGISTER VIRGULA REGISTER 
{ 
	if(labelAtivo==0)
	{
		if(r[$2]<=r[$4]) 
		{
			r[$6]=true;
		} 
		else 
		{
			r[$6]=false;
		} 
	}
	else{
	}
	
}
| CMP_EQ REGISTER VIRGULA REGISTER VIRGULA REGISTER 
{ 
	if(labelAtivo==0)
	{
		if(r[$2]==r[$4]) 
		{
			r[$6]=true;
		} 
		else 
		{
			r[$6]=false;
		} 
	}
	else{
	}
	
}
| CMP_GE REGISTER VIRGULA REGISTER VIRGULA REGISTER 
{ 
	if(labelAtivo==0)
	{
		if(r[$2]>=r[$4]) 
		{
			r[$6]=true;
		} 
		else 
		{
			r[$6]=false;
		} 
	}
	else{
	}
	
}
| CMP_GT REGISTER VIRGULA REGISTER VIRGULA REGISTER 
{ 
	if(labelAtivo==0)
	{
		if(r[$2]>r[$4]) 
		{
			r[$6]=true;
		} 
		else 
		{
			r[$6]=false;
		} 
	}
	else{
	}
	
}
| CMP_NE REGISTER VIRGULA REGISTER VIRGULA REGISTER 
{ 
	if(labelAtivo==0)
	{
		if(r[$2]!=r[$4])  
		{
			r[$6]=true;
		} 
		else 
		{
			r[$6]=false;
		} 
	}
	else{
	}
	
}
| CBR REGISTER VIRGULA LABEL VIRGULA LABEL
{ 
	if(labelAtivo==0)
	{
		if(r[$2]==true) 
		{
			labelAtual=$4;
		} 
		else 
		{
			labelAtual=$6;
		}
	}
	else{
	}
}
| CCMP REGISTER VIRGULA REGISTER VIRGULA CC
| CBR_LT CC VIRGULA LABEL VIRGULA LABEL 
| CBR_LE CC VIRGULA LABEL VIRGULA LABEL 
| CBR_EQ CC VIRGULA LABEL VIRGULA LABEL 
| CBR_GE CC VIRGULA LABEL VIRGULA LABEL 
| CBR_GT CC VIRGULA LABEL VIRGULA LABEL 
| CBR_NE CC VIRGULA LABEL VIRGULA LABEL 
| JUMP LABEL 
{
	fflush(stdin);
	if(labelAtivo==0)
	{
		labelAtual=$2;
		labelAtivo=true;
		printf(" Jump para o Label %s \n",labelAtual);
		reset();
	}
	else
	{
	
	}
}
| JUMPI REGISTER
{
	PC = r[$2];
} 
| TBL REGISTER VIRGULA LABEL
| LABEL
{
	fflush(stdin);
	if(labelAtivo==true)
	{
		labelAux=$1;
		if(comparaChar(labelAtual,labelAux)==1)
		{
			printf(" Label %s encontrada, continuando execucao.\n",labelAtual);
			labelAtual=NULL;
			labelAtivo=false;
		}	
		else
		{
			printf(" linha Label %s ignorada \n",labelAux);
		}
	}
	else{
		printf(" linha Label %s ignorada.\n",$1);
	}
} 
;
%%

