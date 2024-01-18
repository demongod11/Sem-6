%{
    #include <stdio.h>
    
    extern int yylex();
    void yyerror(const char *);
%}

%token SINGLE_COMMENT
%token MULTI_COMMENT
%token RETURN
%token VOID
%token CHAR
%token FOR
%token IF
%token INT
%token ELSE
%token EQUAL
%token SQROPEN
%token SQRCLOSE
%token CIROPEN
%token CIRCLOSE
%token CUROPEN
%token CURCLOSE
%token ARROW
%token AND
%token MUL
%token ADD
%token SUB
%token EXCL
%token DIV
%token MOD
%token LST
%token GRT
%token LSE
%token GRE
%token EQUATE
%token NEQE
%token OR
%token ANDNUM
%token ORNUM
%token QUESTION
%token COLON
%token LINEEND
%token COMMA
%token IDENTIFIER
%token INTEGER_CONSTANT
%token CHAR_CONSTANT
%token STRING_LITERAL

%start translation_unit

%nonassoc THEN
%nonassoc ELSE

%%

constant: INTEGER_CONSTANT
    { printf("constant <- INTEGER_CONSTANT\n"); }
	| CHAR_CONSTANT
    { printf("constant <- CHAR_CONSTANT\n"); }
	;

primary_expression: IDENTIFIER
    { printf("primary_expression <- INDENTIFIER\n"); }
    | constant
    { printf("primary_expression <- constant\n"); }
    | STRING_LITERAL
    { printf("primary_expression <- STRING_LITERAL\n"); }
    | CIROPEN expression CIRCLOSE
    { printf("primary_expression <- (expression)\n"); }
    ;

postfix_expression: primary_expression
    { printf("postfix_expression <- primary_expression\n"); }
    | postfix_expression SQROPEN expression SQRCLOSE
    { printf("postfix_expression <- postfix_expression[expression]\n"); }
    | postfix_expression CIROPEN argument_expression_list_opt CIRCLOSE
    { printf("postfix_expression <- postfix_expression(argument_expression_list_opt)\n"); }
    | postfix_expression ARROW IDENTIFIER
    { printf("postfix_expression <- postfix-expression <- IDENTIFIER\n"); }
    ;

argument_expression_list: assignment_expression
    { printf("argument_expression_list <- assignment_expression\n"); }
    | argument_expression_list COMMA assignment_expression
    { printf("argument_expression_list <- argument_expression_list,assignment_expression\n"); }
    ;

argument_expression_list_opt: argument_expression_list
    { printf("argument_expression_list_opt <- argument_expression_list"); }
    | %empty
    { printf("argument_expression_list_opt <- epsilon"); }
    ;

unary_expression: postfix_expression
    { printf("unary_expression <- postfix_expression\n"); }
    | unary_operator unary_expression
    { printf("unary_expression <- unary_operator unary_expression\n"); }
    ;

unary_operator: AND
    { printf("unary_operator <- &\n"); }
    | MUL
    { printf("unary_operator <- *\n"); }
    | ADD
    { printf("unary_operator <- +\n"); }
    | SUB
    { printf("unary_operator <- -\n"); }
    | EXCL
    { printf("unary_operator <- !\n"); }
    ;

multiplicative_expression: unary_expression
    { printf("multiplicative_expression <- unary_expression\n"); }
    | multiplicative_expression MUL unary_expression
    { printf("multiplicative_expression <- multiplicative_expression * unary_expression\n"); }
    | multiplicative_expression DIV unary_expression
    { printf("multiplicative_expression <- multiplicative_expression / unary_expression\n"); }
    | multiplicative_expression MOD unary_expression
    { printf("multiplicative_expression <- multiplicative_expression %% unary_expression\n"); }
    ;

additive_expression: multiplicative_expression
    { printf("additive_expression <- multiplicative_expression\n"); }
    | additive_expression ADD multiplicative_expression
    { printf("additive_expression <- additive_expression + multiplicative_expression\n"); }
    | additive_expression SUB multiplicative_expression
    { printf("additive_expression <- additive_expression - multiplicative_expression\n"); }
    ;

relational_expression: additive_expression
    { printf("relational_expression <- additive_expression\n"); }
    | relational_expression LST additive_expression
    { printf("relational_expression <- relational_expression < additve_expression\n"); }
    | relational_expression GRT additive_expression
    { printf("relational_expression <- relational_expression > additive_expression\n"); }
    | relational_expression LSE additive_expression
    { printf("relational_expression <- relational_expression <= additive_expression\n"); }
    | relational_expression GRE additive_expression
    { printf("relational_expression <- relational_expression >= additive_expression\n"); }
    ;

equality_expression: relational_expression
    { printf("equality_expression <- relational_expression\n"); }
    | equality_expression EQUATE relational_expression
    { printf("equality_expression <- equality_expression == relational_expression\n"); }
    | equality_expression NEQE relational_expression
    { printf("equality_expression <- equality_expression != relational_expression\n"); }
    ;

logical_and_expression: equality_expression
    { printf("logical_and_expression <- equality_expression\n"); }
    | logical_and_expression ANDNUM equality_expression
    { printf("logical_and_expression <- logical_and_expression && equality_expression\n"); }
    ;

logical_or_expression: logical_and_expression
    { printf("logical_or_expression <- logical_and_expression\n"); }
    | logical_or_expression ORNUM logical_and_expression
    { printf("logical_or_expression <- logical_or_expression || logical_and_expression\n"); }
    ;

conditional_expression: logical_or_expression
    { printf("conditional_expression <- logical_or_expression\n"); }
    | logical_or_expression QUESTION expression COLON conditional_expression
    { printf("conditional_expression <- logical_or_expression ? expression : conditional_expression\n"); }
    ;

