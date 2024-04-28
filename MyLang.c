#include "MyLang.h"

extern int err;

int main(void)
{
    yyparse();
    if(!err)
    {
        printf("Success!\n");
        return 0;
    }
    exit(1);
}