CC = gcc

LEX = flex
LEXER = MyLang.l
BISON = bison
PARSER = MyLang.y
SRC = lex.yy.c y.tab.c
ANALYZER = Parser


all: clean build

build:
	@echo ---------------------------------------------------------
	$(BISON) -ydv -Wcounterexamples -Wno-yacc $(PARSER)
	@echo ---------------------------------------------------------
	$(LEX) $(LEXER)
	@echo ---------------------------------------------------------
	$(CC) $(SRC) MyLang.c -m32 -o $(ANALYZER)

clean:
	rm -f $(SRC) y.tab.h