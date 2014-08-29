#SUBDIRS = 

default: subdirs

subdirs:
	@for dir in $(SUBDIRS) ; do \
		$(MAKE) -C $$dir ; \
	done

clean:
	@for dir in $(SUBDIRS) ; do \
		$(MAKE) $@ -C $$dir ; \
	done

install: subdirs
	@for dir in $(SUBDIRS) ; do \
		$(MAKE) $@ -C $$dir ; \
	done

uninstall:
	@for dir in $(SUBDIRS) ; do \
		$(MAKE) $@ -C $$dir ; \
	done
