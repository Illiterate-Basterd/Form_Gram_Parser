%{
    #include "MyLang.h"
    #define YYERROR_VERBOSE 1

    extern int yylineno;
    extern char * yytext;
    extern int yylex();
    extern YYLTYPE yylloc;

    extern void yyerror(char *s) 
    {
        DumpRow();
        PrintError(s);
    }

    #define YY_INPUT(buf,result,max_size)  {\
    result = GetNextChar(buf, max_size); \
    if (  result <= 0  ) \
    	result = YY_NULL; \
    }
%}

%locations

%defines
%define parse.error verbose

%start PROGRAM

%token IF ELSE WHILE FOR DO
%token EQ LE GE AND OR NE
%token DIV
%token STRING NUM ID
%token RETURN PRINT ASSIGN
%token INT BOOL CHAR FLOAT VOID

%%
PROGRAM: 
    | OPS


OPS:  OP 
    | OPS OP


OP:   FUNCBODY
    | EXPR ';'
    | ';' 
    | IF '(' EXPR ')' '{' OPS '}'
    | IF '(' EXPR ')' '{' OPS '}' ELSE '{' OPS '}'
    | WHILE '(' EXPR1 ')' OP
    | FORSTMNT
    | DO OP WHILE '(' EXPR1 ')' ';'
    | RET
    | DECL ';'
    | FUNCDECL
    | error OP


FUNCBODY: '{' '}'
    | '{' OPS '}'


FOREXPR1:
    | ID ASSIGN ARG
    | DECL


FOREXPR2:
    | EXPR1


FOREXPR3:
    | ID ASSIGN EXPR2


DECL: DATATYPE ID
    | DATATYPE ID ASSIGN ARG


FUNCARG: DATATYPE ID

FUNCARGS: FUNCARG
    | FUNCARGS ',' FUNCARG


FUNCDECL: DATATYPE ID '(' FUNCARGS ')' ';'
    | DATATYPE ID '(' ')' ';'
    | DATATYPE ID '(' FUNCARGS ')' FUNCBODY
    | DATATYPE ID '(' ')' FUNCBODY


EXPR: EXPR1 
    | ID ASSIGN ARG   


EXPR1: EXPR2 
    |  EXPR1 EQ EXPR2 
    |  EXPR1 LE EXPR2 
    |  EXPR1 GE EXPR2 
    |  EXPR1 NE EXPR2 
    |  EXPR1 '>' EXPR2 
    |  EXPR1 '<' EXPR2


EXPR2: TERM 
    |  EXPR2 '+' TERM 
    |  EXPR2 '-' TERM 
    |  EXPR2 OR TERM


TERM: VAL 
    | TERM '*' VAL 
    | TERM '/' VAL 
    | TERM DIV VAL 
    | TERM AND VAL


VAL:  NUM 
    | '-' VAL 
    | '+' VAL 
    | '!' VAL 
    | '(' EXPR ')'
    | ID 
    | ID '(' ARGS ')'
    | PRINT '(' ARGS ')'


DATATYPE: INT
    | BOOL
    | CHAR
    | FLOAT
    | VOID


ARGS: 
    | ARG 
    | ARGS ',' ARG


ARG:  EXPR 
    | STRING


RET:  RETURN ';'
    | RETURN '(' ARG ')' ';'


FORSTMNT: FOR '(' FOREXPR1 ';' FOREXPR2 ';' FOREXPR3 ')' OP
%%