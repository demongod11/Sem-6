/*
Assignment 3 - Lexer for tiny C Test File
Group 2
19CS10031 - Abhishek Gandhi
19CS10051 - Sajal Chammunya 
*/

#include <stdio.h>
#include "lex.yy.c"
#include "header.h"
extern char* yytext;


int main(){
  int token;
  while((token=yylex())){

    switch(token) {
        case COMMENT:    printf("< COMMENT: %d, %s>\n",token,yytext); break;

        //KeyWords
        case AUTO: printf("< KEYWORD: AUTO, %d, %s >\n",token,yytext); break;
        case ENUM: printf("< KEYWORD: ENUM, %d, %s >\n",token,yytext); break;
        case RESTRICT: printf("< KEYWORD: RESTRICT, %d, %s >\n",token,yytext); break;
        case UNSIGNED: printf("< KEYWORD: UNSIGNED, %d, %s >\n",token,yytext); break;
        case BREAK: printf("< KEYWORD: BREAK, %d, %s >\n",token,yytext); break;
        case EXTERN: printf("< KEYWORD: EXTERN, %d, %s >\n",token,yytext); break;
        case RETURN: printf("< KEYWORD: RETURN, %d, %s >\n",token,yytext); break;
        case VOID: printf("< KEYWORD: VOID, %d, %s >\n",token,yytext); break;
        case CASE: printf("< KEYWORD: CASE, %d, %s >\n",token,yytext); break;
        case FLOAT: printf("< KEYWORD: FLOAT, %d, %s >\n",token,yytext); break;
        case SHORT: printf("< KEYWORD: SHORT, %d, %s >\n",token,yytext); break;
        case VOLATILE: printf("< KEYWORD: VOLATILE, %d, %s >\n",token,yytext); break;
        case CHAR: printf("< KEYWORD: CHAR, %d, %s >\n",token,yytext); break;
        case FOR: printf("< KEYWORD: FOR, %d, %s >\n",token,yytext); break;
        case SIGNED: printf("< KEYWORD: SIGNED, %d, %s >\n",token,yytext); break;
        case WHILE: printf("< KEYWORD: WHILE, %d, %s >\n",token,yytext); break;
        case CONST: printf("< KEYWORD: CONST, %d, %s >\n",token,yytext); break;
        case GOTO: printf("< KEYWORD: GOTO, %d, %s >\n",token,yytext); break;
        case SIZEOF: printf("< KEYWORD: SIZEOF, %d, %s >\n",token,yytext); break;
        case _BOOL: printf("< KEYWORD: _BOOL, %d, %s >\n",token,yytext); break;
        case CONTINUE: printf("< KEYWORD: CONTINUE, %d, %s >\n",token,yytext); break;
        case IF: printf("< KEYWORD: IF, %d, %s >\n",token,yytext); break;
        case STATIC: printf("< KEYWORD: STATIC, %d, %s >\n",token,yytext); break;
        case _COMPLEX: printf("< KEYWORD: _COMPLEX, %d, %s >\n",token,yytext); break;
        case DEFAULT: printf("< KEYWORD: DEFAULT, %d, %s >\n",token,yytext); break;
        case INLINE: printf("< KEYWORD: INLINE, %d, %s >\n",token,yytext); break;
        case STRUCT: printf("< KEYWORD: STRUCT, %d, %s >\n",token,yytext); break;
        case _IMAGINARY: printf("< KEYWORD: _IMAGINARY, %d, %s >\n",token,yytext); break;
        case DO: printf("< KEYWORD: DO, %d, %s >\n",token,yytext); break;
        case INT: printf("< KEYWORD: INT, %d, %s >\n",token,yytext); break;
        case SWITCH: printf("< KEYWORD: SWITCH, %d, %s >\n",token,yytext); break;
        case DOUBLE: printf("< KEYWORD: DOUBLE, %d, %s >\n",token,yytext); break;
        case LONG: printf("< KEYWORD: LONG, %d, %s >\n",token,yytext); break;
        case TYPEDEF: printf("< KEYWORD: TYPEDEF, %d, %s >\n",token,yytext); break;
        case ELSE: printf("< KEYWORD: ELSE, %d, %s >\n",token,yytext); break;
        case REGISTER: printf("< KEYWORD: REGISTER, %d, %s >\n",token,yytext); break;
        case UNION: printf("< KEYWORD: UNION, %d, %s >\n",token,yytext); break;

        // identifiers
        case IDENTIFIER:     printf("< IDENTIFIER: %d, %s>\n",token,yytext); break;
        // case FLT_CONST:       printf("< CONSTANT: %d, %s>\n",token,yytext); break;
        case FLT_CONST:    printf("< CONSTANT: FLOAT, %d, %s>\n",token,yytext); break;
        case INT_CONST:    printf("< CONSTANT: INTEGER, %d, %s>\n",token,yytext); break;
        case CHAR_CONST:    printf("< CONSTANT: CHARACTER, %d, %s>\n",token,yytext); break;
        // case STRING_LITERAL:    printf("< STRING, %d, %s>\n",token,yytext); break;
        case STRING_LITERAL:    printf("< STRING_LITERAL: %d, %s>\n",token,yytext); break;

        //punctuators
        case TDOT: printf("< PUNCTUATOR: TRIPLE DOT, %d, %s >\n",token,yytext); break;
        case EQUAL: printf("< PUNCTUATOR: EQUAL, %d, %s >\n",token,yytext); break;
        case MODEQ: printf("< PUNCTUATOR: MOD EQUAL, %d, %s >\n",token,yytext); break;
        case ADDEQ: printf("< PUNCTUATOR: ADD EQUAL, %d, %s >\n",token,yytext); break;
        case MULEQ: printf("< PUNCTUATOR: MULTIPLY EQUAL, %d, %s >\n",token,yytext); break;
        case DIVEQ: printf("< PUNCTUATOR: DIVIDE EQUAL, %d, %s >\n",token,yytext); break;
        case SUBEQ: printf("< PUNCTUATOR: SUBTRACT EQUAL, %d, %s >\n",token,yytext); break;
        case SHLEQ: printf("< PUNCTUATOR: SHIFT LEFT EQUAL, %d, %s >\n",token,yytext); break;
        case SHREQ: printf("< PUNCTUATOR: SHIFT RIGHT EQUAL, %d, %s >\n",token,yytext); break;
        case SQROPEN: printf("< PUNCTUATOR: SQUARE OPEN BRACKET, %d, %s >\n",token,yytext); break;
        case SQRCLOSE: printf("< PUNCTUATOR: SQUARE CLOSE BRACKET, %d, %s >\n",token,yytext); break;
        case CIROPEN: printf("< PUNCTUATOR: CIRCULAR OPEN BRACKET, %d, %s >\n",token,yytext); break;
        case CIRCLOSE: printf("< PUNCTUATOR: CIRCULAR CLOSE BRACKET, %d, %s >\n",token,yytext); break;
        case CUROPEN: printf("< PUNCTUATOR: CURLY OPEN BRACKET, %d, %s >\n",token,yytext); break;
        case CURCLOSE: printf("< PUNCTUATOR: CURLY CLOSE BRACKET, %d, %s >\n",token,yytext); break;
        case DOT: printf("< PUNCTUATOR: DOT, %d, %s >\n",token,yytext); break;
        case ARROW: printf("< PUNCTUATOR: ARROW, %d, %s >\n",token,yytext); break;
        case INCRE: printf("< PUNCTUATOR: INCREMENT, %d, %s >\n",token,yytext); break;
        case DECRE: printf("< PUNCTUATOR: DECREMENT, %d, %s >\n",token,yytext); break;
        case AND: printf("< PUNCTUATOR: AND, %d, %s >\n",token,yytext); break;
        case MUL: printf("< PUNCTUATOR: MULTIPLY, %d, %s >\n",token,yytext); break;
        case ADD: printf("< PUNCTUATOR: ADD, %d, %s >\n",token,yytext); break;
        case SUB: printf("< PUNCTUATOR: SUBTRACT, %d, %s >\n",token,yytext); break;
        case NEQ: printf("< PUNCTUATOR: NOT EQUAL, %d, %s >\n",token,yytext); break;
        case EXCL: printf("< PUNCTUATOR: EXCLAMATION, %d, %s >\n",token,yytext); break;
        case DIV: printf("< PUNCTUATOR: DIVISION, %d, %s >\n",token,yytext); break;
        case MOD: printf("< PUNCTUATOR: MOD, %d, %s >\n",token,yytext); break;
        case LESH: printf("< PUNCTUATOR: LEFT SHIFT, %d, %s >\n",token,yytext); break;
        case RISH: printf("< PUNCTUATOR: RIGHT SHIFT, %d, %s >\n",token,yytext); break;
        case LST: printf("< PUNCTUATOR: LESS THAN, %d, %s >\n",token,yytext); break;
        case GRT: printf("< PUNCTUATOR: GREATER THAN, %d, %s >\n",token,yytext); break;
        case LSE: printf("< PUNCTUATOR: LESS THAN EQUAL, %d, %s >\n",token,yytext); break;
        case GRE: printf("< PUNCTUATOR: GREATER THAN EQUAL, %d, %s >\n",token,yytext); break;
        case EQUATE: printf("< PUNCTUATOR: EQUATE, %d, %s >\n",token,yytext); break;
        case NEQE: printf("< PUNCTUATOR: NOT EQUAL, %d, %s >\n",token,yytext); break;
        case XOR: printf("< PUNCTUATOR: XOR, %d, %s >\n",token,yytext); break;
        case OR: printf("< PUNCTUATOR: OR, %d, %s >\n",token,yytext); break;
        case ANDNUM: printf("< PUNCTUATOR: DOUBLE AND, %d, %s >\n",token,yytext); break;
        case ORNUM: printf("< PUNCTUATOR: DOUBLE OR, %d, %s >\n",token,yytext); break;
        case QUESTION: printf("< PUNCTUATOR: QUESTION, %d, %s >\n",token,yytext); break;
        case COLON: printf("< PUNCTUATOR: COLON, %d, %s >\n",token,yytext); break;
        case LINEEND: printf("< PUNCTUATOR: LINEEND, %d, %s >\n",token,yytext); break;
        case ANDE: printf("< PUNCTUATOR: AND EQUAL, %d, %s >\n",token,yytext); break;
        case XORE: printf("< PUNCTUATOR: XOR EQUAL, %d, %s >\n",token,yytext); break;
        case ORE: printf("< PUNCTUATOR: OR EQUAL, %d, %s >\n",token,yytext); break;
        case COMMA: printf("< PUNCTUATOR: COMMA, %d, %s >\n",token,yytext); break;
        case HASH: printf("< PUNCTUATOR: HASH, %d, %s >\n",token,yytext); break;

        default: printf("Have to allot this keyword: %d, %s\n",token,yytext);break;
    }
  }
    return 0;
}