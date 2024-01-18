%{
	#include <stdio.h>
	#include "y.tab.h"
	extern void yyerror(const char *);
    int lineNum = 1;
%}

%x  MULTI_LINE_COMMENT
%x  SINGLE_LINE_COMMENT

KEYWORD                 "auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"inline"|"int"|"long"|"register"|"restrict"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while"|"_Bool"|"_Complex"|"_Imaginary" 


IDENTIFIER_NON_DIGIT    [a-zA-Z_]
DIGIT                   [0-9]
IDENTIFIER              {IDENTIFIER_NON_DIGIT}({IDENTIFIER_NON_DIGIT}|{DIGIT})*


ESCAPE_SEQUENCE         "\\\'"|"\\\""|"\\\?"|"\\"|"\a"|"\b"|"\f"|"\n"|"\r"|"\t"|"\v"
INTEGER_CONSTANT        [0]+|[1-9]({DIGIT})*
DIGIT_SEQUENCE          [0-9]+
FRACTIONAL_CONSTANT     {DIGIT_SEQUENCE}\.|{DIGIT_SEQUENCE}?\.{DIGIT_SEQUENCE} 
EXPONENT_PART           [eE]([+-]?){DIGIT_SEQUENCE}
FLOATING_CONSTANT       ({FRACTIONAL_CONSTANT}({EXPONENT_PART}?))|({DIGIT_SEQUENCE}{EXPONENT_PART}) 


C_CHAR                  [^\n\'\\']|{ESCAPE_SEQUENCE}
C_CHAR_SEQ              ({C_CHAR})+
CHARACTER_CONSTANT      \'({C_CHAR_SEQ})\'
ENUMERATION_CONSTANT    {IDENTIFIER}
CONSTANT                {INTEGER_CONSTANT}|{FLOATING_CONSTANT}|{CHARACTER_CONSTANT}|{ENUMERATION_CONSTANT}


S_CHAR                  [^\"\n\\]|{ESCAPE_SEQUENCE}
S_CHAR_SEQ              {S_CHAR}+
STRING_LITERAL          \"({S_CHAR_SEQ})?\"


PUNCTUATOR              "["|"]"|"("|")"|"{"|"}"|"."|"->"|"++"|"--"|"&"|"*"|"+"|"-"|"~"|"!"|"/"|"%"|"<<"|">>"|"<"|">"|"<="|">="|"=="|"!="|"^"|"|"|"&&"|"||"|"?"|":"|";"|"..."|"="|"*="|"/="|"%="|"+="|"-="|"<<="|">>="|"&="|"^="|"|="|","|"#"

%%			

"sizeof"        { return SIZEOF; }
"extern"        { return EXTERN; }
"static"        { return STATIC; }
"auto"			{ return AUTO; }
"register"      { return REGISTER; }
"struct"		{ return STRUCT; }
"typedef" 		{ return TYPEDEF; }
"union"			{ return UNION; }
"void"          { return VOID; }
"char"          { return CHAR; }
"short"         { return SHORT; }
"int"           { return INT; }
"long"          { return LONG; }
"float"         { return FLOAT; }
"double"        { return DOUBLE; }
"signed"        { return SIGNED; }
"unsigned"      { return UNSIGNED; }
"_Bool"         { return _BOOL; }
"_Complex"      { return _COMPLEX; }
"_Imaginary"    { return _IMAGINARY; }
"enum"          { return ENUM; }
"const"         { return CONST; }
"restrict"      { return RESTRICT; }
"volatile"      { return VOLATILE; }
"inline"        { return INLINE; }
"case"          { return CASE; }
"default"       { return DEFAULT; }
"if"            { return IF; }
"else"          { return ELSE; }
"switch"        { return SWITCH; }
"while"         { return WHILE; }
"do"            { return DO; }
"for"           { return FOR; }
"goto"          { return GOTO; }
"continue"      { return CONTINUE; }
"break"         { return BREAK; }
"return"        { return RETURN; }

{IDENTIFIER}				{ return IDENTIFIER; }
{STRING_LITERAL} 			{ return STRING_LITERAL; }
{INTEGER_CONSTANT} 			{ return INTEGER_CONSTANT; }
{FLOATING_CONSTANT} 		{ return FLOATING_CONSTANT; }
{CHARACTER_CONSTANT} 		{ return CHARACTER_CONSTANT; }
"\n"                        { printf("\n#################### LINE NO : %d ####################\n", ++lineNum); }
{ESCAPE_SEQUENCE}|" "		{ /* Ignore Whitespace and Escape Sequence */ }   

"/*"                        { BEGIN(MULTI_LINE_COMMENT); printf("\n******************* Multi Line Comment Starts at Line = %d *******************\n", lineNum);              }
<MULTI_LINE_COMMENT>"*/"    { BEGIN(INITIAL); printf("\n******************* Multi Line Comment Ends at Line = %d *******************\n", lineNum);              }
<MULTI_LINE_COMMENT>.       {                               }
<MULTI_LINE_COMMENT>"\n"    { printf("\n---------------------  Comment at Line = %d  ------------------\n", ++lineNum); }

"//"                        { BEGIN(SINGLE_LINE_COMMENT);   }
<SINGLE_LINE_COMMENT>"\n"   { lineNum++; BEGIN(INITIAL);       }
<SINGLE_LINE_COMMENT>.      {                               }    

		
"["                         { return('['); }
"]"                         { return(']'); }
"("                         { return('('); }
")"                         { return(')'); }
"{"                         { return('{'); }
"}"                         { return('}'); }
"."                         { return('.'); }
"->"                        { return(ARROW);} 
"++"                        { return(INC); }
"--"                        { return(DEC); }
"&"                         { return(BITWISE_AND); }
"*"                         { return(MUL); }
"+"                         { return(ADD); }
"-"                         { return(SUB); }
"~"                         { return(BITWISE_NOT); }
"!"                         { return('!'); }
"/"                         { return(DIV); }
"%"                         { return(MOD); }
">>"                        { return(SHIFT_LEFT); }
"<<"                        { return(SHIFT_RIGHT);}
"<"                         { return(LT); }
">"                         { return(GT); }
"<="                        { return(LTE); }
">="                        { return(GTE); }
"=="                        { return(EQ);  }
"!="                        { return(NEQ); } 
"^"                         { return(BITWISE_XOR); } 
"|"                         { return(BITWISE_OR); }
"||"                        { return(OR);  }
"&&"                        { return(AND); }
"?"                         { return('?'); }
":"                         { return(COLON); }
";"                         { return(SEMICOLON); }
"..."                       { return(ELLIPSIS); }
"="                         { return(ASSIGN); }
"*="                        { return(MUL_EQ); }
"/="                        { return(DIV_EQ); }
"%="                        { return(MOD_EQ); }
"+="                        { return(ADD_EQ); }
"-="                        { return(SUB_EQ); }
"<<="                       { return(SHIFT_LEFT_EQ);  }
">>="                       { return(SHIFT_RIGHT_EQ);  }
"&="                        { return(BITWISE_AND_EQ); }
"^="                        { return(BITWISE_XOR_EQ); }
"|="                        { return(BITWISE_OR_EQ);  }
","                         { return(COMMA); }
"#"                         { return(HASH);  }

%%