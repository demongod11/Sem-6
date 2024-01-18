%{/*C Declarations and Definitions */
    #include <stdio.h>
    
    extern int yylex();
    void yyerror(const char *);
    
%}

%union {
    int inval;
    float floatval;
    char charval;
    char *stringval;
}

%token <floatval> FLOAT_CONSTANT
%token <charval> CHAR_CONSTANT
%token <stringval> STRING_LITERAL
%token <intval> INTEGER_CONSTANT

%token COMMENT
%token AUTO
%token ENUM
%token RESTRICT
%token UNSIGNED
%token BREAK
%token EXTERN
%token RETURN
%token VOID
%token CASE
%token FLOAT
%token SHORT
%token VOLATILE
%token CHAR
%token FOR
%token SIGNED
%token WHILE
%token CONST
%token GOTO
%token SIZEOF
%token _BOOL
%token CONTINUE
%token IF
%token STATIC
%token _COMPLEX
%token DEFAULT
%token INLINE
%token STRUCT
%token _IMAGINARY
%token DO
%token INT
%token SWITCH
%token DOUBLE
%token LONG
%token TYPEDEF
%token ELSE
%token REGISTER
%token UNION
%token TDOT
%token EQUAL
%token MODEQ
%token ADDEQ
%token MULEQ
%token DIVEQ
%token SUBEQ
%token SHLEQ
%token SHREQ
%token SQROPEN
%token SQRCLOSE
%token CIROPEN
%token CIRCLOSE
%token CUROPEN
%token CURCLOSE
%token DOT
%token ARROW
%token INCRE
%token DECRE
%token AND
%token MUL
%token ADD
%token SUB
%token NEQ
%token EXCL
%token DIV
%token MOD
%token LESH
%token RISH
%token LST
%token GRT
%token LSE
%token GRE
%token EQUATE
%token NEQE
%token XOR
%token OR
%token ANDNUM
%token ORNUM
%token QUESTION
%token COLON
%token LINEEND
%token ANDE
%token XORE
%token ORE
%token COMMA
%token HASH
%token IDENTIFIER

%start translation_unit

%nonassoc THEN
%nonassoc ELSE

%%

constant: INTEGER_CONSTANT
    { printf("constant <- INTEGER_CONSTANT\n"); }
	| FLOAT_CONSTANT
    { printf("constant <- FLOAT_CONSTANT\n"); }
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
    | postfix_expression DOT IDENTIFIER
    { printf("postfix_expression <- postfix-expression . IDENTIFIER\n"); }
    | postfix_expression ARROW IDENTIFIER
    { printf("postfix_expression <- postfix-expression <- IDENTIFIER\n"); }
    | postfix_expression INCRE
    { printf("postfix_expression <- postfix-expression ++\n"); }
    | postfix_expression DECRE
    { printf("postfix_expression <- postfix-expression --\n"); }
    | CIROPEN type_name CIRCLOSE CUROPEN initializer_list CURCLOSE
    { printf("postfix_expression <- (type_name){initializer_list}\n"); }
    | CIROPEN type_name CIRCLOSE CUROPEN initializer_list COMMA CURCLOSE
    { printf("postfix_expression <- (type_name){initializer_list,}\n"); }
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
    | INCRE unary_expression
    { printf("unary_expression <- INCRE unary_expression\n"); }
    | DECRE unary_expression
    { printf("unary_expression <- DECRE unary_expression\n"); }
    | unary_operator cast_expression
    { printf("unary_expression <- unary_operator cast_expression\n"); }
    | SIZEOF unary_expression
    { printf("unary_expression <- SIZEOF unary_expression\n"); }
    | SIZEOF CIROPEN type_name CIRCLOSE
    { printf("unary_expression <- SIZEOF (type_name)\n"); }
    ;

unary_operator: AND
    { printf("unary_operator <- &\n"); }
    | MUL
    { printf("unary_operator <- *\n"); }
    | ADD
    { printf("unary_operator <- +\n"); }
    | SUB
    { printf("unary_operator <- -\n"); }
    | NEQ
    { printf("unary_operator <- ~\n"); }
    | EXCL
    { printf("unary_operator <- !\n"); }
    ;

