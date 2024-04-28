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
	$(BISON) -ydv -Wcounterexamples $(PARSER)
	@echo ---------------------------------------------------------
	$(LEX) $(LEXER)
	@echo ---------------------------------------------------------
	$(CC) $(SRC) -m32 -o $(ANALYZER)

clean:
	rm -f $(SRC) y.tab.h