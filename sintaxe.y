%{
    #include <bits/stdc++.h>
    #include<fstream>
    #include "st.h"
    #include "gc.h"
    extern FILE *yyin;
    ST symbol_table;
    GC code_generator;

    int yylex(void);
    int while_counter = 0;
    int if_counter = 0;
    std::stack<std::string> context;

    void parse_sym_table(ST symbol_table){
        for(auto sym : symbol_table.symbol_table){
            code_generator.gen_code("symbol", sym);
        }
    }
    void set_context(char f){
        std::string s = "";
        switch(f){
            case 'w':
                s= "while_"+std::to_string(while_counter++);
                break;
            case 'i':
                s= "if_"+std::to_string(if_counter++);
                break;
        }
        code_generator.gen_code("label", s);
        context.push(s);
    }
    void end_context(char f='w'){
        std::string s= "end_"+context.top();
        if(f=='w'){
            code_generator.gen_code("jump", context.top());
        }
        code_generator.gen_code("label", s);
        context.pop();
    }
    void check_context(){
        if(context.size() == 0){
            std::cout << "Skip cannot be used out of an while" << std::endl;
        } else {
            code_generator.gen_code("jump", context.top());
        }
    }
    void yyerror(const char *);
    void install (std::string* sym_name)
    {
        std::string var_name = *sym_name;
        bool s = symbol_table.exist_symbol(var_name);
        if(!s){
            symbol_table.insert_symbol(var_name);

        }else 
            std::cout << var_name << " " << "is already defined" << std::endl;
    }
%}


%union {
std::string *intval;
std::string *id;
struct lbs *lbls;
}

/* tokens */
%start program
%token <intval> NUMBER /* Simple integer */
%token <id> IDENTIFIER /* Simple identifier */
%token <lbls> IF WHILE /* For backpatching labels */
%token SKIP THEN ELSE FI DO END
%token INTEGER READ WRITE ENDL LET IN
%token ATRIBUICAO

%left '-' '+'
%left '*' '/'
%right '^'

%%

program : LET {code_generator.gen_code("data");}
            declarations 
        IN {parse_sym_table(symbol_table);code_generator.gen_code("text");}
            commands 
        END {code_generator.gen_code("end");}
;
declarations : /* empty */
| INTEGER id_seq IDENTIFIER     {install($3);}
;
id_seq : /* empty */
| id_seq IDENTIFIER ','         {install($2);}
;
commands : /* empty */
| commands command
;
command : SKIP                              {check_context();}
| READ IDENTIFIER                           {code_generator.gen_code("read", *$2);}
| WRITE exp {code_generator.gen_code("write");} endl                    
| IDENTIFIER ATRIBUICAO exp                 {code_generator.gen_code("assign", *$1);}
| IF{set_context('i');} exp THEN{code_generator.gen_code("check", "else_"+context.top());} commands ELSE{code_generator.gen_code("label", "else_"+context.top());} commands FI{end_context('e');}
| WHILE{set_context('w');} exp DO{code_generator.gen_code("check", "end_"+context.top());} commands END{end_context();}
;
endl: 
| ENDL{code_generator.gen_code("endl");}
;
exp : NUMBER    {code_generator.gen_code("store_imm", *$1);}
| IDENTIFIER    {code_generator.gen_code("store", *$1);}
| exp '<' exp   {code_generator.gen_code("less");}
| exp '=' exp   {code_generator.gen_code("equal");}
| exp '>' exp   {code_generator.gen_code("greater");}
| exp '-' exp   {code_generator.gen_code("sub");}
| exp '+' exp   {code_generator.gen_code("add");}
| exp '*' exp   {code_generator.gen_code("mul");}
| exp '/' exp   {code_generator.gen_code("div");}
| exp '^' exp   {code_generator.gen_code("pow");}
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

	yyparse();
	if(argc){
        std::ofstream yyout(argv[1]);
        for(int i = 0; i<code_generator.code.size(); i++){
            yyout << code_generator.code[i];
        }
	    yyout.close();
    }

    /* for(auto it = tabela.cbegin(); it != tabela.cend(); ++it){
        std::cout << it->second.first << " " << it->second.second << std::endl;
    } */
        /* for(auto it = tabela_func.cbegin(); it != tabela_func.cend(); ++it){
            std::cout << it->second.first << " ";
            for(auto x : it->second.second)
                std::cout << x << std::endl;
        } */
	fclose(yyin);
	return 0;
}

