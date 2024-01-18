%{ 
#define KEYWORD         1
#define ID              2
#define INT_CONST       3
#define CHAR_CONST      4
#define STRING          5
#define PUNC            6
#define SIN_COMMENT     7
#define MULT_COMMENT    8
%} 

/*------- KEYWORDS ---------------*/
KEYWORD     "char"|"else"|"for"|"if"|"int"|"return"|"void"

/*--------IDENTIFIER----------------*/
ID 			[a-zA-Z_][a-zA-Z0-9_]*

/*--------INTEGER CONSTANT-----------*/
INT_CONST   ([+-]?)[0-9]+

/*-------CHARACTER CONSTANT----------*/
CHAR_CONST	'{CHAR_SEQ}'
CHAR_SEQ	{C_CHAR}+
C_CHAR		{SRC_SET}|{ESC_SEQ}
SRC_SET		[^\\\'\\n]

/*-------STRING CONSTANT-------------*/
ESC_SEQ 	\\a|\\b|\\f|\\n|\\t|\\r|\\v|\\\'|\\\"|\\\\|\\\?

S_CHAR_SEQUENCE	     {S_CHAR}+
S_CHAR  		     {ESC_SEQ}|[^\\\'\\n]
STRING 	     "\""{S_CHAR_SEQUENCE}?"\""

/*---------PUNCTUATIONS--------------*/
PUNC               "["|"]"|"("|")"|"{"|"}"|"->"|"&"|"*"|"+"|"-"|"/"|"%"|"!"|"?"|"<"|">"|"<="|">="|"=="|"!="|"&&"|"||"|"="|":"|";"|","

/*---------WHITESPACE , TAB , NEW LINE CHARACTER-----------*/
WS			[ \t\n]

/*--------SINGLE COMMENT LINE---------*/
SIN_COMMENT	[/][/].*
 
/*--------MULTI COMMENT LINE----------*/
MULT_COMMENT [/][*]{STR2}*[*][/]
STR2		[^*]|{STR3}
STR3 		[*][^*/]

%% 
{KEYWORD}       return KEYWORD;
{ID}		    return ID;
{INT_CONST}	    return INT_CONST;
{CHAR_CONST}    return CHAR_CONST;
{STRING}	    return STRING;
{PUNC}		    return PUNC;
{SIN_COMMENT}   return SIN_COMMENT;
{MULT_COMMENT}  return MULT_COMMENT;
{WS}	
%%