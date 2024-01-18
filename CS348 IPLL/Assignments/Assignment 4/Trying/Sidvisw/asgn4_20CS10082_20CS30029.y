%{  /* C Declarations and Definitions */
    #include<iostream>
    extern int yylex();
    extern int yylineno;
    extern char *yytext;
    void yyerror(const char *s);
%}

%union {    /* Placeholder for values */
    int intval;
    float floatval;
    char charval;
    char *stringval;
}

/* Keywords */
%token AUTO BREAK CASE CHAR CONST CONTINUE DEFAULT DO DOUBLE ELSE ENUM EXTERN FLOAT FOR GOTO IF INLINE INT LONG REGISTER RESTRICT RETURN SHORT SIGNED SIZEOF STATIC STRUCT SWITCH TYPEDEF UNION UNSIGNED VOID VOLATILE WHILE _BOOL _COMPLEX _IMAGINARY

/* Punctuators */
%token SQUARE_BRACKET_OPEN SQUARE_BRACKET_CLOSE ROUND_BRACKET_OPEN ROUND_BRACKET_CLOSE CURLY_BRACKET_OPEN CURLY_BRACKET_CLOSE DOT ARROW INCREMENT DECREMENT BITWISE_AND MULTIPLY ADD SUBTRACT BITWISE_NOT LOGICAL_NOT DIVIDE MODULUS LEFT_SHIFT RIGHT_SHIFT LESS_THAN GREATER_THAN LESS_THAN_OR_EQUAL_TO GREATER_THAN_OR_EQUAL_TO EQUAL_TO NOT_EQUAL_TO BITWISE_XOR BITWISE_OR LOGICAL_AND LOGICAL_OR QUESTION_MARK COLON SEMICOLON ELLIPSIS ASSIGNMENT MULTIPLY_ASSIGNMENT DIVIDE_ASSIGNMENT MODULUS_ASSIGNMENT ADD_ASSIGNMENT SUBTRACT_ASSIGNMENT LEFT_SHIFT_ASSIGNMENT RIGHT_SHIFT_ASSIGNMENT BITWISE_AND_ASSIGNMENT BITWISE_XOR_ASSIGNMENT BITWISE_OR_ASSIGNMENT COMMA HASH

/* Other Terminals */
%token CONSTANT IDENTIFIER STRING_LITERAL

/* Handle Dangling else conflict other conflicts are handled by the language production rules */
%nonassoc ROUND_BRACKET_CLOSE
%nonassoc ELSE

/* Define the start symbol */
%start translation_unit

%%

/* EXPRESSIONS */

primary_expression : IDENTIFIER
                        { printf("primary-expression --> identifier\n"); }
                   | CONSTANT
                        { printf("primary-expression --> constant\n"); }
                   | STRING_LITERAL
                        { printf("primary-expression --> string-literal\n"); }
                   | ROUND_BRACKET_OPEN expression ROUND_BRACKET_CLOSE
                        { printf("primary-expression --> ( expression )\n"); }
                   ;

postfix_expression : primary_expression
                        { printf("postfix-expression --> primary-expression\n"); }
                   | postfix_expression SQUARE_BRACKET_OPEN expression SQUARE_BRACKET_CLOSE
                        { printf("postfix-expression --> postfix-expression [ expression ]\n"); }
                   | postfix_expression ROUND_BRACKET_OPEN argument_expression_list_opt ROUND_BRACKET_CLOSE
                        { printf("postfix-expression --> postfix-expression ( argument-expression-list_opt )\n"); }
                   | postfix_expression DOT IDENTIFIER
                        { printf("postfix-expression --> postfix-expression . identifier\n"); }
                   | postfix_expression ARROW IDENTIFIER
                        { printf("postfix-expression --> postfix-expression -> identifier\n"); }
                   | postfix_expression INCREMENT
                        { printf("postfix-expression --> postfix-expression ++\n"); }
                   | postfix_expression DECREMENT
                        { printf("postfix-expression --> postfix-expression --\n"); }
                   | ROUND_BRACKET_OPEN type_name ROUND_BRACKET_CLOSE CURLY_BRACKET_OPEN initializer_list CURLY_BRACKET_CLOSE
                        { printf("postfix-expression --> ( type-name ) { initializer-list }\n"); }
                   | ROUND_BRACKET_OPEN type_name ROUND_BRACKET_CLOSE CURLY_BRACKET_OPEN initializer_list COMMA CURLY_BRACKET_CLOSE
                        { printf("postfix-expression --> ( type-name ) { initializer-list , }\n"); }
                   ;
    
