%{
#include <stdio.h> 
%}

/* tokens */
%token NUM
%token ID

%token IF ELSE WHILE FOR RETURN VOID EXTERN
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
/*
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

prog	:	dcl ';'  |  func        {;}
dcl	:	type var_decl { ',' var_decl }
 	|	type ID '(' parm_types ')' rep_dcl
        |       EXTERN type ID '(' parm_types ')' rep_dcl
 	|	VOID ID '(' parm_types ')' rep_dcl
 	|	EXTERN VOID ID '(' parm_types ')' rep_dcl
rep_dcl :       
        |       ',' ID '(' parm_types ')'
        |       rep_dcl
var_decl:	ID '[' INTCON ']'
        |       ID

type	:	CHARCON
 	|	INTCON
parm_types	:	VOID
 	|	type ID '[' ']' rep_parm_types
        |       type ID rep_parm_types
rep_parm_types  :
        | ',' type ID
        | ',' type ID '[' ']'
        | rep_parm_types
func	:	type ID '(' parm_types ')' '{' rep_func_var_decl stmt_rep '}'
 	|	VOID ID '(' parm_types ')' '{' rep_func_var_decl stmt_rep '}'
rep_func_var_decl:
        |       type var_decl rep_var_decl ';'
        |       rep_func_var_decl
rep_var_decl:
        | ',' var_decl 
        | rep_var_decl
stmt_rep:
        | stmt
        | stmt_rep
/* corrigir casos de {} e [] */
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


