bison -d $1.y
flex $1.l
g++ $1.tab.c lex.yy.c -lfl -o $1

