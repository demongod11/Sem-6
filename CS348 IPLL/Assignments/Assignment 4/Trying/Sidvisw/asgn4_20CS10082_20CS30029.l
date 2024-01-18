/* DECLARATIONS */
%{
    #include "y.tab.h" // Bison generated header file of token symbols and attributes
%}

/* Enable line number tracking for error printing */
%option yylineno        

/* Defining Start Condtion States */
%x MULTI_LINE_COMMENT
%x SINGLE_LINE_COMMENT

/* Regular Expression Definitions */

IDENTIFIER_NONDIGIT             [a-zA-Z_]
DIGIT                           [0-9]
IDENTIFIER	                    {IDENTIFIER_NONDIGIT}({IDENTIFIER_NONDIGIT}|{DIGIT})*
NONZERO_DIGIT                   [1-9]
INTEGER_CONSTANT	            {NONZERO_DIGIT}{DIGIT}*|0

DIGIT_SEQUENCE	                {DIGIT}+
FRACTIONAL_CONSTANT	            ({DIGIT_SEQUENCE}?\.{DIGIT_SEQUENCE})|({DIGIT_SEQUENCE}\.)
SIGN	                        [+-]
EXPONENT_PART	                [eE]{SIGN}?{DIGIT_SEQUENCE}
FLOATING_CONSTANT	            ({FRACTIONAL_CONSTANT}{EXPONENT_PART}?)|({DIGIT_SEQUENCE}{EXPONENT_PART})

ENUMERATION_CONSTANT	        {IDENTIFIER}

ESCAPE_SEQUENCE	                \\[\'\"?\\abfnrtv]

C_CHAR	                        [^\'\\\n]|{ESCAPE_SEQUENCE}
C_CHAR_SEQUENCE	                {C_CHAR}+

CHARACTER_CONSTANT	            \'{C_CHAR_SEQUENCE}\'

CONSTANT	                    {INTEGER_CONSTANT}|{FLOATING_CONSTANT}|{ENUMERATION_CONSTANT}|{CHARACTER_CONSTANT}

S_CHAR	                        [^\"\\\n]|{ESCAPE_SEQUENCE}
S_CHAR_SEQUENCE	                {S_CHAR}+

STRING_LITERAL	                \"{S_CHAR_SEQUENCE}?\"


WHITESPACE	                    [ \t\n]

/* Defining the return values according to the token scanned */
%%

"auto"                          {return AUTO;}
"break"                         {return BREAK;}
"case"                          {return CASE;}
"char"                          {return CHAR;}
"const"                         {return CONST;}
"continue"                      {return CONTINUE;}
"default"                       {return DEFAULT;}
"do"                            {return DO;}
"double"                        {return DOUBLE;}
"else"                          {return ELSE;}
"enum"                          {return ENUM;}
"extern"                        {return EXTERN;}
"float"                         {return FLOAT;}
"for"                           {return FOR;}
"goto"                          {return GOTO;}
"if"                            {return IF;}
"inline"                        {return INLINE;}
"int"                           {return INT;}
"long"                          {return LONG;}
"register"                      {return REGISTER;}
"restrict"                      {return RESTRICT;}
"return"                        {return RETURN;}
"short"                         {return SHORT;}
"signed"                        {return SIGNED;}
"sizeof"                        {return SIZEOF;}
"static"                        {return STATIC;}
"struct"                        {return STRUCT;}
"switch"                        {return SWITCH;}
"typedef"                       {return TYPEDEF;}
"union"                         {return UNION;}
"unsigned"                      {return UNSIGNED;}
"void"                          {return VOID;}
"volatile"                      {return VOLATILE;}
"while"                         {return WHILE;}
"_Bool"                         {return _BOOL;}
"_Complex"                      {return _COMPLEX;}
"_Imaginary"                    {return _IMAGINARY;}

{IDENTIFIER}	                {return IDENTIFIER;}

"["                             {return SQUARE_BRACKET_OPEN;}
"]"                             {return SQUARE_BRACKET_CLOSE;}
"("                             {return ROUND_BRACKET_OPEN;}
")"                             {return ROUND_BRACKET_CLOSE;}
"{"                             {return CURLY_BRACKET_OPEN;}
"}"                             {return CURLY_BRACKET_CLOSE;}
"."                             {return DOT;}
"->"                            {return ARROW;}
"++"                            {return INCREMENT;}
"--"                            {return DECREMENT;}
"&"                             {return BITWISE_AND;}
"*"                             {return MULTIPLY;}
"+"                             {return ADD;}
"-"                             {return SUBTRACT;}
"~"                             {return BITWISE_NOT;}
"!"                             {return LOGICAL_NOT;}
"/"                             {return DIVIDE;}
"%"                             {return MODULUS;}
"<<"                            {return LEFT_SHIFT;}
">>"                            {return RIGHT_SHIFT;}
"<"                             {return LESS_THAN;}
">"                             {return GREATER_THAN;}
"<="                            {return LESS_THAN_OR_EQUAL_TO;}
">="                            {return GREATER_THAN_OR_EQUAL_TO;}
"=="                            {return EQUAL_TO;}
"!="                            {return NOT_EQUAL_TO;}
"^"                             {return BITWISE_XOR;}
"|"                             {return BITWISE_OR;}
"&&"                            {return LOGICAL_AND;}
"||"                            {return LOGICAL_OR;}
"?"                             {return QUESTION_MARK;}
":"                             {return COLON;}
";"                             {return SEMICOLON;}
"..."                           {return ELLIPSIS;}
"="                             {return ASSIGNMENT;}
"*="                            {return MULTIPLY_ASSIGNMENT;}
"/="                            {return DIVIDE_ASSIGNMENT;}
"%="                            {return MODULUS_ASSIGNMENT;}
"+="                            {return ADD_ASSIGNMENT;}
"-="                            {return SUBTRACT_ASSIGNMENT;}
"<<="                           {return LEFT_SHIFT_ASSIGNMENT;}
">>="                           {return RIGHT_SHIFT_ASSIGNMENT;}
"&="                            {return BITWISE_AND_ASSIGNMENT;}
"^="                            {return BITWISE_XOR_ASSIGNMENT;}
"|="                            {return BITWISE_OR_ASSIGNMENT;}
","                             {return COMMA;}
"#"                             {return HASH;}

{CONSTANT}                      {return CONSTANT;}

{STRING_LITERAL}	            {return STRING_LITERAL;}

{WHITESPACE}	                /*White-space Rule*/;

"/*"	                        {BEGIN(MULTI_LINE_COMMENT);}
<MULTI_LINE_COMMENT>.|\n	    /*Do nothing*/;
<MULTI_LINE_COMMENT>"*/"	    {BEGIN(INITIAL);}

"//"	                        {BEGIN(SINGLE_LINE_COMMENT);}
<SINGLE_LINE_COMMENT>.	        /*Do nothing*/;
<SINGLE_LINE_COMMENT>\n	        {BEGIN(INITIAL);}
%%