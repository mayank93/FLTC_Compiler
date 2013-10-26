phase1: phase1.l phase1.y
	bison -d phase1.y
	flex phase1.l
	gcc -o $@ phase1.tab.c lex.yy.c -lfl
clean:
	rm phase1.tab.c lex.yy.c phase1.tab.h phase1
