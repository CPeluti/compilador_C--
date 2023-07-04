%{
#include <stdio.h>
#include <bits/stdc++.h>
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
"CHAR"	      {yylval.stringValue = new std::string(yytext); return CHAR;}
"INT"	         {yylval.stringValue = new std::string(yytext); return INT;}
{id}		      {yylval.stringValue = new std::string(yytext); return ID;}
{intcon}       {yylval.intcon = std::stoi(yytext); return INTCON;}
"]"            {return RBK;}
"["            {return LBK;}
%%
/* recomendavel declarar sempre
   funcao yywrap() */
int yywrap() {
   return 1;
}
