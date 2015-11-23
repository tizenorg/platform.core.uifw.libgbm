AC_INIT(libgbm, [1.0.0], lsj119@samsung.com)

AC_CONFIG_SRCDIR(configure.ac)
AC_CONFIG_HEADERS([config.h])

AM_INIT_AUTOMAKE(1.6 foreign subdir-objects)
AM_SILENT_RULES([yes])

# Checks for programs.
AC_PROG_CC
AC_PROG_LIBTOOL

PKG_CHECK_MODULES([TBM], [libtbm wayland-tbm-server], [have_tbm=yes], [have_tbm=no])
if test x$have_tbm = xyes; then
   AC_DEFINE([HAVE_TBM], [1], [Build the tbm backend])
fi

AM_CONDITIONAL(HAVE_TBM, test "x$have_tbm" = "xyes")
AC_CONFIG_FILES([
   Makefile
   gbm.pc
])
AC_OUTPUT

