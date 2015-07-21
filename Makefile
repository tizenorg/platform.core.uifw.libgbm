SRC_DIR = ./src

#CROSS_COMPILE ?= arm-none-linux-gnueabi-
TARGET_CC ?= $(CROSS_COMPILE)gcc
TARGET_AR ?= $(CROSS_COMPILE)ar
CFLAGS += -Wall -ludev -fPIC

#gbm backend sources
GBM_BACKENDS_DIR = $(SRC_DIR)/backends

#gbm backend module location
CFLAGS += -DMODULEDIR='"$(libdir)/gbm"'

#gbm main source
GBM_SRCS +=  \
			$(SRC_DIR)/gbm.c \
			$(SRC_DIR)/common.c \
			$(SRC_DIR)/backend.c

%.o: %.c
	$(TARGET_CC) -c -o $@ $< $(CFLAGS)

GBM_OBJS := $(GBM_SRCS:.c=.o)

libgbm.so: $(GBM_OBJS)
	$(TARGET_CC) -shared -o $@ $(GBM_OBJS) $(CFLAGS)
backend: 
	@for dir in $(GBM_BACKENDS_DIR) ; do \
		$(MAKE) -C $$dir ; \
	done

.DEFAULT_GOAL = all
all: libgbm.so backend

clean:
	-rm -f $(GBM_OBJS) libgbm.so
	@for dir in $(GBM_BACKENDS_DIR) ; do \
		$(MAKE) $@ -C $$dir ; \
	done

install: all
	cp $(SRC_DIR)/gbm.h $(includedir)/
	-mkdir $(includedir)/gbm/
	cp $(SRC_DIR)/backend.h $(includedir)/gbm/
	cp $(SRC_DIR)/common_drm.h $(includedir)/gbm/
	cp $(SRC_DIR)/common.h $(includedir)/gbm/
	cp $(SRC_DIR)/gbmint.h $(includedir)/gbm/
	cp pkgconfig/gbm.pc $(libdir)/pkgconfig/
	cp libgbm.so $(libdir)/
	@for dir in $(GBM_BACKENDS_DIR) ; do \
		$(MAKE) $@ -C $$dir ; \
	done

uninstall:
	-rm -f $(includedir)/gbm.h
	-rm -f $(includedir)/gbm/backend.h
	-rm -f $(includedir)/gbm/common_drm.h
	-rm -f $(includedir)/gbm/common.h
	-rm -f $(includedir)/gbm/gbmint.h
	-rm -f $(libdir)/pkgconfig/gbm.pc
	-rm -f $(libdir)/libgbm.so
	@for dir in $(GBM_BACKENDS_DIR) ; do \
		$(MAKE) $@ -C $$dir ; \
	done
