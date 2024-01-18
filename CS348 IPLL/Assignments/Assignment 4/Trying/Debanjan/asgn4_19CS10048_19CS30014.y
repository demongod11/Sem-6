%{
    #include<stdio.h>
    extern int yylex();
    void yyerror(char* s);
%}

%union {
    int intval;
}


%token AUTO BREAK CASE CHAR CONST CONTINUE DEFAULT DO DOUBLE ELSE ENUM EXTERN FLOAT FOR GOTO IF INLINE INT LONG REGISTER RESTRICT RETURN SHORT SIGNED SIZEOF STATIC STRUCT SWITCH TYPEDEF UNION UNSIGNED VOID VOLATILE WHILE _BOOL _COMPLEX _IMAGINARY 

%token IDENTIFIER INTEGER_CONSTANT FLOATING_CONSTANT CHARACTER_CONSTANT STRING_LITERAL ENUMERATION_CONSTANT

%token ARROW INC DEC MUL ADD SUB DIV MOD SHIFT_LEFT SHIFT_RIGHT
%token LT GT LTE GTE EQ NEQ BITWISE_XOR BITWISE_OR BITWISE_NOT BITWISE_AND AND OR 
%token COLON SEMICOLON ELLIPSIS ASSIGN 
%token MUL_EQ DIV_EQ MOD_EQ ADD_EQ SUB_EQ SHIFT_LEFT_EQ SHIFT_RIGHT_EQ BITWISE_AND_EQ BITWISE_XOR_EQ BITWISE_OR_EQ 
%token COMMA HASH 

%nonassoc ')'

%nonassoc ELSE

%start translation_unit
%%
primary_expression: 
                    IDENTIFIER
                    {printf("| Rule: primary_expression => IDENTIFIER|\n");}
                    | constant
                    {printf("| Rule: primary_expression => constant |\n");}
                    | STRING_LITERAL
                    {printf("| Rule: primary_expression => STRING LITERAL |\n");}
                    | '(' expression ')'
                    {printf("| Rule: primary_expression => Parenthesis Expression |\n");}
                    ;

constant: 
            INTEGER_CONSTANT 
            {printf("| Rule: constant => INTEGER|\n");}
            | FLOATING_CONSTANT 
            {printf("| Rule: constant => FLOATING-POINT|\n");}
            | CHARACTER_CONSTANT
            {printf("| Rule: constant => CHARACTER|\n");}
            ;



postfix_expression: 
                    primary_expression
                    {printf("| Rule: postfix_expression => primary_expression |\n");}
                    | postfix_expression '[' expression ']'
                    {printf("| Rule: postfix_expression => postfix_expression [expression] |\n");}
                    | postfix_expression '(' argument_expression_list_opt ')'
                    {printf("| Rule: postfix_expression => postfix_expression (OPTIONAL : argument expression list) |\n");}
                    | postfix_expression '.' IDENTIFIER
                    {printf("| Rule: postfix_expression => postfix_expression.IDENTIFIER |\n");}
                    | postfix_expression ARROW IDENTIFIER
                    {printf("| Rule: postfix_expression => postfix_expression->IDENTIFIER |\n");}
                    | postfix_expression INC
                    {printf("| Rule: postfix_expression => postfix_expression ++ |\n");}
                    | postfix_expression DEC
                    {printf("| Rule: postfix_expression => primary_expression -- |\n");}
                    | '(' type_name ')' '{' initializer_list '}'
                    {printf("| Rule: postfix_expression => (type_name) { initializer_list } |\n");}
                    | '(' type_name ')' '{' initializer_list COMMA '}'
                    {printf("| Rule: postfix_expression => (type_name) { initializer_list , } |\n");}
                    ;


argument_expression_list:
                            assignment_expression
                            {printf("| Rule: argument_expression_list => assignment_expression |\n");}
                            | argument_expression_list COMMA assignment_expression
                            {printf("| Rule: argument_expression_list => argument_expression_list, assignment_expression |\n");}
                            ;

argument_expression_list_opt
	: argument_expression_list
	| /* epsilon */
    ;


