%{
#include <stdio.h>
%}
letra	[a-zA-Z]
digito 	[0-9]
id	{letra}[a-zA-Z0-9_]*
intcon 	{digito}{digito}*
charcon \'[a-zA-Z\n\0]\'
stringcon \"(\\.|[^"\\])*\"
comentario (\/\*).*(\*\/)

%%
{id}		{printf("Id\n");}
{intcon}	{printf("intcon\n");}
{charcon}	{printf("charcon\n");}
{stringcon}	{printf("stringcon\n");}
{comentario}	{printf("comentario\n");}
%%
/* recomendavel declarar sempre
   funcao yywrap() */
int yywrap ();

/* programa principal */
int main() {
  yylex(); /* scanner gerado por Flex */
}

int yywrap() {
 return 1;
}
