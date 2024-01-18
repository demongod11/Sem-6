/*
Assignment 3 - Lexer for tiny C Test File
Group 2
19CS10031 - Abhishek Gandhi
19CS10051 - Sajal Chammunya 
*/

#ifndef _HEADER_H
    #define _HEADER_H 

    #define AUTO			1
    #define ENUM			2
    #define RESTRICT		3
    #define UNSIGNED		4
    #define BREAK			5
    #define EXTERN			6
    #define RETURN			7
    #define VOID			8
    #define CASE			9
    #define FLOAT			10
    #define SHORT			11
    #define VOLATILE		12
    #define CHAR			13
    #define FOR			    14
    #define SIGNED			15
    #define WHILE			16
    #define CONST			17
    #define GOTO			18
    #define SIZEOF			19
    #define _BOOL			20
    #define CONTINUE		21
    #define IF			    22
    #define STATIC			23
    #define _COMPLEX		24
    #define DEFAULT			25
    #define INLINE			26
    #define STRUCT			27
    #define _IMAGINARY		28
    #define DO			    29
    #define INT			    30
    #define SWITCH			31
    #define DOUBLE			32
    #define LONG			33
    #define TYPEDEF			34
    #define ELSE			35
    #define REGISTER		36
    #define UNION			37
    #define TDOT			38
    #define EQUAL			39
    #define MODEQ			40
    #define ADDEQ			41
    #define MULEQ			42
    #define DIVEQ			43
    #define SUBEQ			44
    #define SHLEQ			45
    #define SHREQ			46
    #define SQROPEN			47
    #define SQRCLOSE		48
    #define CIROPEN			49
    #define CIRCLOSE		50
    #define CUROPEN			51
    #define CURCLOSE		52
    #define DOT			    53
    #define ARROW			54
    #define INCRE			55
    #define DECRE			56
    #define AND			    57
    #define MUL			    58
    #define ADD			    59
    #define SUB			    60
    #define NEQ			    61
    #define EXCL			62
    #define DIV			    63
    #define MOD			    64
    #define LESH			65
    #define RISH			66
    #define LST			    67
    #define GRT			    68
    #define LSE			    69
    #define GRE			    70
    #define EQUATE			71
    #define NEQE			72
    #define XOR			    73
    #define OR			    74
    #define ANDNUM			75
    #define ORNUM			76
    #define QUESTION		77
    #define COLON			78
    #define LINEEND			79
    #define ANDE			80
    #define XORE			81
    #define ORE			    82
    #define COMMA			83
    #define HASH			84

    #define COMMENT         100
    #define IDENTIFIER      101
    #define FLT_CONST       102
    #define INT_CONST       103
    #define CHAR_CONST      104
    #define STRING_LITERAL  105

#endif