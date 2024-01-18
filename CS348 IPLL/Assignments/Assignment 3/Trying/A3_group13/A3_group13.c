#include<stdio.h>
#include<string.h>

#define KEYWORD         1
#define ID              2
#define INT_CONST       3
#define CHAR_CONST      4
#define STRING          5
#define PUNC            6
#define SIN_COMMENT     7
#define MULT_COMMENT    8

extern int yylex();
extern char * yytext;
extern FILE * yyin;


int main()	
{
	FILE *myfile = fopen("A3_group13.nc", "r");
	FILE *out = fopen("out.txt", "w");

	if (!myfile) {
		fprintf(out, "Can't open A3_group13.nc file! Check file name\n");
		return -1;
	}

	yyin = myfile;

	int token;
	while (token = yylex()) 
	{
		switch (token) 
		{
			case KEYWORD:{
				fprintf(out, "<KEYWORD, %d, %s>\n",token, yytext);break;
			}			
			case ID:{
				fprintf(out, "<IDENTIFIER, %d, %s>\n",token, yytext);break;
			}
			case INT_CONST:{
				fprintf(out, "<INTEGER CONST, %d, %s>\n",token, yytext);break;
			}
			case CHAR_CONST:{
				int p = strlen(yytext);
				char pp[p-2];
				for(int i=1; i<p-1; i++){
					pp[i-1] = yytext[i];
				}
				pp[p-2]='\0';
				fprintf(out, "<CHAR CONST, %d, %s>\n",token, pp);break;
			}
			case STRING:{
				int p = strlen(yytext);
				char pp[p-2];
				for(int i=1; i<p-1; i++){
					pp[i-1] = yytext[i];
				}
				pp[p-2]='\0';
				fprintf(out, "<STRING, %d, %s>\n",token, pp);break;
			}
			case PUNC:{
				fprintf(out, "<PUNCTUATOR, %d, %s>\n",token, yytext);break;
			}
			case SIN_COMMENT:{
				fprintf(out, "<SINGLE LINE COMMENT, %d, %s>",token, yytext);break;
			}
			case MULT_COMMENT:{
				fprintf(out, "<MULTILINE COMMENT, %d, %s>\n",token, yytext);break;
			}
		}
	}
}

int yywrap(){
	return 1;
}