unary_expression: 
                    postfix_expression
                    {printf("| Rule: unary_expression => postfix_expression |\n");}
                    | INC unary_expression
                    {printf("| Rule: unary_expression => ++ unary_expression |\n");}
                    | DEC unary_expression
                    {printf("| Rule: unary_expression => -- unary_expression |\n");}
                    | unary_operator cast_expression
                    {printf("| Rule: unary_expression => unary_operator cast_expression |\n");}
                    | SIZEOF unary_expression
                    {printf("| Rule: unary_expression => sizeof unary_expression |\n");}
                    | SIZEOF '(' type_name ')'
                    {printf("| Rule: unary_expression => sizeof(typename) |\n");}
                    ;

unary_operator: 
                    BITWISE_AND
                    {printf("| Rule: unary_expression => & |\n");}
                    | MUL
                    {printf("| Rule: unary_expression => * |\n");}
                    | ADD
                    {printf("| Rule: unary_expression => + |\n");}
                    | SUB
                    {printf("| Rule: unary_expression => - |\n");}
                    | BITWISE_NOT
                    {printf("| Rule: unary_expression => ~ |\n");}
                    | '!'
                    { printf("| Rule: unary_operator => ! |\n"); }
                    ;

cast_expression: 
                    unary_expression
                    {printf("| Rule: cast_expression => unary_expression |\n");}
                    | '(' type_name ')' cast_expression
                    {printf("| Rule: cast_expression =>  (typename) cast_expression |\n");}
                    ;

multiplicative_expression: 
                            cast_expression
                            {printf("| Rule: multiplicative_expression => cast_expression |\n");}
                            | multiplicative_expression MUL cast_expression
                            {printf("| Rule: multiplicative_expression =>  multiplicative_expression * cast_expression |\n");}
                            | multiplicative_expression DIV cast_expression
                            {printf("| Rule: multiplicative_expression =>  multiplicative_expression / cast_expression|\n");}
                            | multiplicative_expression MOD cast_expression
                            {printf("| Rule: multiplicative_expression =>  multiplicative_expression modulo cast_expression |\n");}
                            ;

additive_expression: 
                        multiplicative_expression
                        {printf("| Rule: additive_expression => multiplicative_expression |\n");}
                        | additive_expression ADD multiplicative_expression
                        {printf("| Rule: additive_expression =>  additive_expression + multiplicative_expression |\n");}
                        | additive_expression SUB multiplicative_expression
                        {printf("| Rule: additive_expression =>  additive_expression - multiplicative_expression |\n");}
                        ;

shift_expression: 
                    additive_expression
                    {printf("| Rule: shift_expression => additive_expression |\n");}
                    | shift_expression SHIFT_LEFT additive_expression
                    {printf("| Rule: shift_expression => shift_expression << additive_expression |\n");}
                    | shift_expression SHIFT_RIGHT additive_expression
                    {printf("| Rule: shift_expression =>  shift_expression >> additive_expression |\n");}
                    ;

relational_expression:
                        shift_expression
                        {printf("| Rule: relational_expression => shift_expression |\n");}
                        | relational_expression LT shift_expression
                        {printf("| Rule: relational_expression => relational_expression < shift_expression|\n");}
                        | relational_expression GT shift_expression
                        {printf("| Rule: relational_expression => relational_expression > shift_expression |\n");}
                        | relational_expression LTE shift_expression
                        {printf("| Rule: relational_expression => relational_expression <= shift_expression |\n");}
                        | relational_expression GTE shift_expression
                        {printf("| Rule: relational_expression =>  relational_expression >= shift_expression |\n");}
                        ;

equality_expression: 
                        relational_expression
                        {printf("| Rule: equality_expression => relational_expression |\n");}
                        | equality_expression EQ relational_expression
                        {printf("| Rule: equality_expression =>  equality_expression == relational_expression |\n");}
                        | equality_expression NEQ relational_expression
                        {printf("| Rule: equality_expression =>  equality_expression != relational_expression |\n");}
                        ;

AND_expression: 
                    equality_expression
                    {printf("| Rule: AND_expression => equality_expression |\n");}
                    | AND_expression BITWISE_AND equality_expression
                    {printf("| Rule: AND_expression =>  AND_expression & equality_expression |\n");}
                    ;

exclusive_OR_expression: 
                            AND_expression
                            {printf("| Rule: exclusive_OR_expression => AND_expression |\n");}
                            | exclusive_OR_expression BITWISE_XOR AND_expression
                            {printf("| Rule: exclusive_OR_expression =>  exclusive_OR_expression ^ AND_expression |\n");}
                            ;

