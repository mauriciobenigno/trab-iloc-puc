%{
#include <stdio.h>
#include "token.tab.h" 
%}

%%
"," {return VIRGULA; }
"nop" { return NOP; }
"and" { return AND; }
"andI" { return ANDI; }
"or" { return OR; }
"orI" { return ORI; }
"xor" { return XOR; }
"xorI" { return XORI; }
"add" { return ADD; }
"sub" { return SUB; }
"div" { return DIV; }
"mul" { return MULT; }
"addI" { return ADDI; }
"mulI" { return MULTI; }
"subI" { return SUBI; }
"rsubI" { return RSUBI; }
"divI" { return DIVI; }
"rdivI" { return RDIVI; }
"lshift" { return LSHIFT; }
"lshiftI" { return LSHIFTI; }
"rshift" { return RSHIFT; }
"rshiftI" { return RSHIFTI; }
"load" { return LOAD; }
"loadAI" { return LOADAI; }
"loadAO" { return LOADAO; }
"cload" { return CLOAD; }
"cloadAI" { return CLOADAI; }
"cloadAO" { return CLOADAO; }
"loadI" { return LOADI; }
"store" { return STORE; }
"storeAI" { return STOREAI; }
"storeAO" { return STOREAO; }
"cstore" { return CSTORE; }
"cstoreAI" { return CSTOREAI; }
"cstoreAO" { return CSTOREAO; }
"i2i" { return I2I; }
"c2c" { return C2C; }
"c2i" { return C2I; }
"i2c" { return I2C; }
"cmp_LT" { return CMP_LT; }
"cmp_LE" { return CMP_LE; }
"cmp_EQ" { return CMP_EQ; }
"cmp_GE" { return CMP_GE; }
"cmp_GT" { return CMP_GT; }
"cmp_NE" { return CMP_NE; }
"cbr" { return CBR; }
"ccmp" { return CCMP; }
"cbr_LT" { return CBR_LT; }
"cbr_LE" { return CBR_LE; }
"cbr_EQ" { return CBR_EQ; }
"cbr_GE" { return CBR_GE; }
"cbr_GT" { return CBR_GT; }
"cbr_NE" { return CBR_NE; }
"jumpI" { return JUMPI; }
"jump" { return JUMP; }
"tbl" { return TBL; }

"pc" { return PC; }


[0-9]+ { yylval = atoi(yytext); return NUMBER; }
[rR][0-9] { return REGISTER; } 
[L]][0-9] { return LABEL; }
[ccCC][0-9] { return CC; } 

 
[ \t] { /* ignore whitespace */ }
. { printf("Caractere invalido encontrado: %c\n", *yytext); }

%%

main(int argc, char **argv)
{
	yyparse();
}

yyerror(char *s)
{
	fprintf(stderr, "error: %s\n", s);
}