cast_expression: unary_expression
    { printf("cast_expression <- unary_expression\n"); }
    | CIROPEN type_name CIRCLOSE cast_expression
    { printf("cast_expression <- (type_name)cast_expression\n"); }
    ;

multiplicative_expression: cast_expression
    { printf("multiplicative_expression <- cast_expression\n"); }
    | multiplicative_expression MUL cast_expression
    { printf("multiplicative_expression <- multiplicative_expression * cast_expression\n"); }
    | multiplicative_expression DIV cast_expression
    { printf("multiplicative_expression <- multiplicative_expression / cast_expression\n"); }
    | multiplicative_expression MOD cast_expression
    { printf("multiplicative_expression <- multiplicative_expression %% cast_expression\n"); }
    ;

additive_expression: multiplicative_expression
    { printf("additive_expression <- multiplicative_expression\n"); }
    | additive_expression ADD multiplicative_expression
    { printf("additive_expression <- additive_expression + multiplicative_expression\n"); }
    | additive_expression SUB multiplicative_expression
    { printf("additive_expression <- additive_expression - multiplicative_expression\n"); }
    ;

shift_expression: additive_expression
    { printf("shift_expression <- additive_expression\n"); }
    | shift_expression LESH additive_expression
    { printf("shift_expression <- shift_expression << additive_expression\n"); }
    | shift_expression RISH additive_expression
    { printf("shift_expression <- shift_expression >> additive_expression\n"); }
    ;

relational_expression: shift_expression
    { printf("relational_expression <- shift_expression\n"); }
    | relational_expression LST shift_expression
    { printf("relational_expression <- relational_expression < shift_expression\n"); }
    | relational_expression GRT shift_expression
    { printf("relational_expression <- relational_expression > shift_expression\n"); }
    | relational_expression LSE shift_expression
    { printf("relational_expression <- relational_expression <= shift_expression\n"); }
    | relational_expression GRE shift_expression
    { printf("relational_expression <- relational_expression >= shift_expression\n"); }
    ;

equality_expression: relational_expression
    { printf("equality_expression <- relational_expression\n"); }
    | equality_expression EQUATE relational_expression
    { printf("equality_expression <- equality_expression == relational_expression\n"); }
    | equality_expression NEQE relational_expression
    { printf("equality_expression <- equality_expression != relational_expression\n"); }
    ;

and_expression: equality_expression
    { printf("and_expression <- equality_expression\n"); }
    | and_expression AND equality_expression
    { printf("and_expression <- and_expression & equality_expression\n"); }
    ;

exclusive_or_expression: and_expression
    { printf("exclusive_or_expression <- and_expression\n"); }
    | exclusive_or_expression XOR and_expression
    { printf("exclusive_or_expression <- exclusive_or_expression ^ and_expression\n"); }
    ;

inclusive_or_expression: exclusive_or_expression
    { printf("inclusive_or_expression <- exclusive_or_expression\n"); }
    | inclusive_or_expression OR exclusive_or_expression
    { printf("inclusive_or_expression <- inclusive_or_expression | exclusive_or_expression\n"); }
    ;

logical_and_expression: inclusive_or_expression
    { printf("logical_and_expression <- inclusive_or_expression\n"); }
    | logical_and_expression ANDNUM inclusive_or_expression
    { printf("logical_and_expression <- logical_and_expression && inclusive_or_expression\n"); }
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
    | unary_expression assignment_operator assignment_expression
    { printf("assignment_expression <- unary_expression assignment_operator assignment_expression\n"); }
    ;

assignment_operator: EQUAL
    { printf("assignment_operator <- =\n"); }
    | MULEQ
    { printf("assignment_operator <- *=\n"); }
    | DIVEQ
    { printf("assignment_operator <- /=\n"); }
    | MODEQ
    { printf("assignment_operator <- %%=\n"); }
    | ADDEQ
    { printf("assignment_operator <- +=\n"); }
    | SUBEQ
    { printf("assignment_operator <- -=\n"); }
    | SHLEQ
    { printf("assignment_operator <- <<=\n"); }
    | SHREQ
    { printf("assignment_operator <- >>=\n"); }
    | ANDE
    { printf("assignment_operator <- &&=\n"); }
    | XORE
    { printf("assignment_operator <- ^=\n"); }
    | ORE
    { printf("assignment_operator <- |=\n"); }
    ;