argument_expression_list_opt : argument_expression_list
                                   { printf("argument-expression-list_opt --> argument-expression-list\n"); }
                             | /* epsilon */
                                   { printf("argument-expression-list_opt --> epsilon\n"); }
                             ;
                
argument_expression_list : assignment_expression
                               { printf("argument-expression-list --> assignment-expression\n"); }
                         | argument_expression_list COMMA assignment_expression
                               { printf("argument-expression-list --> argument-expression-list , assignment-expression\n"); }
                         ;

unary_expression : postfix_expression
                        { printf("unary-expression --> postfix-expression\n"); }
                 | INCREMENT unary_expression
                        { printf("unary-expression --> ++ unary-expression\n"); }
                 | DECREMENT unary_expression
                        { printf("unary-expression --> -- unary-expression\n"); }
                 | unary_operator cast_expression
                        { printf("unary-expression --> unary-operator cast-expression\n"); }
                 | SIZEOF unary_expression
                        { printf("unary-expression --> sizeof unary-expression\n"); }
                 | SIZEOF ROUND_BRACKET_OPEN type_name ROUND_BRACKET_CLOSE
                        { printf("unary-expression --> sizeof ( type-name )\n"); }
                 ;

unary_operator : BITWISE_AND
                    { printf("unary-operator --> &\n"); }
               | MULTIPLY
                    { printf("unary-operator --> *\n"); }
               | ADD
                    { printf("unary-operator --> +\n"); }
               | SUBTRACT
                    { printf("unary-operator --> -\n"); }
               | BITWISE_NOT
                    { printf("unary-operator --> ~\n"); }
               | LOGICAL_NOT
                    { printf("unary-operator --> !\n"); }
               ;

cast_expression : unary_expression
                      { printf("cast-expression --> unary-expression\n"); }
                | ROUND_BRACKET_OPEN type_name ROUND_BRACKET_CLOSE cast_expression
                      { printf("cast-expression --> ( type-name ) cast-expression\n"); }
                ;

multiplicative_expression : cast_expression
                                { printf("multiplicative-expression --> cast-expression\n"); }
                          | multiplicative_expression MULTIPLY cast_expression
                                { printf("multiplicative-expression --> multiplicative-expression * cast-expression\n"); }
                          | multiplicative_expression DIVIDE cast_expression
                                { printf("multiplicative-expression --> multiplicative-expression / cast-expression\n"); }
                          | multiplicative_expression MODULUS cast_expression
                                { printf("multiplicative-expression --> multiplicative-expression %% cast-expression\n"); }
                          ;

additive_expression : multiplicative_expression
                          { printf("additive-expression --> multiplicative-expression\n"); }
                    | additive_expression ADD multiplicative_expression
                          { printf("additive-expression --> additive-expression + multiplicative-expression\n"); }
                    | additive_expression SUBTRACT multiplicative_expression
                          { printf("additive-expression --> additive-expression - multiplicative-expression\n"); }
                    ;

shift_expression : additive_expression
                       { printf("shift-expression --> additive-expression\n"); }
                 | shift_expression LEFT_SHIFT additive_expression
                       { printf("shift-expression --> shift-expression << additive-expression\n"); }
                 | shift_expression RIGHT_SHIFT additive_expression
                       { printf("shift-expression --> shift-expression >> additive-expression\n"); }
                 ;