assignment_expression: conditional_expression
    { printf("assignment_expression <- conditional_expression\n"); }
    | unary_expression EQUAL assignment_expression
    { printf("assignment_expression <- unary_expression = assignment_expression\n"); }
    ;

expression: assignment_expression
    { printf("expression <- assignment_expression\n"); }
    ;

declaration: type_specifier init_declarator LINEEND
    { printf("declaration <- type_specifier init_declarator ;\n"); }
    ;

init_declarator: declarator
    { printf("init_declarator <- declarator\n"); }
    | declarator EQUAL initializer
    { printf("init_declarator <- declarator = initializer\n"); }
    ;

type_specifier: VOID
    { printf("type_specifier <- VOID\n"); }
    | CHAR
    { printf("type_specifier <- CHAR\n"); }
    | INT
    { printf("type_specifier <- INT\n"); }
    ;

declarator: pointer_opt direct_declarator
    { printf("declarator <- pointer_opt direct_declarator\n"); }
    ;

direct_declarator: IDENTIFIER
    { printf("direct_declarator <- IDENTIFIER\n"); }
    | IDENTIFIER SQROPEN INTEGER_CONSTANT SQRCLOSE
    { printf("direct_declarator <- IDENTIFIER [ integer-constant ]\n");}
    | IDENTIFIER CIROPEN parameter_list_opt CIRCLOSE
    { printf("direct_declarator <- IDENTIFIER ( parameter_list_opt )\n");}
    ;

pointer: MUL
    { printf("pointer <- * \n"); }
    ;

parameter_list_opt: parameter_list
    { printf("parameter_list_opt <- parameter_list\n");}
    | %empty
    { printf("parameter_list_opt <- epsilon\n"); }
    ;

parameter_list: parameter_declaration
    { printf("parameter_list <- parameter_declaration\n"); }
    | parameter_list COMMA parameter_declaration
    { printf("parameter_list <- parameter_list , parameter_declaration\n"); }
    ;

parameter_declaration: 
    type_specifier pointer_opt identifier_opt
    { printf("parameter_declaration <- type_specifier pointer_opt identifier_opt\n"); }

pointer_opt: pointer
    { printf("pointer_opt <- pointer\n");}
    | %empty
    { printf("pointer_opt <- epsilon\n"); }
    ;

identifier_opt: IDENTIFIER
    { printf("identifier_opt <- IDENTIFIER\n");}
    | %empty
    { printf("identifier_opt <- epsilon\n"); }
    ;

initializer: assignment_expression
    { printf("initializer <- assignment_expression\n"); }
    ;

statement: compound_statement
    { printf("statement <- compound_statement\n"); }
    | expression_statement
    { printf("statement <- expression_statement\n"); }
    | selection_statement
    { printf("statement <- selection_statement\n"); }
    | iteration_statement
    { printf("statement <- iteration_statement\n"); }
    | jump_statement
    { printf("statement <- jump_statement\n"); }
    ;

compound_statement: CUROPEN block_item_list_opt CURCLOSE
    { printf("compound_statement <- { block_item_list_opt }\n"); }
    ;

block_item_list_opt: block_item_list
    { printf("block_item_list_opt <- block_item_list\n"); }
    | %empty
    { printf("block_item_list_opt <- epsilon\n"); }
    ;

block_item_list: block_item
    { printf("block_item_list <- block_item\n"); }
    | block_item_list block_item
    { printf("block_item_list <- block_item_list block_item\n"); }
    ;

block_item: declaration
    { printf("block_item <- declaration\n"); }
    | statement
    { printf("block_item <- statement\n"); }
    ;

expression_statement: expression_opt LINEEND
    { printf("expression_statement <- expression_opt;\n"); }
    ;

expression_opt: expression
    { printf("expression_opt <- expression\n"); }
    | %empty
    { printf("expression_opt <- epsilon\n"); }
    ;

selection_statement: IF CIROPEN expression CIRCLOSE statement
    { printf("selection_statement <- IF ( expression ) statement\n"); }
    | IF CIROPEN expression CIRCLOSE statement ELSE statement
    { printf("selection_statement <- IF ( expression ) statement ELSE statement\n"); }
    ;

iteration_statement:
    FOR CIROPEN expression_opt LINEEND expression_opt LINEEND expression_opt CIRCLOSE statement
    { printf("iteration_statement <- FOR ( expression_opt ; expression_opt ; expression_opt ) statement\n"); }
    ;

jump_statement:
    | RETURN expression_opt LINEEND
    { printf("jump_statement <- RETURN expression_opt ;\n"); }
    ;

translation_unit: external_declaration
    { printf("translation_unit <- external_declaration\n"); }
    | translation_unit external_declaration
    { printf("translation_unit <- translation_unit external_declaration\n"); }
    ;

external_declaration: function_definition
    { printf("external_declaration <- function_definition\n"); }
    | declaration
    { printf("external_declaration <- declaration\n"); }
    ;

function_definition: type_specifier declarator declaration_list_opt compound_statement
    { printf("function_definition <- type_specifier declarator declaration_list_opt compound_statement\n"); }
    ;

declaration_list_opt: declaration_list
    { printf("declaration_list_opt <- declaration_list\n"); }
    | %empty
    { printf("declaration_list_opt <- epsilon\n"); }
    ;

declaration_list: declaration
    { printf("declaration_list <- declaration\n"); }
    | declaration_list declaration
    { printf("declaration_list <- declaration_list declaration\n"); }
    ;

%%

void yyerror(const char *s) {
    printf("ERROR: %s", s);
}