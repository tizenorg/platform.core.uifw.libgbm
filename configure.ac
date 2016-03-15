AC_INIT(libgbm, [1.0.0], lsj119@samsung.com)

AC_CONFIG_SRCDIR(configure.ac)
AC_CONFIG_HEADERS([config.h])

AM_INIT_AUTOMAKE(1.6 foreign subdir-objects)
AM_SILENT_RULES([yes])

# Checks for programs.
AC_PROG_CC
AC_PROG_LIBTOOL

AC_ARG_ENABLE(tbm, AS_HELP_STRING([--disable-tbm],           
			       [use tbm or not (default: enabled)]),     
		           [have_tbm=$enableval], [have_tbm=yes]) 

if test x$have_tbm = xyes; then
   PKG_CHECK_MODULES([TBM], [libtbm wayland-tbm-server])
   AC_DEFINE([HAVE_TBM], [1], [Build the tbm backend])

   AC_ARG_ENABLE(tbm-queue, [--enable-tbm-queue],,
                 enable_tbm_queue=no)
   if test x$enable_tbm_queue = xyes; then
      AC_DEFINE([USE_TBM_QUEUE], [1], [Build gbm_tbm with TBM surface queue])
   fi
fi

AM_CONDITIONAL(HAVE_TBM, test "x$have_tbm" = "xyes")
AM_CONDITIONAL(USE_TBM_QUEUE, test x$enable_tbm_queue = xyes)

AC_CONFIG_FILES([
   Makefile
   gbm.pc
])
AC_OUTPUT

