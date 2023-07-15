%{
#include <stdio.h>
#include <bits/stdc++.h>
#include "sintaxe.tab.h"
%}

digito 	[0-9]
id	      {letra}[a-zA-Z0-9_]*
letra	[a-zA-Z]

%%

":="	          {return (ATRIBUICAO);}
{digito}+	    {yylval.intval = new std::string(yytext); return(NUMBER);}
do              {return (DO);}
else            {return (ELSE);}
end             {return (END);}
fi              {return (FI);}
if              {return (IF);}
in              {return (IN);}
integer         {return (INTEGER);}
let             {return (LET);}
read            {return (READ);}
skip            {return (SKIP);}
then            {return (THEN);}
while           {return (WHILE);}
write           {return (WRITE);}
{id}            {yylval.id = new std::string(yytext); return IDENTIFIER;}
[ \t\n]+
.               {return(yytext[0]);}
%%
/* recomendavel declarar sempre
   funcao yywrap() */
int yywrap(void){}