inclusive_OR_expression: 
                            exclusive_OR_expression
                            {printf("| Rule: inclusive_OR_expression => exclusive_OR_expression |\n");}
                            | inclusive_OR_expression BITWISE_OR exclusive_OR_expression
                            {printf("| Rule: inclusive_OR_expression =>  inclusive_OR_expression | exclusive_OR_expression |\n");}
                            ;

logical_AND_expression: 
                            inclusive_OR_expression
                            {printf("| Rule: logical_AND_expression => inclusive_OR_expression |\n");}
                            | logical_AND_expression AND inclusive_OR_expression
                            {printf("| Rule: logical_AND_expression => logical_AND_expression && inclusive_OR_expression |\n");}
                            ;

logical_OR_expression: 
                        logical_AND_expression
                        {printf("| Rule: logical_OR_expression => logical_AND_expression |\n");}
                        | logical_OR_expression OR logical_AND_expression
                        {printf("| Rule: logical_OR_expression =>  logical_OR_expression || logical_AND_expression |\n");}
                        ;

conditional_expression: 
                        logical_OR_expression
                        {printf("| Rule: conditional_expression => logical_OR_expression |\n");}
                        | logical_OR_expression '?' expression COLON conditional_expression
                        {printf("| Rule: conditional_expression =>  logical_OR_expression ? expression : conditional_expression |\n");}
                        ;

assignment_expression: 
                        conditional_expression
                        {printf("| Rule: assignment_expression => conditional_expression |\n");}
                        | unary_expression assignment_operator assignment_expression
                        {printf("| Rule: assignment_expression =>  unary_expression assignment_operator assignment_expression |\n");}
                        ;

assignment_operator: 
	ASSIGN
    {printf("| Rule: assignment_operator => = |\n");}
	| MUL_EQ
    {printf("| Rule: assignment_operator => *= |\n");}
	| DIV_EQ
    {printf("| Rule: assignment_operator => /= |\n");}
	| MOD_EQ
    {printf("| Rule: assignment_operator => modulo |\n");}
	| ADD_EQ
    {printf("| Rule: assignment_operator => += |\n");}
	| SUB_EQ
    {printf("| Rule: assignment_operator => -= |\n");}
	| SHIFT_LEFT_EQ
    {printf("| Rule: assignment_operator => <<= |\n");}
	| SHIFT_RIGHT_EQ
    {printf("| Rule: assignment_operator => >>= |\n");}
	| BITWISE_AND_EQ
    {printf("| Rule: assignment_operator => &= |\n");}
	| BITWISE_XOR_EQ
    {printf("| Rule: assignment_operator => ^= |\n");}
	| BITWISE_OR_EQ
	{printf("| Rule: assignment_operator => |= |\n");}
	;

expression: 
            assignment_expression
            {printf("| Rule: expression => assignment_expression |\n");}
            | expression COMMA assignment_expression
            {printf("| Rule: expression =>  expression , assignment_expression |\n");}
            ;

constant_expression: 
                    conditional_expression
                    {printf("| Rule: constant_expression => conditional_expression |\n");}
                    ;   

declaration: 
	declaration_specifiers init_declarator_list_opt SEMICOLON
	{printf("| Rule: declaration => declaration_specifiers init_declarator_list_opt ; |\n");}
	;

declaration_specifiers: 
                        storage_class_specifier declaration_specifiers_opt
                        {printf("| Rule: declaration_specifiers => storage_class_specifier declaration_specifiers_opt |\n");}
                        | type_specifier declaration_specifiers_opt
                        {printf("| Rule: declaration_specifiers => type_specifier declaration_specifiers_opt |\n");}
                        | type_qualifier declaration_specifiers_opt
                        {printf("| Rule: declaration_specifiers => type_qualifier declaration_specifiers_opt |\n");}
                        | function_specifier declaration_specifiers_opt
                        {printf("| Rule: declaration_specifiers => function_specifier declaration_specifiers_opt |\n");}
                        ;

declaration_specifiers_opt: 
                            declaration_specifiers
                            | /* epsilon */
                            ;

init_declarator_list: 
                    init_declarator
                    {printf("| Rule: init_declarator_list => init_declarator |\n");}
                    | init_declarator_list COMMA init_declarator
                    {printf("| Rule: init_declarator_list =>  init_declarator_list , init_declarator |\n");}
	                ;

init_declarator_list_opt:
	init_declarator_list
	| /* epsilon */
	;

