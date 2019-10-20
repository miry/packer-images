SUBDIRS := centos7 kubernetes

.PHONY: all
all: $(SUBDIRS)

.PHONY: build
build: $(SUBDIRS)

.PHONY: clean
clean: $(SUBDIRS)

.PHONY: $(SUBDIRS)
$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)
