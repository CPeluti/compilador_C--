sintaxe:  sintaxe.l sintaxe.y
	bison -d sintaxe.y
	flex sintaxe.l
	g++ -o $@ sintaxe.tab.c lex.yy.c st.cpp st.h gc.cpp gc.h -lfl