%{
#include <stdio.h>
#include "sintaxe.tab.h"
%}
letra	[a-zA-Z]
digito 	[0-9]
id	{letra}[a-zA-Z0-9_]*
intcon 	{digito}{digito}*
charcon \'[a-zA-Z\n\0]\'
stringcon \"(\\.|[^"\\])*\"
comentario (\/\*).*(\*\/)

%%
"CHAR"	{strcpy(yylval.id, yytext); return CHAR;}
"INT"	{strcpy(yylval.id, yytext); return INT;}
{id}		{strcpy(yylval.id, yytext); return ID;}
{stringcon}	{return STRINGCON;}
{intcon} {yylval.intcon = atof(yytext); return INTCON;}
{comentario}	{printf("comentario");}
"]"            {return RBK;}
"["            {return LBK;}
%%
/* recomendavel declarar sempre
   funcao yywrap() */
int yywrap ();

int yywrap() {
 return 1;
}
