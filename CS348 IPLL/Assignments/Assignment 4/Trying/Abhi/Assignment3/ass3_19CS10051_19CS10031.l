%{
    #include "header.h"
%}

NON_DIGIT           [a-zA-Z_]
DIGIT               [0-9]
ZERO                "0"
IDENTIFIER          ({NON_DIGIT}({NON_DIGIT}|{DIGIT})*)

NON_ZERO_DIGIT      [1-9]
INT_CONST           (({NON_ZERO_DIGIT}{DIGIT}*)|{ZERO}+)
DOT                 "."
DIGIT_SEQ           {DIGIT}+
SIGN                [+-]
EXP_PART            ([eE]{SIGN}?{DIGIT_SEQ})
FLT_CONST           (({FRAC_CONST}{EXP_PART}?)|({DIGIT_SEQ}{EXP_PART}))
FRAC_CONST          (({DIGIT_SEQ}?{DOT}{DIGIT_SEQ})|({DIGIT_SEQ}{DOT}))
ESC_SEQ             ([\\][\'\"\?\\abfnrtv])
C_CHAR              ([^\'\\\n']|{ESC_SEQ})
C_CHAR_SEQ          ({C_CHAR}+)
CHAR_CONST          ([\']{C_CHAR_SEQ}[\'])

S_CHAR              {C_CHAR}
S_CHAR_SEQ          ({S_CHAR}+)
STR_LIT             ([\"]{S_CHAR_SEQ}?[\"])

SINGLE_COMMENT      [/][/].*
MULTI_START         [/][\*]+
INSIDE_MULTI        ([^\*]|([\*]+[^\*]))
MULTI_END           [\*]+[/]
MULTI_COMMENT       ({MULTI_START}{INSIDE_MULTI}*{MULTI_END})
COMMENT             {MULTI_COMMENT}|{SINGLE_COMMENT}

WHITESPACE          [ \n\t]

%%
{COMMENT}           { return COMMENT; }

"auto"              { return AUTO; }
"enum"              { return ENUM; }
"restrict"          { return RESTRICT; }
"unsigned"          { return UNSIGNED; }
"break"             { return BREAK; }
"extern"            { return EXTERN; }
"return"            { return RETURN; }
"void"              { return VOID; }
"case"              { return CASE; }
"float"             { return FLOAT; }
"short"             { return SHORT; }
"volatile"          { return VOLATILE; }
"char"              { return CHAR; }
"for"               { return FOR; }
"signed"            { return SIGNED; }
"while"             { return WHILE; }
"const"             { return CONST; }
"goto"              { return GOTO; }
"sizeof"            { return SIZEOF; }
"_Bool"             { return _BOOL; }
"continue"          { return CONTINUE; }
"if"                { return IF; }
"static"            { return STATIC; }
"_Complex"          { return _COMPLEX; }
"default"           { return DEFAULT; }
"inline"            { return INLINE; }
"struct"            { return STRUCT; }
"_Imaginary"        { return _IMAGINARY; }
"do"                { return DO; }
"int"               { return INT; }
"switch"            { return SWITCH; }
"double"            { return DOUBLE; }
"long"              { return LONG; }
"typedef"           { return TYPEDEF; }
"else"              { return ELSE; }
"register"          { return REGISTER; }
"union"             { return UNION; }

"..."               { return TDOT; }
"="                 { return EQUAL; }
"%="                { return MODEQ; }
"+="                { return ADDEQ; }
"*="                { return MULEQ; }
"/="                { return DIVEQ; }
"-="                { return SUBEQ; }
"<<="               { return SHLEQ; }
">>="               { return SHREQ; }
"["                 { return SQROPEN; }
"]"                 { return SQRCLOSE; }
"("                 { return CIROPEN; }
")"                 { return CIRCLOSE; }
"{"                 { return CUROPEN; }
"}"                 { return CURCLOSE; }
"."                 { return DOT; }
"->"                { return ARROW; }
"++"                { return INCRE; }
"--"                { return DECRE; }
"&"                 { return AND; }
"*"                 { return MUL; }
"+"                 { return ADD; }
"-"                 { return SUB; }
"~"                 { return NEQ; }
"!"                 { return EXCL; }
"/"                 { return DIV; }
"%"                 { return MOD; }
"<<"                { return LESH; }
">>"                { return RISH; }
"<"                 { return LST; }
">"                 { return GRT; }
"<="                { return LSE; }
">="                { return GRE; }
"=="                { return EQUATE; }
"!="                { return NEQE; }
"^"                 { return XOR; }
"|"                 { return OR; }
"&&"                { return ANDNUM; }
"||"                { return ORNUM; }
"?"                 { return QUESTION; }
":"                 { return COLON; }
";"                 { return LINEEND; }
"&="                { return ANDE; }
"^="                { return XORE; }
"|="                { return ORE; }
","                 { return COMMA; }
"#"                 { return HASH; }

{IDENTIFIER}        { return IDENTIFIER;}
{FLT_CONST}             { return FLT_CONST;}
{INT_CONST}             { return INT_CONST;}
{CHAR_CONST}             { return CHAR_CONST;}
{STR_LIT}           { return STRING_LITERAL;}
{WHITESPACE}        {;}

%%