prefix ?= /usr/local

GBM_SO_VER ?= no_ver
SRC_DIR = ./src

#CROSS_COMPILE ?= arm-none-linux-gnueabi-
TARGET_CC ?= $(CROSS_COMPILE)gcc
TARGET_AR ?= $(CROSS_COMPILE)ar
CFLAGS += -Wall -ludev -fPIC

#gbm backend sources
GBM_BACKENDS_DIR = $(SRC_DIR)/backends

#gbm backend module location
CFLAGS += -DMODULEDIR='"/usr/lib/gbm"'

#gbm main source
GBM_SRCS +=  \
			$(SRC_DIR)/gbm.c \
			$(SRC_DIR)/common.c \
			$(SRC_DIR)/backend.c

%.o: %.c
	$(TARGET_CC) -c -o $@ $< $(CFLAGS)

GBM_OBJS := $(GBM_SRCS:.c=.o)

libgbm.so.$(GBM_SO_VER): $(GBM_OBJS)
	$(TARGET_CC) -shared -o $@ $(GBM_OBJS) $(CFLAGS)
backend: 
	@for dir in $(GBM_BACKENDS_DIR) ; do \
		$(MAKE) -C $$dir ; \
	done

.DEFAULT_GOAL = all
all: libgbm.so.$(GBM_SO_VER) backend

clean:
	-rm -f $(GBM_OBJS) libgbm.so.$(GBM_SO_VER)
	@for dir in $(GBM_BACKENDS_DIR) ; do \
		$(MAKE) $@ -C $$dir ; \
	done

install: all
	cp $(SRC_DIR)/gbm.h $(prefix)/include/
	-mkdir $(prefix)/include/gbm
#	cp $(SRC_DIR)/gbm.h $(prefix)/include/gbm/
	cp $(SRC_DIR)/backend.h $(prefix)/include/gbm/
	cp $(SRC_DIR)/common_drm.h $(prefix)/include/gbm/
	cp $(SRC_DIR)/common.h $(prefix)/include/gbm/
	cp $(SRC_DIR)/gbmint.h $(prefix)/include/gbm/
	cp pkgconfig/libgbm.pc $(prefix)/lib/pkgconfig/
	cp libgbm.so.$(GBM_SO_VER) $(prefix)/lib/
	@for dir in $(GBM_BACKENDS_DIR) ; do \
		$(MAKE) $@ -C $$dir ; \
	done

uninstall:
	-rm -f $(prefix)/include/gbm.h
	-rm -f $(prefix)/include/gbm/backend.h
	-rm -f $(prefix)/include/gbm/common_drm.h
	-rm -f $(prefix)/include/gbm/common.h
	-rm -f $(prefix)/include/gbm/gbmint.h
	-rm -f $(prefix)/lib/pkgconfig/libgbm.pc
	-rm -f $(prefix)/lib/libgbm.so.$(GBM_SO_VER)
	@for dir in $(GBM_BACKENDS_DIR) ; do \
		$(MAKE) $@ -C $$dir ; \
	done
