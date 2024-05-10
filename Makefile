CC = gcc

LEX = flex
LEXER = MyLang.l
BISON = bison
PARSER = MyLang.y
ANALYZER = Parser
BUILDDIR = build
MAIN = MyLang.c


build: $(BUILDDIR)/$(ANALYZER)

$(BUILDDIR)/$(ANALYZER):
	mkdir -v $(BUILDDIR)
	cp src/MyLang* $(BUILDDIR)
	$(BISON) -ydv -Wcounterexamples -Wno-yacc $(BUILDDIR)/$(PARSER) -o $(BUILDDIR)/y.tab.c
	$(LEX) -o $(BUILDDIR)/lex.yy.c $(BUILDDIR)/$(LEXER)
	$(CC) $(BUILDDIR)/lex.yy.c $(BUILDDIR)/y.tab.c $(BUILDDIR)/$(MAIN) -o $(BUILDDIR)/$(ANALYZER)
	rm -f $(BUILDDIR)/MyLang*


clean:
	rm -rf $(BUILDDIR)


test:
	$(BUILDDIR)/$(ANALYZER) src/Test.mlng
