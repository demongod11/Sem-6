%{
    #include <stdio.h>
    #include <string.h>
    #include "y.tab.h"
    extern void yyerror(const char *);
    int line = 0;
%}

%x MULTI_LINE_COMMENT
%x SINGLE_LINE_COMMENT

PUNCTUATOR "["|"]"|"("|")"|"{"|"}"|"."|"->"|"++"|"--"|"&"|"*"|"+"|"-"|"~"|"!"|"/"|"%"|"<<"|">>"|"<"|">"|"<="|">="|"=="|"!="|"^"|"|"|"&&"|"||"|"?"|":"|";"|"..."|"="|"*="|"/="|"%="|"+="|"-="|"<<="|">>="|"&="|"^="|"|="|","|"#"

ESCAPE_SEQUENCE "\\\'"|"\\\""|"\?"|"\\"|"\a"|"\b"|"\f"|"\n"|"\r"|"\t"|"\v"

KEYWORD "auto"|"enum"|"restrict"|"unsigned"|"break"|"extern"|"return"|"void"|"case"|"float"|"short"|"volatile"|"char"|"for"|"signed"|"while"|"const"|"goto"|"sizeof"|"_Bool"|"continue"|"if"|"static"|"_Complex"|"default"|"inline"|"struct"|"_Imaginary"|"do"|"int"|"switch"|"double"|"long"|"typedef"|"else"|"register"|"union"

IDENTIFIER [a-zA-Z_][a-zA-Z0-9_]*

DIGIT [0-9]
DIGIT_SEQUENCE [0-9]+
INTEGER_CONSTANT [1-9][0-9]*|[0]+
SIGN "+"|"-"
EXPONENT_PART ([Ee]([+-]?))({DIGIT_SEQUENCE})
FRACTIONAL_CONSTANT ({DIGIT_SEQUENCE}\.)|({DIGIT_SEQUENCE}?\.{DIGIT_SEQUENCE})
FLOAT_CONSTANT ({DIGIT_SEQUENCE}{EXPONENT_PART})|({FRACTIONAL_CONSTANT}{EXPONENT_PART}?)