relational_expression : shift_expression
                            { printf("relational-expression --> shift-expression\n"); }
                      | relational_expression LESS_THAN shift_expression
                            { printf("relational-expression --> relational-expression < shift-expression\n"); }
                      | relational_expression GREATER_THAN shift_expression
                            { printf("relational-expression --> relational-expression > shift-expression\n"); }
                      | relational_expression LESS_THAN_OR_EQUAL_TO shift_expression
                            { printf("relational-expression --> relational-expression <= shift-expression\n"); }
                      | relational_expression GREATER_THAN_OR_EQUAL_TO shift_expression
                            { printf("relational-expression --> relational-expression >= shift-expression\n"); }
                      ;

equality_expression : relational_expression
                          { printf("equality-expression --> relational-expression\n"); }
                    | equality_expression EQUAL_TO relational_expression
                          { printf("equality-expression --> equality-expression == relational-expression\n"); }
                    | equality_expression NOT_EQUAL_TO relational_expression
                          { printf("equality-expression --> equality-expression != relational-expression\n"); }
                    ;

AND_expression : equality_expression
                     { printf("AND-expression --> equality-expression\n"); }
               | AND_expression BITWISE_AND equality_expression
                     { printf("AND-expression --> AND-expression & equality-expression\n"); }
               ;

exclusive_OR_expression : AND_expression
                              { printf("exclusive-OR-expression --> AND-expression\n"); }
                        | exclusive_OR_expression BITWISE_XOR AND_expression
                              { printf("exclusive-OR-expression --> exclusive-OR-expression ^ AND-expression\n"); }
                        ;

inclusive_OR_expression : exclusive_OR_expression
                              { printf("inclusive-OR-expression --> exclusive-OR-expression\n"); }
                        | inclusive_OR_expression BITWISE_OR exclusive_OR_expression
                              { printf("inclusive-OR-expression --> inclusive-OR-expression | exclusive-OR-expression\n"); }
                        ;

logical_AND_expression : inclusive_OR_expression
                             { printf("logical-AND-expression --> inclusive-OR-expression\n"); }
                       | logical_AND_expression LOGICAL_AND inclusive_OR_expression
                             { printf("logical-AND-expression --> logical-AND-expression && inclusive-OR-expression\n"); }
                       ;

logical_OR_expression : logical_AND_expression
                            { printf("logical-OR-expression --> logical-AND-expression\n"); }
                      | logical_OR_expression LOGICAL_OR logical_AND_expression
                            { printf("logical-OR-expression --> logical-OR-expression || logical-AND-expression\n"); }
                      ;

conditional_expression : logical_OR_expression
                             { printf("conditional-expression --> logical-OR-expression\n"); }
                       | logical_OR_expression QUESTION_MARK expression COLON conditional_expression
                             { printf("conditional-expression --> logical-OR-expression ? expression : conditional-expression\n"); }
                       ;

assignment_expression : conditional_expression
                            { printf("assignment-expression --> conditional-expression\n"); }
                      | unary_expression assignment_operator assignment_expression
                            { printf("assignment-expression --> unary-expression assignment-operator assignment-expression\n"); }
                      ;

assignment_operator : ASSIGNMENT
                          { printf("assignment-operator --> =\n"); }
                    | MULTIPLY_ASSIGNMENT
                          { printf("assignment-operator --> *=\n"); }
                    | DIVIDE_ASSIGNMENT
                          { printf("assignment-operator --> /=\n"); }
                    | MODULUS_ASSIGNMENT
                          { printf("assignment-operator --> %%=\n"); }
                    | ADD_ASSIGNMENT
                          { printf("assignment-operator --> +=\n"); }
                    | SUBTRACT_ASSIGNMENT
                          { printf("assignment-operator --> -=\n"); }
                    | LEFT_SHIFT_ASSIGNMENT
                          { printf("assignment-operator --> <<=\n"); }
                    | RIGHT_SHIFT_ASSIGNMENT
                          { printf("assignment-operator --> >>=\n"); }
                    | BITWISE_AND_ASSIGNMENT
                          { printf("assignment-operator --> &=\n"); }
                    | BITWISE_XOR_ASSIGNMENT
                          { printf("assignment-operator --> ^=\n"); }
                    | BITWISE_OR_ASSIGNMENT
                          { printf("assignment-operator --> |=\n"); }
                    ;

