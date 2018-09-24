iloc: scanner.l token.y
	bison -d token.y
	flex scanner.l
	gcc -Wall -o cop token.tab.c lex.yy.c -lfl
