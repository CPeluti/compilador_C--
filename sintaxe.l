%{
#include <stdio.h>
#include <bits/stdc++.h>
#include "sintaxe.tab.h"
%}

digito 	[0-9]
id	      {letra}[a-zA-Z0-9_]*
/*
letra	[a-zA-Z]
intcon 	{digito}{digito}*
charcon \'[a-zA-Z\n\0]\'
stringcon \"(\\.|[^"\\])*\"
comentario (\/\*).*(\*\/)
*/
%%

":="	        {return (ATRIBUICAO);}
{digito}+	    {yylval.stringValue = new std::string(yytext); return (NUMERO);}
do              {return (DO)}
else            {return (ELSE)}
end             {return (END)}
fi              {return (FI)}
if              {return (IF)}
in              {return (IN)}
integer         {return (INTEGER)}
let             {return (LET)}
read            {return (READ)}
skip            {return (SKIP)}
then            {return (THEN)}
while           {return (WHILE)}
write           {return (WRITE)}
{id}            {yylval.intcon = std::stoi(yytext); return INTCON;}
[ \t\n]         {return(yytext[0]);}

%%
/* recomendavel declarar sempre
   funcao yywrap() */
int yywrap() {
   return 1;
}