S_CHAR [^\"\n\\]|{ESCAPE_SEQUENCE}
S_CHAR_SEQUENCE {S_CHAR}+
STRING_LITERAL \"({S_CHAR_SEQUENCE})?\"

C_CHAR [^\'\n\\]|{ESCAPE_SEQUENCE}
C_CHAR_SEQUENCE ({C_CHAR})+
CHAR_CONSTANT \'({C_CHAR_SEQUENCE})\'

ENUMERATION_CONSTANT {IDENTIFIER}
CONST {INTEGER_CONSTANT}|{CHAR_CONSTANT}|{FLOAT_CONSTANT}|{ENUMERATION_CONSTANT}

%%

{PUNCTUATOR} {
    if(strcmp(yytext,"[")==0)return ('[');
    if(strcmp(yytext,"]")==0)return (']');
    if(strcmp(yytext,"(")==0)return ('(');
    if(strcmp(yytext,")")==0)return (')');
    if(strcmp(yytext,"{")==0)return ('{');
    if(strcmp(yytext,"}")==0)return ('}');
    if(strcmp(yytext,".")==0)return ('.');
    if(strcmp(yytext,",")==0)return (',');
    if(strcmp(yytext,"?")==0)return ('?');
    if(strcmp(yytext,":")==0)return (':');
    if(strcmp(yytext,";")==0)return (';');
    if(strcmp(yytext,"=")==0)return ('=');
    if(strcmp(yytext,"<")==0)return ('<');
    if(strcmp(yytext,">")==0)return ('>');
    if(strcmp(yytext,"#")==0)return ('#');
    if(strcmp(yytext,"*")==0)return MUL;
    if(strcmp(yytext,"+")==0)return ADD;
    if(strcmp(yytext,"-")==0)return SUB;
    if(strcmp(yytext,"/")==0)return DIV;
    if(strcmp(yytext,"%")==0)return MOD;
    if(strcmp(yytext,"&")==0)return BITWISE_AND;
    if(strcmp(yytext,"~")==0)return BITWISE_NOT;
    if(strcmp(yytext,"^")==0)return BITWISE_XOR;
    if(strcmp(yytext,"|")==0)return BITWISE_OR;
    if(strcmp(yytext,"!")==0)return EXCLAIM;
    if(strcmp(yytext,"->")==0) return ARROW;
    if(strcmp(yytext,"++")==0) return PLUS_PLUS;
    if(strcmp(yytext,"--")==0) return MINUS_MINUS;
    if(strcmp(yytext,"<<")==0) return LEFT_SHIFT;
    if(strcmp(yytext,">>")==0) return RIGHT_SHIFT;
    if(strcmp(yytext,"<=")==0) return LEQ;
    if(strcmp(yytext,">=")==0) return GEQ;
    if(strcmp(yytext,"==")==0) return EQ;
    if(strcmp(yytext,"!=")==0) return NQ;
    if(strcmp(yytext,"&&")==0) return AND;
    if(strcmp(yytext,"||")==0) return OR;
    if(strcmp(yytext,"*=")==0) return MULT_ASSIGN;
    if(strcmp(yytext,"/=")==0) return DIV_ASSIGN;
    if(strcmp(yytext,"%=")==0) return MOD_ASSIGN;
    if(strcmp(yytext,"+=")==0) return ADD_ASSIGN;
    if(strcmp(yytext,"-=")==0) return SUB_ASSIGN;
    if(strcmp(yytext,"&=")==0) return BIN_AND_ASSIGN;
    if(strcmp(yytext,"^=")==0) return BIN_XOR_ASSIGN;
    if(strcmp(yytext,"|=")==0) return BIN_OR_ASSIGN;
    if(strcmp(yytext,"<<=")==0) return LEFT_SHIFT_ASSIGN;
    if(strcmp(yytext,">>=")==0) return RIGHT_SHIFT_ASSIGN;
    if(strcmp(yytext,"...")==0) return ELLIPSIS;
}



{KEYWORD} {
    if(strcmp(yytext,"auto")==0)return AUTO;
    if(strcmp(yytext,"enum")==0)return ENUM;
    if(strcmp(yytext,"restrict")==0)return RESTRICT;
    if(strcmp(yytext,"unsigned")==0)return UNSIGNED;
    if(strcmp(yytext,"break")==0)return BREAK;
    if(strcmp(yytext,"extern")==0)return EXTERN;
    if(strcmp(yytext,"return")==0)return RETURN;
    if(strcmp(yytext,"void")==0)return VOID;
    if(strcmp(yytext,"case")==0)return CASE;
    if(strcmp(yytext,"float")==0)return FLOAT;
    if(strcmp(yytext,"short")==0)return SHORT;
    if(strcmp(yytext,"volatile")==0)return VOLATILE;
    if(strcmp(yytext,"char")==0)return CHAR;
    if(strcmp(yytext,"for")==0)return FOR;
    if(strcmp(yytext,"signed")==0)return SIGNED;
    if(strcmp(yytext,"while")==0)return WHILE;
    if(strcmp(yytext,"const")==0)return CONST;
    if(strcmp(yytext,"goto")==0)return GOTO;
    if(strcmp(yytext,"sizeof")==0)return SIZEOF;
    if(strcmp(yytext,"_Bool")==0)return _BOOL;
    if(strcmp(yytext,"continue")==0)return CONTINUE;
    if(strcmp(yytext,"if")==0)return IF;
    if(strcmp(yytext,"static")==0)return STATIC;
    if(strcmp(yytext,"_Complex")==0)return _COMPLEX;
    if(strcmp(yytext,"default")==0)return DEFAULT;
    if(strcmp(yytext,"inline")==0)return INLINE;
    if(strcmp(yytext,"struct")==0)return STRUCT;
    if(strcmp(yytext,"_Imaginary")==0)return _IMAGINARY;
    if(strcmp(yytext,"do")==0)return DO;
    if(strcmp(yytext,"int")==0)return INT;
    if(strcmp(yytext,"switch")==0)return SWITCH;
    if(strcmp(yytext,"double")==0)return DOUBLE;
    if(strcmp(yytext,"long")==0)return LONG;
    if(strcmp(yytext,"typedef")==0)return TYPEDEF;
    if(strcmp(yytext,"else")==0)return ELSE;
    if(strcmp(yytext,"register")==0)return REGISTER;
    if(strcmp(yytext,"union")==0)return UNION;         
}

{IDENTIFIER} { return IDENTIFIER;}
{INTEGER_CONSTANT} { return INTEGER_CONSTANT;}
{FLOAT_CONSTANT} { return FLOAT_CONSTANT;}
{STRING_LITERAL} { return STRING_LITERAL; }
{CHAR_CONSTANT} { return CHAR_CONSTANT; }

"\n"                        { line++; printf("*** Line number %d ended ***\n", line); }
{ESCAPE_SEQUENCE}|" " { }

"/*" { BEGIN(MULTI_LINE_COMMENT); }
<MULTI_LINE_COMMENT>"*/" { BEGIN(INITIAL); }
<MULTI_LINE_COMMENT>. { }
<MULTI_LINE_COMMENT>"\n" { line++; printf("Multi-line Comment Line no. : %d\n", line);}

"//" { BEGIN(SINGLE_LINE_COMMENT);}
<SINGLE_LINE_COMMENT>"\n" { line++;printf("Single-line Comment Line no. : %d\n", line); BEGIN(INITIAL);}
<SINGLE_LINE_COMMENT>. {

}

%%