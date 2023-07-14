%{
    #include <bits/stdc++.h>
    #include "st.h"
    extern FILE *yyin;
    extern FILE *yyout;
    ST symbol_table;
    int yylex(void);
    void yyerror(const char *);
    void install (std::string* sym_name)
    {
        bool s = symbol_table.exist_symbol(*sym_name);
        if(!s){
            std::cout << "Não existe" << std::endl;
            symbol_table.insert_symbol(*sym_name);

        }else 
            std::cout << *sym_name << " " << "is already defined" << std::endl;
    }
%}


%union {
int intval;
std::string *id;
struct lbs *lbls;
}

/* tokens */
%start program
%token <intval> NUMBER /* Simple integer */
%token <id> IDENTIFIER /* Simple identifier */
%token <lbls> IF WHILE /* For backpatching labels */
%token SKIP THEN ELSE FI DO END
%token INTEGER READ WRITE LET IN
%token ATRIBUICAO

%left '-' '+'
%left '*' '/'
%right '^'


/* procedencias */
/* %left "&&" "||"
%right '!'
%left '<' '<=' ">" ">=" 
%left "==" "!="
%left '+' '-'
%left '*' '/' */

%%

program : LET {;}
            declarations 
        IN {;}
            commands 
        END {;}
;
declarations : /* empty */
| INTEGER id_seq IDENTIFIER '.' {install($3);}
;
id_seq : /* empty */
| id_seq IDENTIFIER ',' {install($2);}
;
commands : /* empty */
| commands command ';'
;
command : SKIP
| READ IDENTIFIER
| WRITE exp
| IDENTIFIER ATRIBUICAO exp {gen_code('assign')}
| IF exp THEN commands ELSE commands FI
| WHILE exp DO commands END
;
exp : NUMBER {gen_code('store_imm', $1)}
| IDENTIFIER {gen_code('store', $1)}
| exp '<' exp {}
| exp '=' exp
| exp '>' exp
| exp '+' exp {gen_code('add')}
| exp '-' exp
| exp '*' exp
| exp '/' exp
| exp '^' exp
| '(' exp ')'
;

%%
/* namespace yy
{
  // Report an error to the user.
  auto parser::error (const std::string& msg) -> void
  {
    std::cerr << msg << '\n';
  }
} */
void yyerror (const char *error)
{
  std::cout << error << std::endl;
}

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

