CC = gcc

LEX = flex
LEXER = MyLang.l
BISON = bison
PARSER = MyLang.y
ANALYZER = Parser
BUILDDIR = Build
MAIN = MyLang.c


build: $(BUILDDIR)/$(ANALYZER)

$(BUILDDIR)/$(ANALYZER):
	cp src/MyLang* $(BUILDDIR)
	$(BISON) -ydv -Wcounterexamples -Wno-yacc $(BUILDDIR)/$(PARSER) -o $(BUILDDIR)/y.tab.c
	$(LEX) -o $(BUILDDIR)/lex.yy.c $(BUILDDIR)/$(LEXER)
	$(CC) $(SRC) $(BUILDDIR)/lex.yy.c $(BUILDDIR)/y.tab.c $(BUILDDIR)/$(MAIN) -o $(BUILDDIR)/$(ANALYZER)
	rm -f $(BUILDDIR)/MyLang*


clean:
	rm -f $(BUILDDIR)/lex.yy.c $(BUILDDIR)/y.* $(BUILDDIR)/$(ANALYZER)


test:
	$(BUILDDIR)/$(ANALYZER) src/Test.mlng
