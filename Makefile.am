pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = gbm.pc

AM_CFLAGS = \
	-D_OS_UNIX=1 \
	-DMODULEDIR='"$(libdir)/gbm"' \
	-I$(top_srcdir)/src 

lib_LTLIBRARIES = libgbm.la
include_HEADERS = src/gbm.h

libgbm_la_SOURCES = \
	src/backend.c \
	src/backend.h \
	src/gbm.c \
	src/gbm.h \
	src/gbmint.h

libgbm_la_LDFLAGS = \
	-no-undefined \
	-version-info 1:0

libgbm_la_LIBADD = 

libgbmincludedir=$(includedir)
libgbminclude_HEADERS = \
	src/gbm.h \
	src/gbmint.h

if HAVE_TBM
libgbm_la_SOURCES += \
	backends/tbm/gbm_tbm.c \
	backends/tbm/gbm_tbmint.h

AM_CFLAGS += \
	$(TBM_CFALGS)

libgbm_la_LIBADD += \
	$(TBM_LIBS)

endif

libgbmtbmincludedir=$(includedir)/gbm
libgbmtbminclude_HEADERS = \
	backends/tbm/gbm_tbm.h \
	backends/tbm/gbm_tbmint.h


CLEANFILES = 