expression : assignment_expression
                 { printf("expression --> assignment-expression\n"); }
           | expression COMMA assignment_expression
                 { printf("expression --> expression , assignment-expression\n"); }
           ;

constant_expression : conditional_expression
                          { printf("constant-expression --> conditional-expression\n"); }
                    ;

/* DECLARATIONS */

declaration : declaration_specifiers init_declarator_list_opt SEMICOLON
                 { printf("declaration --> declaration-specifiers init-declarator-list_opt ;\n"); }
            ;

init_declarator_list_opt : init_declarator_list
                               { printf("init-declarator-list_opt --> init-declarator-list\n"); }
                         | /* epsilon */
                               { printf("init-declarator-list_opt --> epsilon\n"); }
                         ;

declaration_specifiers : storage_class_specifier declaration_specifiers_opt
                             { printf("declaration-specifiers --> storage-class-specifier declaration-specifiers_opt\n"); }
                       | type_specifier declaration_specifiers_opt
                             { printf("declaration-specifiers --> type-specifier declaration-specifiers_opt\n"); }
                       | type_qualifier declaration_specifiers_opt
                             { printf("declaration-specifiers --> type-qualifier declaration-specifiers_opt\n"); }
                       | function_specifier declaration_specifiers_opt
                             { printf("declaration-specifiers --> function-specifier declaration-specifiers_opt\n"); }
                       ;

declaration_specifiers_opt : declaration_specifiers
                                 { printf("declaration-specifiers_opt --> declaration-specifiers\n"); }
                           | /* epsilon */
                                 { printf("declaration-specifiers_opt --> epsilon\n"); }
                           ;

init_declarator_list : init_declarator
                          { printf("init-declarator-list --> init-declarator\n"); }
                     | init_declarator_list COMMA init_declarator
                          { printf("init-declarator-list --> init-declarator-list , init-declarator\n"); }
                     ;

init_declarator : declarator
                     { printf("init-declarator --> declarator\n"); }
                | declarator ASSIGNMENT initializer
                     { printf("init-declarator --> declarator = initializer\n"); }
                ;

storage_class_specifier : EXTERN
                              { printf("storage-class-specifier --> extern\n"); }
                        | STATIC
                              { printf("storage-class-specifier --> static\n"); }
                        | AUTO
                              { printf("storage-class-specifier --> auto\n"); }
                        | REGISTER
                              { printf("storage-class-specifier --> register\n"); }
                        ;

type_specifier : VOID
                     { printf("type-specifier --> void\n"); }
               | CHAR
                     { printf("type-specifier --> char\n"); }
               | SHORT
                     { printf("type-specifier --> short\n"); }
               | INT
                     { printf("type-specifier --> int\n"); }
               | LONG
                     { printf("type-specifier --> long\n"); }
               | FLOAT
                     { printf("type-specifier --> float\n"); }
               | DOUBLE
                     { printf("type-specifier --> double\n"); }
               | SIGNED
                     { printf("type-specifier --> signed\n"); }
               | UNSIGNED
                     { printf("type-specifier --> unsigned\n"); }
               | _BOOL
                     { printf("type-specifier --> _Bool\n"); }
               | _COMPLEX
                     { printf("type-specifier --> _Complex\n"); }
               | _IMAGINARY
                     { printf("type-specifier --> _Imaginary\n"); }
               | enum_specifier
                     { printf("type-specifier --> enum-specifier\n"); }
               ;

specifier_qualifier_list : type_specifier specifier_qualifier_list_opt
                              { printf("specifier-qualifier-list --> type-specifier specifier-qualifier-list_opt\n"); }
                         | type_qualifier specifier_qualifier_list_opt
                              { printf("specifier-qualifier-list --> type-qualifier specifier-qualifier-list_opt\n"); }
                         ;

specifier_qualifier_list_opt : specifier_qualifier_list
                                  { printf("specifier-qualifier-list_opt --> specifier-qualifier-list\n"); }
                             | /* epsilon */
                                  { printf("specifier-qualifier-list_opt --> epsilon\n"); }
                             ;