expression: assignment_expression
    { printf("expression <- assignment_expression\n"); }
    | expression COMMA assignment_expression
    { printf("expression <- expression , assignment_expression\n"); }
    ;

constant_expression: conditional_expression
    { printf("constant_expression <- conditional_expression\n"); }
    ;

declaration: declaration_specifiers init_declarator_list_opt LINEEND
    { printf("declaration <- declaration_specifiers init_declarator_list_opt ;\n"); }
    ;

init_declarator_list_opt: init_declarator_list
    { printf("init_declarator_list_opt <- init_declarator_list\n"); }
    | %empty
    { printf("init_declarator_list_opt <- epsilon\n"); }
    ;

declaration_specifiers: storage_class_specifier declaration_specifiers_opt
    { printf("declaration_specifiers <- storage_class_specifier declaration_specifiers_opt\n"); }
    | type_specifier declaration_specifiers_opt
    { printf("declaration_specifiers <- type_specifier declaration_specifiers_opt\n"); }
    | type_qualifier declaration_specifiers_opt
    { printf("declaration_specifiers <- type_qualifier declaration_specifiers_opt\n"); }
    | function_specifier declaration_specifiers_opt
    { printf("declaration_specifiers <- function_specifier declaration_specifiers_opt\n"); }
    ;

declaration_specifiers_opt: declaration_specifiers
    { printf("declaration_specifiers_opt <- declaration_specifiers\n"); }
    | %empty
    { printf("declaration_specifiers_opt <- epsilon\n"); }
    ;

init_declarator_list: init_declarator
    { printf("init_declarator_list <- init_declarator\n"); }
    | init_declarator_list COMMA init_declarator
    { printf("init_declarator_list <- init_declarator_list , init_declarator\n"); }
    ;

init_declarator: declarator
    { printf("init_declarator <- declarator\n"); }
    | declarator EQUAL initializer
    { printf("init_declarator <- declarator = initializer\n"); }
    ;

storage_class_specifier: EXTERN
    { printf("storage_class_specifier <- extern\n"); }
    | STATIC
    { printf("storage_class_specifier <- static\n"); }
    | AUTO
    { printf("storage_class_specifier <- auto\n"); }
    | REGISTER
    { printf("storage_class_specifier <- register\n"); }
    ;

type_specifier: VOID
    { printf("type_specifier <- VOID\n"); }
    | CHAR
    { printf("type_specifier <- CHAR\n"); }
    | SHORT
    { printf("type_specifier <- SHORT\n"); }
    | INT
    { printf("type_specifier <- INT\n"); }
    | LONG
    { printf("type_specifier <- LONG\n"); }
    | FLOAT
    { printf("type_specifier <- FLOAT\n"); }
    | DOUBLE
    { printf("type_specifier <- DOUBLE\n"); }
    | SIGNED
    { printf("type_specifier <- SIGNED\n"); }
    | UNSIGNED
    { printf("type_specifier <- UNSIGNED\n"); }
    | _BOOL
    { printf("type_specifier <- _BOOL\n"); }
    | _COMPLEX
    { printf("type_specifier <- _COMPLEX\n"); }
    | _IMAGINARY
    { printf("type_specifier <- _IMAGINARY\n"); }
    | enum_specifier
    { printf("type_specifier <- ENUM_SPECIFIER\n"); }
    ;

specific_qualifier_list: type_specifier specific_qualifier_list_opt
    { printf("specific_qualifier_list <- type_specifier specific_qualifier_list_opt\n"); }
    | type_qualifier specific_qualifier_list_opt
    { printf("specific_qualifier_list <- type_qualifier specific_qualifier_list_opt\n"); }
    ;

specific_qualifier_list_opt: specific_qualifier_list
    { printf("specific_qualifier_list_opt <- specific_qualifier_list\n"); }
    | %empty
    { printf("specific_qualifier_list_opt <- epsilon\n"); }
    ;

