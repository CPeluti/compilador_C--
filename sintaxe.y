%{
#include <bits/stdc++.h>
#include <string.h>
int yylex(void);
int yywrap();
int yyerror(char* s);
extern FILE *yyin;
extern FILE *yyout;
//tabela de simbolos
std::map<std::string,std::pair<int, std::string>> tabela;
std::map<std::string,std::pair<std::string, std::tuple<std::string, std::string, int>>> tabela_func;
// std::pair<std::string, std::string> aux;

// int yylex();
%}

%start prog

%code requires {
    struct pss {
        char type[30];
        char id[30];
    };
}

%union { char id[16]; int intcon; struct pss aux; }
/* tokens */
%token <id> ID

%token IF ELSE WHILE FOR RETURN VOID EXTERN CHAR INT LBK RBK LP RP SC
%token <intcon> INTCON
%token CHARCON STRINGCON COMENTARIO

%type prog rep_dcl rep_parm_types
%type <id> type var_decl
%type <aux> parm_types

/* procedencias */
/* %left "&&" "||"
%right '!'
%left '<' '<=' ">" ">=" 
%left "==" "!="
%left '+' '-'
%left '*' '/' */

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

prog	:	dcl SC        												            {printf("teste");}
;
dcl	:	type var_decl															    {tabela[$2].second = $1;}
	|	type ID LP parm_types RP rep_dcl 											{tabela_func[$2].first = $1;}
	|   EXTERN type ID LP parm_types RP rep_dcl 									{;}
 	|	VOID ID LP parm_types RP rep_dcl 											{;}
 	|	EXTERN VOID ID LP parm_types RP rep_dcl 									{;} 
;
rep_dcl :        																	{;}
        |       SC ID LP parm_types RP 											    {;}
        |       rep_dcl 															{;}
;
var_decl:	ID LBK INTCON RBK 														{tabela[$1].first = $3;}
        |   ID 																		{tabela[$1].first = 1;}
;
type:	CHAR 																									
	|	INT 																		
;

parm_types	:	VOID 																{;}
 	|	type ID LBK RBK rep_parm_types 												{pss aux; aux.type = $1; aux.id = $2; $$ = aux;}
	|   type ID rep_parm_types 														{;}
;

rep_parm_types  : 																	{;}
        | SC type ID 																{;}
        | SC type ID LBK RBK														{;}
        | rep_parm_types 															{;}
;
/*
func	:	type ID '(' parm_types ')' '{' rep_func_var_decl stmt_rep '}' 			{;}
 	|	VOID ID '(' parm_types ')' '{' rep_func_var_decl stmt_rep '}' 				{;}
;
rep_func_var_decl: 																	{;}
        |       type var_decl rep_var_decl ';' 										{;}
        |       rep_func_var_decl 													{;}
;
rep_var_decl: 																		{;}
        | ',' var_decl  															{;}
        | rep_var_decl 																{;}
;
stmt_rep: 																			{;}
        | stmt 																		{;}
        | stmt_rep 																	{;}
;
stmt:   IF '(' expr ')' stmt ELSE stmt                          {;}
        | IF '(' expr ')' stmt                                  {;}
        | WHILE '(' expr ')' stmt                               {;}
        | FOR '(' assg_op ';' expr_op ';' assg_op ')' stmt      {;}
        | RETURN expr_op ';'                                    {;}
        | assg ';'                                              {;}
        | ID '(' expr expr_rep ')' ';'                          {;}
        | ID '(' ')' ';'                                        {;}
        | '{' stmt_rep '}'                                      {;}
        | ';'                                                   {;}
;

assg_op: assg
        | VOID
;

expr_op: expr
        | VOID
;

expr_rep: ',' expr
        | expr_rep
;

assg:   ID '[' expr ']' '=' expr    {;}
        | ID '=' expr               {;}
;

expr:   '-' expr                    {;}
        | '!' expr                  {;}
        | expr binop expr           {;}
        | expr relop expr           {;}
        | expr logical_op expr      {;}
        | ID '(' expr expr_rep ')'  {;}
        | ID '[' expr ']'           {;}
        | ID                        {;}
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

relop:  '=''='    {;}
        |'!''='   {;}
        |'<''='   {;}
        |'<'    {;}
        |'>''='   {;}
        |'>'    {;}
;

logical_op: '&''&'    {;}
            | '|''|'  {;}
; */

%%
int main (int argc, char **argv)
{
	++argv; --argc;
	if(argc){
		yyin = fopen(argv[0], "rt");
		argc--;
	}
	else
		yyin = stdin;
	if(argc)
		yyout = fopen(argv[0], "wt");
	else
		yyout = stdout;

	yyparse();
    /* for(auto it = tabela.cbegin(); it != tabela.cend(); ++it){
        std::cout << it->second.first << " " << it->second.second << std::endl;
    } */
        /* for(auto it = tabela_func.cbegin(); it != tabela_func.cend(); ++it){
            std::cout << it->second.first << " ";
            for(auto x : it->second.second)
                std::cout << x << std::endl;
        } */
	fclose(yyin);
	fclose(yyout);
	return 0;
}
int yyerror (char *s) /* Called by yyparse on error */
{
	fprintf(stderr, "error: %s\n", s);
	return 0;
}