init_declarator: 
	declarator
    {printf("| Rule: init_declarator => declarator |\n");}
	| declarator ASSIGN initializer
	{printf("| Rule: init_declarator => declarator = initializer |\n");}
	;

storage_class_specifier: 
                        EXTERN
                        {printf("| Rule: storage_class_specifier => extern |\n");}
                        | STATIC
                        {printf("| Rule: storage_class_specifier => static |\n");}
                        | AUTO
                        {printf("| Rule: storage_class_specifier => auto |\n");}
                        | REGISTER
                        {printf("| Rule: storage_class_specifier => register |\n");}
                        ;

type_specifier:
                VOID
                {printf("| Rule: type_specifier => void |\n");}
                | CHAR
                {printf("| Rule: type_specifier => int |\n");}
                | SHORT
                {printf("| Rule: type_specifier => short |\n");}
                | INT
                {printf("| Rule: type_specifier => int |\n");}
                | LONG
                {printf("| Rule: type_specifier => long |\n");}
                | FLOAT
                {printf("| Rule: type_specifier => float |\n");}
                | DOUBLE
                {printf("| Rule: type_specifier => double |\n");}
                | SIGNED
                {printf("| Rule: type_specifier => signed |\n");}
                | UNSIGNED
                {printf("| Rule: type_specifier => unsigned |\n");}
                | _BOOL
                {printf("| Rule: type_specifier => _Bool |\n");}
                | _COMPLEX
                {printf("| Rule: type_specifier => _Complex |\n");}
                | _IMAGINARY
                {printf("| Rule: type_specifier => _Imaginary |\n");}
                | enum_specifier
                {printf("| Rule: type_specifier => enum_specifier |\n");}
                ;

specifier_qualifier_list: 
                        type_specifier specifier_qualifier_list_opt
                        {printf("| Rule: specifier_qualifier_list => type_specifier specifier_qualifier_list_opt |\n");}
                        | type_qualifier specifier_qualifier_list_opt
                        {printf("| Rule: specifier_qualifier_list => type_qualifier specifier_qualifier_list_opt |\n");}
                        ;

specifier_qualifier_list_opt: 
                            specifier_qualifier_list
                            | /* epsilon */
                            ;


enum_specifier: 
                ENUM identifier_opt '{' enumerator_list '}'
                {printf("| Rule: enum_specifier => enum identifier_opt { enumerator_list } |\n");}
                | ENUM identifier_opt '{' enumerator_list COMMA '}'
                {printf("| Rule: enum_specifier =>  enum identifier_opt { enumerator_list , } |\n");}
                | ENUM IDENTIFIER
                {printf("| Rule: enum_specifier =>  enum IDENTIFIER |\n");}
                ;

identifier_opt:
                IDENTIFIER
                | /* epsilon */
                ;

enumerator_list: 
                enumerator
                {printf("| Rule: enumerator_list => enumerator |\n");}
                | enumerator_list COMMA enumerator
                {printf("| Rule: enumerator_list => enumerator_list , enumerator |\n");}
                ;

enumerator: 
            ENUMERATION_CONSTANT
            {printf("| Rule: enumerator => ENUMERATION_CONSTANT |\n");}
            | ENUMERATION_CONSTANT ASSIGN constant_expression
            {printf("| Rule: enumerator => ENUMERATION_CONSTANT = constant_expression |\n");}
            ;

type_qualifier: 
                CONST
                {printf("| Rule: type_qualifier => const |\n");}
                | RESTRICT
                {printf("| Rule: type_qualifier => restrict |\n");}
                | VOLATILE
                {printf("| Rule: type_qualifier => volatile|\n");}
                ;

function_specifier: 
                    INLINE
                    {printf("| Rule: function_specifier => inline |\n");}
                    ;

declarator: 
            pointer_opt direct_declarator
            {printf("| Rule: declarator => pointer_opt direct_declarator |\n");}
            ;

