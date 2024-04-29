%{
    #include "MyLang.h"

    #define YY_INPUT(buf,result,max_size)  {\
    result = GetNextChar(buf, max_size); \
    if (  result <= 0  ) \
      result = YY_NULL; \
    }
%}

%option yylineno
%option noyywrap

%x STR
%x MULTICOM

%%
[/][/].*                 BeginToken(yytext); // comment

if                      { BeginToken(yytext); return IF; }

else                    { BeginToken(yytext); return ELSE; }

while                   { BeginToken(yytext); return WHILE; }

for                     { BeginToken(yytext); return FOR; }

do                      { BeginToken(yytext); return DO; }

==                      { BeginToken(yytext); return EQ; }

>=                      { BeginToken(yytext); return GE; }

&&                      { BeginToken(yytext); return AND; }

=                       { BeginToken(yytext); return ASSIGN; }

\|\|                    { BeginToken(yytext); return OR; }

%                       { BeginToken(yytext); return DIV; }

return                  { BeginToken(yytext); return RETURN; }

print                   { BeginToken(yytext); return PRINT; }

int                     { BeginToken(yytext); return INT; }

bool                    { BeginToken(yytext); return BOOL; }

char                    { BeginToken(yytext); return CHAR; }

float                   { BeginToken(yytext); return FLOAT; }

void                    { BeginToken(yytext); return VOID; }

"<="                    { BeginToken(yytext); return LE; }

!=                      { BeginToken(yytext); return NE; }

[0-9]+                  {   
                            BeginToken(yytext);
                            yylval = yytext;
                            return NUM;
                        }
                        

[a-zA-Z_][a-zA-Z0-9_]*  { 
                            BeginToken(yytext);  
                            yylval = yytext;
                            return ID;
                        }

<INITIAL>"/*"          { BeginToken(yytext); BEGIN(MULTICOM); }
<MULTICOM>"*/"         { BeginToken(yytext); BEGIN(INITIAL); }
<MULTICOM>"\n"         BeginToken(yytext);
<MULTICOM>.            BeginToken(yytext);                        

<INITIAL>["]            {   
                            BeginToken(yytext);
                            yylval = "";
                            BEGIN(STR);
                        }
                        
<STR>[^\\\n"]           { BeginToken(yytext); yylval += yytext; }
<STR>\\n                { BeginToken(yytext); yylval += '\n'; }
<STR>\\["]              { BeginToken(yytext); yylval += '\"'; }
<STR>\\                 { BeginToken(yytext); } 
<STR>\n                 { BeginToken(yytext); } 
<STR>["]                { BeginToken(yytext); BEGIN(INITIAL); return STRING; }

[ \t\r\n]               BeginToken(yytext); //whitespace
[-;()<>+*/!,{}]         { BeginToken(yytext); return *yytext; } 

.                       {BeginToken(yytext); return *yytext; }
%%