enum_specifier : ENUM identifier_opt CURLY_BRACKET_OPEN enumerator_list CURLY_BRACKET_CLOSE
                     { printf("enum-specifier --> enum identifier_opt { enumerator-list }\n"); }
               | ENUM identifier_opt CURLY_BRACKET_OPEN enumerator_list COMMA CURLY_BRACKET_CLOSE
                     { printf("enum-specifier --> enum identifier_opt { enumerator-list , }\n"); }
               | ENUM IDENTIFIER
                     { printf("enum-specifier --> enum identifier\n"); }
               ;

identifier_opt : IDENTIFIER
                    { printf("identifier_opt --> identifier\n"); }
               | /* epsilon */
                    { printf("identifier_opt --> epsilon\n"); }
               ;

enumerator_list : enumerator
                     { printf("enumerator-list --> enumerator\n"); }
                | enumerator_list COMMA enumerator
                     { printf("enumerator-list --> enumerator-list , enumerator\n"); }
                ;

enumerator : IDENTIFIER
                 { printf("enumerator --> enumeration-constant\n"); }
           | IDENTIFIER ASSIGNMENT constant_expression
                 { printf("enumerator --> enumeration-constant = constant-expression\n"); }
           ;

type_qualifier : CONST
                     { printf("type-qualifier --> const\n"); }
               | RESTRICT
                     { printf("type-qualifier --> restrict\n"); }
               | VOLATILE
                     { printf("type-qualifier --> volatile\n"); }
               ;

function_specifier : INLINE
                        { printf("function-specifier --> inline\n"); }
                   ;

declarator : pointer_opt direct_declarator
                 { printf("declarator --> pointer_opt direct-declarator\n"); }
           ;

pointer_opt : pointer
                 { printf("pointer_opt --> pointer\n"); }
            | /* epsilon */
                 { printf("pointer_opt --> epsilon\n"); }
            ;

direct_declarator : IDENTIFIER
                       { printf("direct-declarator --> identifier\n"); }
                  | ROUND_BRACKET_OPEN declarator ROUND_BRACKET_CLOSE
                       { printf("direct-declarator --> ( declarator )\n"); }
                  | direct_declarator SQUARE_BRACKET_OPEN type_qualifier_list_opt assignment_expression_opt SQUARE_BRACKET_CLOSE
                       { printf("direct-declarator --> direct-declarator [ type-qualifier-list_opt assignment-expression_opt ]\n"); }
                  | direct_declarator SQUARE_BRACKET_OPEN STATIC type_qualifier_list_opt assignment_expression SQUARE_BRACKET_CLOSE
                       { printf("direct-declarator --> direct-declarator [ static type-qualifier-list_opt assignment-expression ]\n"); }
                  | direct_declarator SQUARE_BRACKET_OPEN type_qualifier_list STATIC assignment_expression SQUARE_BRACKET_CLOSE
                       { printf("direct-declarator --> direct-declarator [ type-qualifier-list static assignment-expression ]\n"); }
                  | direct_declarator SQUARE_BRACKET_OPEN type_qualifier_list_opt MULTIPLY SQUARE_BRACKET_CLOSE
                       { printf("direct-declarator --> direct-declarator [ type-qualifier-list_opt * ]\n"); }
                  | direct_declarator ROUND_BRACKET_OPEN parameter_type_list ROUND_BRACKET_CLOSE
                       { printf("direct-declarator --> direct-declarator ( parameter-type-list )\n"); }
                  | direct_declarator ROUND_BRACKET_OPEN identifier_list_opt ROUND_BRACKET_CLOSE
                       { printf("direct-declarator --> direct-declarator ( identifier-list_opt )\n"); }
                  ;

type_qualifier_list_opt : type_qualifier_list
                             { printf("type-qualifier-list_opt --> type-qualifier-list\n"); }
                        | /* epsilon */
                             { printf("type-qualifier-list_opt --> epsilon\n"); }
                        ;

assignment_expression_opt : assignment_expression
                               { printf("assignment-expression_opt --> assignment-expression\n"); }
                          | /* epsilon */
                               { printf("assignment-expression_opt --> epsilon\n"); }
                          ;

