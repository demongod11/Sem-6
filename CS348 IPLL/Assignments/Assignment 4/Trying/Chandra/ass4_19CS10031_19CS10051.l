%{
    #include "y.tab.h"
    int lineNum = 1;
%}

%x  MULTI_LINE_COMMENT
%x  SINGLE_LINE_COMMENT

NON_DIGIT           [a-zA-Z_]
DIGIT               [0-9]
ZERO                "0"
IDENTIFIER          ({NON_DIGIT}({NON_DIGIT}|{DIGIT})*)

NON_ZERO_DIGIT      [1-9]
INT_CONST           (({NON_ZERO_DIGIT}{DIGIT}*)|{ZERO}+)
SIGN                [+-]
ESC_SEQ             ([\\][\'\"\?\\abfnrtv])
C_CHAR              ([^\'\\\n']|{ESC_SEQ})
C_CHAR_SEQ          ({C_CHAR}+)
CHAR_CONST          ([\']{C_CHAR_SEQ}[\'])
CONST               ({INT_CONST}|{CHAR_CONST})

S_CHAR              {C_CHAR}
S_CHAR_SEQ          ({S_CHAR}+)
STR_LIT             ([\"]{S_CHAR_SEQ}?[\"])

SINGLE_COMMENT      [/][/].*
MULTI_START         [/][\*]+
INSIDE_MULTI        ([^\*]|([\*]+[^/\*]))
MULTI_END           [\*]+[/]
MULTI_COMMENT       ({MULTI_START}{INSIDE_MULTI}*{MULTI_END})
COMMENT             {MULTI_COMMENT}|{SINGLE_COMMENT}

WHITESPACE          [ \n\t]

%%

"/*"                        { BEGIN(MULTI_LINE_COMMENT); printf("\n******************* Multi Line Comment Starts at Line = %d *******************\n", lineNum);}
<MULTI_LINE_COMMENT>"*/"    { BEGIN(INITIAL); printf("\n******************* Multi Line Comment Ends at Line = %d *******************\n", lineNum);}
<MULTI_LINE_COMMENT>.       {}
<MULTI_LINE_COMMENT>"\n"    { printf("\n---------------------  Comment at Line = %d  ------------------\n", ++lineNum);}

"//"                        { BEGIN(SINGLE_LINE_COMMENT); {printf("\n--------------------- Single Line Comment at Line = %d  ------------------\n", lineNum);}}
<SINGLE_LINE_COMMENT>"\n"   { lineNum++; BEGIN(INITIAL);{printf("\n#################### LINE NO : %d ####################\n", lineNum);}}
<SINGLE_LINE_COMMENT>.      {}    


"return"            { return RETURN; }
"void"              { return VOID; }
"char"              { return CHAR; }
"for"               { return FOR; }
"if"                { return IF; }
"int"               { return INT; }
"else"              { return ELSE; }
"="                 { return EQUAL; }
"["                 { return SQROPEN; }
"]"                 { return SQRCLOSE; }
"("                 { return CIROPEN; }
")"                 { return CIRCLOSE; }
"{"                 { return CUROPEN; }
"}"                 { return CURCLOSE; }
"->"                { return ARROW; }
"&"                 { return AND; }
"*"                 { return MUL; }
"+"                 { return ADD; }
"-"                 { return SUB; }
"!"                 { return EXCL; }
"/"                 { return DIV; }
"%"                 { return MOD; }
"<"                 { return LST; }
">"                 { return GRT; }
"<="                { return LSE; }
">="                { return GRE; }
"=="                { return EQUATE; }
"&&"                { return ANDNUM; }
"||"                { return ORNUM; }
"?"                 { return QUESTION; }
":"                 { return COLON; }
";"                 { return LINEEND; }
","                 { return COMMA; }

{IDENTIFIER}        { return IDENTIFIER;}
{INT_CONST}         { return INTEGER_CONSTANT;}
{CHAR_CONST}        { return CHAR_CONSTANT;}
{STR_LIT}           { return STRING_LITERAL;}
"\n"                { printf("\n#################### LINE NO : %d ####################\n", ++lineNum); }
{WHITESPACE}        {;}
%%