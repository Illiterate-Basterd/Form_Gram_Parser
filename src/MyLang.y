%{
    #include "MyLang.h"
    #define YYERROR_VERBOSE 1

    extern int yylineno;
    extern char * yytext;
    extern int yylex();
    extern YYLTYPE yylloc;

    void yyerror(char *s) 
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

%union
{
 int value;
 char str[256];
}

%token <str> ID STRING
%token <value> NUM

%token IF ELSE WHILE FOR DO
%token EQ LE GE AND OR NE
%token DIV
%token RETURN PRINT ASSIGN
%token INT BOOL CHAR FLOAT VOID

%left OR
%left AND

%start PROGRAM

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
    | WHILE '(' EXPR ')' '{' OPS '}'
    | FORSTMNT
    | DO '{' OPS '}' WHILE '(' EXPR ')' ';'
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

EXPR: EXPR0
    | ID ASSIGN ARG

EXPR0: EXPR1
    | EXPR1 AND EXPR0
    | EXPR1 OR EXPR0


EXPR1: EXPR2 
    |  EXPR2 EQ EXPR1 
    |  EXPR2 LE EXPR1 
    |  EXPR2 GE EXPR1 
    |  EXPR2 NE EXPR1 
    |  EXPR2 '>' EXPR1 
    |  EXPR2 '<' EXPR1


EXPR2: TERM 
    |  TERM '+' EXPR2
    |  TERM '-' EXPR2 


TERM: VAL 
    | VAL '*' TERM
    | VAL '/' TERM 
    | VAL DIV TERM 


VAL:  NUM 
    | '-' VAL 
    | '+' VAL 
    | '!' VAL 
    | '(' EXPR ')'
    | STRING
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


RET:  RETURN ';'
    | RETURN '(' ARG ')' ';'


FORSTMNT: FOR '(' FOREXPR1 ';' FOREXPR2 ';' FOREXPR3 ')' OP
%%