identifier_list_opt : identifier_list
                         { printf("identifier-list_opt --> identifier-list\n"); }
                    | /* epsilon */
                         { printf("identifier-list_opt --> epsilon\n"); }
                    ;

pointer : MULTIPLY type_qualifier_list_opt
             { printf("pointer --> * type-qualifier-list_opt\n"); }
        | MULTIPLY type_qualifier_list_opt pointer
             { printf("pointer --> * type-qualifier-list_opt pointer\n"); }
        ;

type_qualifier_list : type_qualifier
                         { printf("type-qualifier-list --> type-qualifier\n"); }
                    | type_qualifier_list type_qualifier
                         { printf("type-qualifier-list --> type-qualifier-list type-qualifier\n"); }
                    ;

parameter_type_list : parameter_declaration
                          { printf("parameter-type-list --> parameter-declaration\n"); }
                    | parameter_list COMMA parameter_declaration
                          { printf("parameter-type-list --> parameter-list , parameter-declaration\n"); }
                    ;

parameter_list : parameter_declaration
                    { printf("parameter-list --> parameter-declaration\n"); }
               | parameter_list COMMA parameter_declaration
                    { printf("parameter-list --> parameter-list , parameter-declaration\n"); }
               ;

parameter_declaration : declaration_specifiers declarator
                           { printf("parameter-declaration --> declaration-specifiers declarator\n"); }
                      | declaration_specifiers
                           { printf("parameter-declaration --> declaration-specifiers\n"); }
                      ;

identifier_list : IDENTIFIER
                      { printf("identifier-list --> identifier\n"); }
                | identifier_list COMMA IDENTIFIER
                      { printf("identifier-list --> identifier-list , identifier\n"); }
                ;

type_name : specifier_qualifier_list
                { printf("type-name --> specifier-qualifier-list\n"); }
          ;

initializer : assignment_expression
                  { printf("initializer --> assignment-expression\n"); }
            | CURLY_BRACKET_OPEN initializer_list CURLY_BRACKET_CLOSE
                  { printf("initializer --> { initializer-list }\n"); }
            | CURLY_BRACKET_OPEN initializer_list COMMA CURLY_BRACKET_CLOSE
                  { printf("initializer --> { initializer-list , }\n"); }
            ;

initializer_list : designation_opt initializer
                       { printf("initializer-list --> designation_opt initializer\n"); }
                 | initializer_list COMMA designation_opt initializer
                       { printf("initializer-list --> initializer-list , designation_opt initializer\n"); }
                 ;

designation_opt : designation
                      { printf("designation_opt --> designation\n"); }
                | /* epsilon */
                      { printf("designation_opt --> epsilon\n"); }

designation : designator_list ASSIGNMENT
                  { printf("designation --> designator-list =\n"); }
            ;

designator_list : designator
                      { printf("designator-list --> designator\n"); }
                | designator_list designator
                      { printf("designator-list --> designator-list designator\n"); }
                ;

designator : SQUARE_BRACKET_OPEN constant_expression SQUARE_BRACKET_CLOSE
                { printf("designator --> [ constant-expression ]\n"); }
           | DOT IDENTIFIER
                { printf("designator --> . identifier\n"); }
           ;

/* STATEMENTS */

statement : labeled_statement
                { printf("statement --> labeled-statement\n"); }
          | compound_statement
                { printf("statement --> compound-statement\n"); }
          | expression_statement
                { printf("statement --> expression-statement\n"); }
          | selection_statement
                { printf("statement --> selection-statement\n"); }
          | iteration_statement
                { printf("statement --> iteration-statement\n"); }
          | jump_statement
                { printf("statement --> jump-statement\n"); }
          ;

labeled_statement : IDENTIFIER COLON statement
                        { printf("labeled-statement --> identifier : statement\n"); }
                  | CASE constant_expression COLON statement
                        { printf("labeled-statement --> case constant-expression : statement\n"); }
                  | DEFAULT COLON statement
                        { printf("labeled-statement --> default : statement\n"); }
                  ;

compound_statement : CURLY_BRACKET_OPEN block_item_list_opt CURLY_BRACKET_CLOSE
                        { printf("compound-statement --> { block-item-list_opt }\n"); }
                   ;