direct_declarator: 
                    IDENTIFIER
                    {printf("| Rule: direct_declarator => IDENTIFIER |\n");}
                    | '(' declarator ')'
                    {printf("| Rule: direct_declarator =>  ( declarator ) |\n");}
                    | direct_declarator '['  type_qualifier_list_opt assignment_expression_opt ']'
                    {printf("| Rule: direct_declarator =>  direct_declarator [  type_qualifier_list_opt assignment_expression_opt ] |\n");}
                    | direct_declarator '[' STATIC type_qualifier_list_opt assignment_expression ']'
                    {printf("| Rule: direct_declarator =>  direct_declarator [ static type_qualifier_list_opt assignment_expression ] |\n");}
                    | direct_declarator '[' type_qualifier_list STATIC assignment_expression ']'
                    {printf("| Rule: direct_declarator =>  direct_declarator [ type_qualifier_list static assignment_expression ] |\n");}
                    | direct_declarator '[' type_qualifier_list_opt MUL ']'
                    {printf("| Rule: direct_declarator =>  direct_declarator [ type_qualifier_list_opt * ] |\n");}
                    | direct_declarator '(' parameter_type_list ')'
                    {printf("| Rule: direct_declarator =>  direct_declarator ( parameter_type_list ) |\n");}
                    | direct_declarator '(' identifier_list_opt ')'
                    {printf("| Rule: direct_declarator =>  direct_declarator ( identifier_list_opt ) |\n");}
                    ;

pointer: 
        MUL type_qualifier_list_opt
        {printf("| Rule: pointer => * type_qualifier_list_opt |\n");}
        | MUL type_qualifier_list_opt pointer
        {printf("| Rule: pointer => * type_qualifier_list_opt pointer  |\n");}
        ;

pointer_opt: 
            pointer
            | /* epsilon */
            ;

assignment_expression_opt: 
	assignment_expression
	| /* epsilon */
	;

identifier_list_opt
	: identifier_list
	| /* epsilon */
	;


type_qualifier_list: 
                    type_qualifier
                    {printf("| Rule: type_qualifier_list => type_qualifier |\n");}
                    | type_qualifier_list type_qualifier
                    {printf("| Rule: type_qualifier_list => type_qualifier_list type_qualifier |\n");}
                    ;


type_qualifier_list_opt: 
                        type_qualifier_list
                        | /* epsilon */
                        ;


parameter_type_list: 
                    parameter_list
                    {printf("| Rule: parameter_type_list => parameter_list |\n");}
                    | parameter_list COMMA ELLIPSIS
                    {printf("| Rule: parameter_type_list =>  parameter_list , ... |\n");}
                    ;

parameter_list: 
                parameter_declaration
                {printf("| Rule: parameter_list => parameter_declaration |\n");}
                | parameter_list COMMA parameter_declaration
                {printf("| Rule: parameter_list =>  parameter_list , parameter_declaration |\n");}
                ;

parameter_declaration: 
                        declaration_specifiers declarator
                        {printf("| Rule: parameter_declaration => declaration_specifiers declarator |\n");}
                        | declaration_specifiers
                        {printf("| Rule: parameter_declaration => declaration_specifiers |\n");}
                        ;

identifier_list: 
                IDENTIFIER
                {printf("| Rule: identifier_list => IDENTIFIER |\n");}
                | identifier_list COMMA IDENTIFIER
                {printf("| Rule: identifier_list => identifier_list , IDENTIFIER |\n");}
                ;

type_name: 
            specifier_qualifier_list
            {printf("| Rule: type_name => specifier_qualifier_list |\n");}
            ;

initializer: 
            assignment_expression
            | '{' initializer_list '}'
            {printf("| Rule: initializer => { initializer_list } |\n");}
            | '{' initializer_list COMMA '}'
            {printf("| Rule: initializer => { initializer_list , } |\n");}
            ;

initializer_list: 
                    designation_opt initializer
                    {printf("| Rule: initializer_list => designation_opt initializer |\n");}
                    | initializer_list COMMA designation_opt initializer
                    {printf("| Rule: initializer_list => initializer_list , designation_opt initializer |\n");}
                    ;

designation_opt:
                designation
                | /* epsilon */
                ;

designation: 
	designator_list ASSIGN
	{printf("| Rule: designation => designator_list = |\n");}
	;

designator_list: 
                designator
                {printf("| Rule: designator_list => designator |\n");}
                | designator_list designator
                {printf("| Rule: designator_list => designator_list designator |\n");}
                ;

designator: 
	'[' constant_expression ']'
    {printf("| Rule: designator => [ constant_expression ] |\n");}
	| '.' IDENTIFIER
	{printf("| Rule: designator => . IDENTIFIER |\n");}
	;

