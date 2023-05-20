%{
#include <stdio.h> 
%}

/* tokens */
%token NUM
%token ID

%token IF ELSE WHILE FOR RETURN
%token INTCON CHARCON STRINGCON

/* procedencias */
%left "&&" "||"
%right '!'
%left '<' '<=' ">" ">=" 
%left "==" "!="
%left '+' '-'
%left '*' '/'

%%

/* regras */

/*
input:    /* empty */
        | input line
;
line:     '\n'
        | programa '\n'  { printf ("Programa sintaticamente correto!\n"); }
;
programa:	'{' lista_cmds '}'	{;}
;
lista_cmds:	cmd				{;}
		| cmd ';' lista_cmds	{;}
;
cmd:		ID '=' exp			{;}
;
exp:		NUM				{;}
		| ID				{;}
		| exp exp '+'		{;}
;

*/

stmt:   IF '(' expr ')' stmt ELSE stmt              {;}
        | WHILE '(' expr ')' stmt                   {;}
        | FOR '(' assg ';' expr ';' assg ')' stmt   {;}
        | RETURN expr ';'                           {;}
        | assg ';'                                  {;}
        | ID '(' expr ',' expr ')' ';'              {;}
        | '{' stmt '}'                              {;}
        | ';'                                       {;}
;

assg:   ID '[' expr ']' '=' expr    {;};

expr:   '-' expr                    {;}
        | '!' expr                  {;}
        | expr binop expr           {;}
        | expr relop expr           {;}
        | expr logical_op expr      {;}
        | ID '(' expr ',' expr ')'  {;}
        | ID '[' expr ']'           {;}
        | '(' expr ')'              {;}
        | INTCON                    {;}
        | CHARCON                   {;}
        | STRINGCON                 {;}
;

binop:   '+'    {;}
        | '-'   {;}
        | '*'   {;}
        | '/'   {;}
;

relop:  '=='    {;}
        |'!='   {;}
        |'<='   {;}
        |'<'    {;}
        |'>='   {;}
        |'>'    {;}
;

logical_op: '&&'    {;}
            | '||'  {;}
;

%%
main () 
{
	yyparse ();
}
yyerror (s) /* Called by yyparse on error */
	char *s;
{
	printf ("Problema com a analise sintatica!\n", s);
}


