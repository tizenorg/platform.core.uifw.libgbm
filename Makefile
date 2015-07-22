SRC_DIR = ./src
SO_NAME = libgbm.so.$(major_ver)
BIN_NAME = $(SO_NAME).$(minor_ver)

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

$(BIN_NAME): $(GBM_OBJS)
	$(TARGET_CC) -shared -Wl,-soname,$(SO_NAME) -o $@ $(GBM_OBJS) $(CFLAGS)
backend: 
	@for dir in $(GBM_BACKENDS_DIR) ; do \
		$(MAKE) -C $$dir ; \
	done

.DEFAULT_GOAL = all
all: $(BIN_NAME) backend

clean:
	-rm -f $(GBM_OBJS) $(BIN_NAME)
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
	cp $(BIN_NAME) $(libdir)/
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
	-rm -f $(libdir)/$(BIN_NAME)
	@for dir in $(GBM_BACKENDS_DIR) ; do \
		$(MAKE) $@ -C $$dir ; \
	done