block_item_list_opt : block_item_list
                         { printf("block-item-list_opt --> block-item-list\n"); }
                    | /* epsilon */
                         { printf("block-item-list_opt --> epsilon\n"); }
                    ;

block_item_list : block_item
                     { printf("block-item-list --> block-item\n"); }
                | block_item_list block_item
                     { printf("block-item-list --> block-item-list block-item\n"); }
                ;

block_item : declaration
                 { printf("block-item --> declaration\n"); }
           | statement
                 { printf("block-item --> statement\n"); }
           ;

expression_statement : expression_opt SEMICOLON
                           { printf("expression-statement --> expression_opt ;\n"); }
                     ;

expression_opt : expression
                     { printf("expression_opt --> expression\n"); }
               | /* epsilon */
                     { printf("expression_opt --> epsilon\n"); }
               ;

selection_statement : IF ROUND_BRACKET_OPEN expression ROUND_BRACKET_CLOSE statement
                           { printf("selection-statement --> if ( expression ) statement\n"); }
                    | IF ROUND_BRACKET_OPEN expression ROUND_BRACKET_CLOSE statement ELSE statement
                           { printf("selection-statement --> if ( expression ) statement else statement\n"); }
                    | SWITCH ROUND_BRACKET_OPEN expression ROUND_BRACKET_CLOSE statement
                           { printf("selection-statement --> switch ( expression ) statement\n"); }
                    ;

iteration_statement : WHILE ROUND_BRACKET_OPEN expression ROUND_BRACKET_CLOSE statement
                          { printf("iteration-statement --> while ( expression ) statement\n"); }
                    | DO statement WHILE ROUND_BRACKET_OPEN expression ROUND_BRACKET_CLOSE SEMICOLON
                          { printf("iteration-statement --> do statement while ( expression ) ;\n"); }
                    | FOR ROUND_BRACKET_OPEN expression_opt SEMICOLON expression_opt SEMICOLON expression_opt ROUND_BRACKET_CLOSE statement
                          { printf("iteration-statement --> for ( expression_opt ; expression_opt ; expression_opt ) statement\n"); }
                    | FOR ROUND_BRACKET_OPEN declaration expression_opt SEMICOLON expression_opt ROUND_BRACKET_CLOSE statement
                          { printf("iteration-statement --> for ( declaration expression_opt ; expression_opt ) statement\n"); }
                    ;

jump_statement : GOTO IDENTIFIER SEMICOLON
                     { printf("jump-statement --> goto identifier ;\n"); }
               | CONTINUE SEMICOLON
                     { printf("jump-statement --> continue ;\n"); }
               | BREAK SEMICOLON
                     { printf("jump-statement --> break ;\n"); }
               | RETURN expression_opt SEMICOLON
                     { printf("jump-statement --> return expression_opt ;\n"); }
               ;

/* EXTERNAL DEFINITIONS */

translation_unit : external_declaration
                       { printf("translation-unit --> external-declaration\n"); }
                 | translation_unit external_declaration
                       { printf("translation-unit --> translation-unit external-declaration\n"); }
                 ;

external_declaration : function_definition
                           { printf("external-declaration --> function-definition\n"); }
                     | declaration
                           { printf("external-declaration --> declaration\n"); }
                     ;

function_definition : declaration_specifiers declarator declaration_list_opt compound_statement
                          { printf("function-definition --> declaration-specifiers declarator declaration-list_opt compound-statement\n"); }
                    ;

declaration_list_opt : declaration_list
                           { printf("declaration-list_opt --> declaration-list\n"); }
                     | /* epsilon */
                           { printf("declaration-list_opt --> epsilon\n"); }

declaration_list : declaration
                        { printf("declaration-list --> declaration\n"); }
                 | declaration_list declaration
                        { printf("declaration-list --> declaration-list declaration\n"); }
                 ;

%%

void yyerror(const char *s) {
    std::cout << "Error: " << s << std::endl;
    std::cout << "Line: " << yylineno << std::endl;
    std::cout << "Token: " << yytext << std::endl;
}