enum_specifier: ENUM identifier_opt CUROPEN enum_list CURCLOSE
    { printf("enum_specifier <- enum identifier_opt { enumerator-list }\n"); }
    | ENUM identifier_opt CUROPEN enum_list COMMA CURCLOSE
    { printf("enum_specifier <- enum identifier_opt { enumerator-list , }\n"); }
    | ENUM IDENTIFIER
    { printf("enum_specifier <- enum identifier\n"); }
    ;

identifier_opt: IDENTIFIER
    { printf("identifier_opt <- identifier\n"); }
    | %empty
    { printf("identifier_opt <- epsilon\n"); }
    ;

enum_list: enumerator
    { printf("enumerator-list <- enumerator\n"); }
    | enum_list COMMA enumerator
    { printf("enumerator-list <- enumerator_list , enumerator\n"); }
    ;

enumerator: IDENTIFIER
    { printf("enumerator <- enumeration_constant\n"); }
    | IDENTIFIER EQUAL constant
    { printf("enumerator <- enumeration_constant = constant-expression\n"); }
    ;

type_qualifier: CONST
    { printf("type_qualifier <- CONST\n"); }
    | RESTRICT
    { printf("type_qualifier <- RESTRICT\n"); }
    | VOLATILE
    { printf("type_qualifier <- VOLATILE\n"); }
    ;

function_specifier: INLINE
    { printf("function_specifier <- INLINE\n"); }
    ;

declarator: pointer_opt direct_declarator
    { printf("declarator <- pointer_opt direct_declarator\n"); }
    ;

direct_declarator: IDENTIFIER
    { printf("direct_declarator <- IDENTIFIER\n"); }
    | CIROPEN declarator CIRCLOSE
    { printf("direct_declarator <- ( declarator )\n"); }
    | direct_declarator SQROPEN type_qualifier_list_opt assignment_expression_opt SQRCLOSE
    { printf("direct_declarator <- direct_declarator [ type_qualifier_list_opt assignment_expression_opt ]\n"); }
    | direct_declarator SQROPEN STATIC type_qualifier_list_opt assignment_expression SQRCLOSE
    { printf("direct_declarator <- direct_declarator [ STATIC type_qualifier_list_opt assignment_expression ]\n"); }
    | direct_declarator SQROPEN type_qualifier_list STATIC assignment_expression SQRCLOSE
    { printf("direct_declarator <- direct_declarator [ type_qualifier_list STATIC assignment_expression ]\n"); }
    | direct_declarator SQROPEN type_qualifier_list_opt MUL SQRCLOSE
    { printf("direct_declarator <- direct_declarator [ type_qualifier_list_opt * ]\n"); }
    | direct_declarator CIROPEN parameter_type_list CIRCLOSE
    { printf("direct_declarator <- direct_declarator ( parameter_type_list )\n"); }
    | direct_declarator CIROPEN identifier_list_opt CIRCLOSE
    { printf("direct_declarator <- direct_declarator ( identifier_list_opt )\n"); }
    ;

identifier_list_opt: identifier_list
    { printf("identifier_list_opt <- identifier_list\n"); }
    | %empty
    { printf("identifier_list_opt <- epsilon\n"); }
    ;

type_qualifier_list_opt: type_qualifier_list
    { printf("type_qualifier_list_opt <- type_qualifier_list\n"); }
    | %empty
    { printf("type_qualifier_list_opt <- epsilon\n"); }
    ;

assignment_expression_opt: assignment_expression
    { printf("assignment_expression_opt <- assignment_expression\n"); }
    | %empty
    { printf("assignment_expression_opt <- epsilon\n"); }
    ;

pointer_opt: pointer
    { printf("pointer_opt <- pointer\n"); }
    | %empty
    { printf("pointer_opt <- epsilon\n"); }
    ;

pointer: MUL type_qualifier_list_opt
    { printf("pointer <- * type_qualifier_list_opt\n"); }
    | MUL type_qualifier_list_opt pointer
    { printf("pointer <- * type_qualifier_list_opt pointer\n"); }
    ;

type_qualifier_list: type_qualifier
    { printf("type_qualifier_list <- type_qualifier\n"); }
    | type_qualifier_list type_qualifier
    { printf("type_qualifier_list <- type_qualifier_list type_qualifier\n"); }
    ;