statement: 
            labeled_statement
            {printf("| Rule: statement => labeled_statement |\n");}
            | compound_statement
            {printf("| Rule: statement => compound_statement|\n");}
            | expression_statement
            {printf("| Rule: statement => expression_statement |\n");}
            | selection_statement
            {printf("| Rule: statement => selection_statement |\n");}
            | iteration_statement
            {printf("| Rule: statement => iteration_statement |\n");}
            | jump_statement
            {printf("| Rule: statement => jump_statement |\n");}
            ;

labeled_statement: 
                    IDENTIFIER COLON statement
                    {printf("| Rule: labeled_statement => IDENTIFIER : statement |\n");}
                    | CASE constant_expression COLON statement
                    {printf("| Rule: labeled_statement => case constant_expression : statement |\n");}
                    | DEFAULT COLON statement
                    {printf("| Rule: labeled_statement => default : statement |\n");}
                    ;

compound_statement: 
                    '{' block_item_list_opt '}'
                    {printf("| Rule: compound_statement => { block_item_list_opt } |\n");}
                    ;


block_item_list: 
                block_item
                {printf("| Rule: block_item_list => block_item |\n");}
                | block_item_list block_item
                {printf("| Rule: block_item_list => block_item_list block_item |\n");}
                ;

block_item_list_opt: 
                    block_item_list
                    | /* epsilon */
                    ;

block_item: 
            declaration
            {printf("| Rule: block_item => declaration |\n");}
            | statement
            {printf("| Rule: block_item => statement |\n");}
            ;

expression_statement: 
                        expression_opt SEMICOLON
                        {printf("| Rule: expression_statement => expression_opt ; |\n");}
                        ;

expression_opt: 
                expression
                | /* epsilon */
                ;

selection_statement: 
                    IF '(' expression ')' statement
                    {printf("| Rule: selection_statement => if ( expression ) statement |\n");}
                    | IF '(' expression ')' statement ELSE statement
                    {printf("| Rule: selection_statement => if ( expression ) statement else statement |\n");}
                    | SWITCH '(' expression ')' statement
                    {printf("| Rule: selection_statement => switch ( expression ) statement |\n");}
                    ;

iteration_statement:
                    WHILE '(' expression ')' statement
                    {printf("| Rule: iteration_statement => while ( expression ) statement |\n");}
                    | DO statement WHILE '(' expression ')' SEMICOLON
                    {printf("| Rule: iteration_statement => do statement while ( expression ) ; |\n");}
                    | FOR '(' expression_opt SEMICOLON expression_opt SEMICOLON expression_opt ')' statement
                    {printf("| Rule: iteration_statement => for ( expression_opt ; expression_opt ; expression_opt ) statement |\n");}
                    | FOR '(' declaration expression_opt SEMICOLON expression_opt ')' statement
                    {printf("| Rule: iteration_statement => for ( declaration expression_opt ; expression_opt ) statement |\n");}
                    ;

jump_statement: 
                GOTO IDENTIFIER SEMICOLON
                {printf("| Rule: jump_statement => goto IDENTIFIER ; |\n");}
                | CONTINUE SEMICOLON
                {printf("| Rule: jump_statement => continue ; |\n");}
                | BREAK SEMICOLON
                {printf("| Rule: jump_statement => break ; |\n");}
                | RETURN expression_opt SEMICOLON
                {printf("| Rule: jump_statement => return expression_opt ; |\n");}
                ;

translation_unit: 
                external_declaration
                {printf("| Rule: translation_unit => external_declaration|\n");}
                | translation_unit external_declaration
                {printf("| Rule: translation_unit => translation_unit external_declaration |\n");}
                ;

external_declaration: 
                    function_definition
                    {printf("| Rule: external_declaration => function_definition |\n");}
                    | declaration
                    {printf("| Rule: external_declaration => declaration |\n");}
                    ;

function_definition: 
                    declaration_specifiers declarator declaration_list_opt compound_statement
                    {printf("| Rule: function_definition => declaration_specifiers declarator declaration_list_opt compound_statement |\n");}
                    ;

declaration_list_opt: 
                    declaration_list
                    | /* epsilon */
                    ;

declaration_list: 
                declaration
                {printf("| Rule: declaration_list => declaration |\n");}
                | declaration_list declaration
                {printf("| Rule: declaration_list => declaration_list declaration |\n");}
                ;

%%

void yyerror(char* s)
{
    printf("Detected Error: %s\n", s);
}