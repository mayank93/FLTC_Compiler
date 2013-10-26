%{
	#include "phase1.tab.h"
	int lineNo=1;
	int flag=0;
%}
digit [0-9]
letter_ [_a-zA-Z]
ws [ \t]+
INTEGER {digit}+
ID {letter_}({letter_}|{digit})*
LE <=
GE >=
NE !=
EQ ==
AND &&
OR \|\|
BOOL (true|false)
SingleChar [-|+|*|/|(|)|{|}|\[|\]|=|,|;|!|<|>]
STRING	\"(.)*\"
CHARACTER \'.\'
%%

{SingleChar}	{ 
			//printf("%c\n",yytext[0]);
			//printf("single\n");
			return yytext[0];
		}
{LE}		{
			//printf("%s\n",yytext);
			//printf("LE\n");
			return LE;
		}
{GE}		{
			//printf("%s\n",yytext);
			//printf("GE\n");
			return GE;
		}
{NE}		{
			//printf("%s\n",yytext);
			//printf("NE\n");
			return NE;
		}
{EQ}		{
			//printf("%s\n",yytext);
			//printf("EQ\n");
			return EQ;
		}
"int"		{
			//printf("%s\n",yytext);
			//printf("INT\n");
			return INT;
		}
"boolean"	{
			//printf("%s\n",yytext);
			//printf("BOOLEAN\n");
			return BOOLEAN;
		}
"char"		{
			//printf("%s\n",yytext);
			//printf("CHAR\n");
			return CHAR;
		}
"if"		{
			//printf("%s\n",yytext);
			//printf("IF\n");
			return IF;
		}
"then"		{
			//printf("%s\n",yytext);
			//printf("THEN\n");
			return THEN;
		}
"goto"		{
			//printf("%s\n",yytext);
			flag=1;
			//printf("GOTO\n");
			return GOTO;
		}
"class"		{
			//printf("%s\n",yytext);
			//printf("CLASS\n");
			return CLASS;
		}
"main"		{
			//printf("%s\n",yytext);
			//printf("MAIN\n");
			return MAIN;
		}
"print"		{
			//printf("%s\n",yytext);
			//printf("PRINT\n");
			return PRINT;
		}
"read"		{
			//printf("%s\n",yytext);
			//printf("READ\n");
			return READ;
		}
{AND}		{
			//printf("%s\n",yytext);
			//printf("AND\n");
			return AND;
		}
{OR}		{
			//printf("%s\n",yytext);
			//printf("OR\n");
			return OR;
		}
{BOOL}		{
			//printf("%s\n",yytext);
			//printf("BOOL\n");
			return BOOL;
		}
{INTEGER}	{
			//printf("%s\n",yytext);
			//printf("INTEGER\n");
			return INTEGER;
		}
{CHARACTER}	{
			//printf("%s\n",yytext);
			//printf("CHARACTER\n");
			return CHARACTER;
		}
{STRING}	{
			//printf("%s\n",yytext);
			//printf("STRING\n");
			return STRING;
		}
{ID}:		{
			//printf("%s\n",yytext);
			//printf("LABEL_SMT\n");
			return LABEL_SMT;
		}
{ID}		{
			//printf("%s\n",yytext);
			if(flag==1){
				flag=0;
				//printf("LABEL\n");
				return LABEL;
			}else{
				//printf("ID\n");
				return ID;
			}
		}
[\n]		{
			lineNo++;
		}
{ws}  		{}

[.]		{ 
			printf("Unexpected character %c in line %d\n", *yytext,lineNo); 
			exit(0);
		}


%%
int yywrap(void)
{
	return 1;
}
/*
int main(int argc , char *argv[])
{
	yyin = fopen(argv[1], "r");
	yylex();

	fclose(yyin);
	return 0;
}
*/