parameter_type_list: parameter_list
    { printf("parameter_type_list <- parameter_list\n"); }
    | parameter_list COMMA TDOT
    { printf("parameter_type_list <- parameter_list , ...\n"); }
    ;

parameter_list: parameter_declaration
    { printf("parameter_list <- parameter_declaration\n"); }
    | parameter_list COMMA parameter_declaration
    { printf("parameter_list <- parameter_list , parameter_declaration\n"); }
    ;

parameter_declaration: declaration_specifiers declarator
    { printf("parameter_declaration <- declaration_specifiers declarator\n"); }
    | declaration_specifiers
    { printf("parameter_declaration <- declaration_specifiers\n"); }
    ;

identifier_list: IDENTIFIER
    { printf("identifier_list <- IDENTIFIER\n"); }
    | identifier_list COMMA IDENTIFIER
    { printf("identifier_list <- identifier_list , IDENTIFIER\n"); }
    ;

type_name: specific_qualifier_list
    { printf("type_name <- specific_qualifier_list\n"); }
    ;

initializer: assignment_expression
    { printf("initializer <- assignment_expression\n"); }
    | CUROPEN initializer_list CURCLOSE
    { printf("initializer <- { initializer_list }\n"); }
    | CUROPEN initializer_list COMMA CURCLOSE
    { printf("initializer <- { initializer_list , }\n"); }
    ;

initializer_list: designation_opt initializer
    { printf("initializer_list <- designation_opt initializer\n"); }
    | initializer_list COMMA designation_opt initializer
    { printf("initializer_list <- initializer_list , designation_opt initializer\n"); }
    ;

designation_opt: designation
    { printf("designation_opt <- designation\n"); }
    | %empty
    { printf("designation_opt <- epsilon\n"); }
    ;

designation: designator_list EQUAL
    { printf("designation <- designator_list =\n"); }
    ;

designator_list: designator
    { printf("designator_list <- designator\n"); }
    | designator_list designator
    { printf("designator_list <- designator_list designator\n"); }
    ;

designator: SQROPEN constant_expression SQRCLOSE
    { printf("designator <- [ constant_expression ]\n"); }
    | DOT IDENTIFIER
    { printf("designator <- . IDENTIFIER\n"); }
    ;

statement: labeled_statement
    { printf("statement <- labeled_statement\n"); }
    | compound_statement
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

labeled_statement: IDENTIFIER COLON statement
    { printf("labeled_statement <- IDENTIFIER : statement\n"); }
    | CASE constant_expression COLON statement
    { printf("labeled_statement <- CASE constant_expression : statement\n"); }
    | DEFAULT COLON statement
    { printf("labeled_statement <- DEFAULT : statement\n"); }
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
    | SWITCH CIROPEN expression CIRCLOSE statement
    { printf("selection_statement <- SWITCH ( expression ) statement\n"); }
    ;

iteration_statement: WHILE CIROPEN expression CIRCLOSE statement
    { printf("iteration_statement <- WHILE ( expression ) statement\n"); }
    | DO statement WHILE CIROPEN expression CIRCLOSE LINEEND
    { printf("iteration_statement <- DO statement WHILE ( expression ) ;\n"); }
    | FOR CIROPEN expression_opt LINEEND expression_opt LINEEND expression_opt CIRCLOSE statement
    { printf("iteration_statement <- FOR ( expression_opt ; expression_opt ; expression_opt ) statement\n"); }
    | FOR CIROPEN declaration expression_opt LINEEND expression_opt CIRCLOSE statement
    { printf("iteration_statement <- FOR ( declaration expression_opt ; expression_opt ) statement\n"); }
    ;

jump_statement: GOTO IDENTIFIER LINEEND
    { printf("jump_statement <- GOTO IDENTIFIER ;\n"); }
    | CONTINUE LINEEND
    { printf("jump_statement <- CONTINUE ;\n"); }
    | BREAK LINEEND
    { printf("jump_statement <- BREAK ;\n"); }
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

function_definition: declaration_specifiers declarator declaration_list_opt compound_statement
    { printf("function_definition <- declaration_specifiers declarator declaration_list_opt compound_statement\n"); }
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