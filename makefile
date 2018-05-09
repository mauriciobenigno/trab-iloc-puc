iloc: scanner.l token.y
	bison -d token.y
	flex scanner.l
	gcc -o token.tab.c lex.yy.c -lfl
