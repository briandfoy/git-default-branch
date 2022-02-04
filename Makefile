GIT_CMD_DIR=$(shell git --exec-path)
MANDIR=/usr/local/share/man/man1
PANDOC=pandoc
PERL=perl
SCRIPT=git-default-branch
INSTALL=install

.PHONY: install
install: $(SCRIPT).1
	$(INSTALL) $(SCRIPT) $(GIT_CMD_DIR)/$(SCRIPT).1
	$(INSTALL) -m 444 $(SCRIPT).1 $(MANDIR)/$(SCRIPT).1

$(SCRIPT).1: $(SCRIPT).1.md
	$(PANDOC) --standalone --to man $(SCRIPT).1.md -o $(SCRIPT).1

$(SCRIPT).1.md: $(SCRIPT)
	perl -ne 'next unless /\A__DATA__\Z/; last } while(<>) { print' $(SCRIPT) > $@
