%{
#include <stdio.h>
#include<stdlib.h>
FILE* yyin;
extern int lineNo;
%}

%token LE GE EQ NE OR AND INT BOOLEAN CHAR IF THEN GOTO CLASS MAIN PRINT READ
%token BOOL INTEGER CHARACTER STRING LABEL ID LABEL_SMT

%right '='
%left OR
%left AND
%left EQ NE
%left '>' '<' GE LE
%left '+' '-'
%left '*' '/'
%right '!'
%nonassoc UPLUS
%nonassoc UMINUS

%%

Program: 		CLASS MAIN '{' E T '}'
			;
E: 			Field_Decl E
			| 
			;
Field_Decl: 		Type I
			;
I:			ID ',' I
			|ID '[' INTEGER ']' ',' I
			|ID ';'
			|ID '[' INTEGER ']' ';'
			;
Type:			INT
			|BOOLEAN
			|CHAR
			;
T:			Statement T
			|
			;
Statement:		Labelled_Statement
			|Location '=' Expr ';'
			|IF Expr THEN GOTO LABEL ';'
			|GOTO LABEL ';'
			|Method_Call
			;
Labelled_Statement:	LABEL_SMT Statement
			;
Location:		ID
			|ID '[' Expr ']'
			;
Expr:			Literal
			|Location
			|Expr '+' Expr
			|Expr '-' Expr
			|Expr '/' Expr
			|Expr '*' Expr
			|Expr '>' Expr
			|Expr '<' Expr
			|Expr GE Expr
			|Expr LE Expr
			|Expr NE Expr
			|Expr EQ Expr
			|Expr AND Expr
			|Expr OR Expr
			|'-' Expr %prec UMINUS
			|'+' Expr %prec UPLUS
			|'!' Expr
			|'(' Expr ')'
			;
Method_Call:		PRINT '(' L ')' ';'
			|READ '(' Location ')' ';'
			;
L:			Expr ',' L
			|Expr
			;
Literal:		INTEGER
			|STRING
			|CHARACTER
			|BOOL

%%

char *progname;
int main(int argc, char **argv){
	progname=argv[0];
	yyin=fopen(argv[1],"r");
	yyparse();
	fclose(yyin);
	return 0;
}
/*
yyerror(char *s){
	fprintf(stderr, "ERROR in line %d\n", lineNo);
}
*/
yyerror(char *s)
{
	warning(s,(char *)0);
}
warning(char *s,char *t)
{
	fprintf(stderr,"%s:%s",progname,s);
	if(t)
		fprintf(stderr," %s",t);
	fprintf(stderr," near line %d\n",lineNo);
}
