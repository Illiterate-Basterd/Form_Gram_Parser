%{
    #include "y.tab.h"
    void yyerror(char *str);
%}

%option yylineno
%option noyywrap

%x STR
%x MULTICOM

%%
[/][/].*                ; //comment

if                      return IF;

else                    return ELSE; 

while                   return WHILE;

for                     return FOR;

do                      return DO;

==                      return EQ; 

>=                      return GE; 

&&                      return AND; 

=                       return ASSIGN; 

\|\|                    return OR; 

%                       return DIV; 

return                  return RETURN; 

print                   return PRINT; 

int                     return INT;

bool                    return BOOL;

char                    return CHAR;

float                   return FLOAT;

void                    return VOID;

"<="                    return LE; 

!=                      return NE; 

[0-9]+                  {   
                            yylval = yytext;
                            return NUM;
                        }
                        

[a-zA-Z_][a-zA-Z0-9_]*  {   
                            yylval = yytext;
                            return ID;
                        }

<INITIAL>"/*"          BEGIN(MULTICOM);
<MULTICOM>"*/"         BEGIN(INITIAL);
<MULTICOM>"\n"         ;
<MULTICOM>.            ;                        

<INITIAL>["]            {   
                            yylval = "";
                            BEGIN(STR);
                        }
                        
<STR>[^\\\n"]           yylval += yytext; 
<STR>\\n                yylval += '\n'; 
<STR>\\["]              yylval += '\"'; 
<STR>\\                 yyerror("Invalid escape sequence"); 
<STR>\n                 yyerror("Newline in string literal"); 
<STR>["]                BEGIN(INITIAL); return STRING; 

[ \t\r\n]               ; //whitespace
[-;()<>+*/!,{}]           return *yytext; 

.                       yyerror("Invalid character");
%%