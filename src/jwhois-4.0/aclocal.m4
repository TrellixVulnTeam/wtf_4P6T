# generated automatically by aclocal 1.9.6 -*- Autoconf -*-

# Copyright (C) 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004,
# 2005  Free Software Foundation, Inc.
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE.

# gettext.m4 serial 59 (gettext-0.16.1)
dnl Copyright (C) 1995-2006 Free Software Foundation, Inc.
dnl This file is free software; the Free Software Foundation
dnl gives unlimited permission to copy and/or distribute it,
dnl with or without modifications, as long as this notice is preserved.
dnl
dnl This file can can be used in projects which are not available under
dnl the GNU General Public License or the GNU Library General Public
dnl License but which still want to provide support for the GNU gettext
dnl functionality.
dnl Please note that the actual code of the GNU gettext library is covered
dnl by the GNU Library General Public License, and the rest of the GNU
dnl gettext package package is covered by the GNU General Public License.
dnl They are *not* in the public domain.

dnl Authors:
dnl   Ulrich Drepper <drepper@cygnus.com>, 1995-2000.
dnl   Bruno Haible <haible@clisp.cons.org>, 2000-2006.

dnl Macro to add for using GNU gettext.

dnl Usage: AM_GNU_GETTEXT([INTLSYMBOL], [NEEDSYMBOL], [INTLDIR]).
dnl INTLSYMBOL can be one of 'external', 'no-libtool', 'use-libtool'. The
dnl    default (if it is not specified or empty) is 'no-libtool'.
dnl    INTLSYMBOL should be 'external' for packages with no intl directory,
dnl    and 'no-libtool' or 'use-libtool' for packages with an intl directory.
dnl    If INTLSYMBOL is 'use-libtool', then a libtool library
dnl    $(top_builddir)/intl/libintl.la will be created (shared and/or static,
dnl    depending on --{enable,disable}-{shared,static} and on the presence of
dnl    AM-DISABLE-SHARED). If INTLSYMBOL is 'no-libtool', a static library
dnl    $(top_builddir)/intl/libintl.a will be created.
dnl If NEEDSYMBOL is specified and is 'need-ngettext', then GNU gettext
dnl    implementations (in libc or libintl) without the ngettext() function
dnl    will be ignored.  If NEEDSYMBOL is specified and is
dnl    'need-formatstring-macros', then GNU gettext implementations that don't
dnl    support the ISO C 99 <inttypes.h> formatstring macros will be ignored.
dnl INTLDIR is used to find the intl libraries.  If empty,
dnl    the value `$(top_builddir)/intl/' is used.
dnl
dnl The result of the configuration is one of three cases:
dnl 1) GNU gettext, as included in the intl subdirectory, will be compiled
dnl    and used.
dnl    Catalog format: GNU --> install in $(datadir)
dnl    Catalog extension: .mo after installation, .gmo in source tree
dnl 2) GNU gettext has been found in the system's C library.
dnl    Catalog format: GNU --> install in $(datadir)
dnl    Catalog extension: .mo after installation, .gmo in source tree
dnl 3) No internationalization, always use English msgid.
dnl    Catalog format: none
dnl    Catalog extension: none
dnl If INTLSYMBOL is 'external', only cases 2 and 3 can occur.
dnl The use of .gmo is historical (it was needed to avoid overwriting the
dnl GNU format catalogs when building on a platform with an X/Open gettext),
dnl but we keep it in order not to force irrelevant filename changes on the
dnl maintainers.
dnl
AC_DEFUN([AM_GNU_GETTEXT],
[
  dnl Argument checking.
  ifelse([$1], [], , [ifelse([$1], [external], , [ifelse([$1], [no-libtool], , [ifelse([$1], [use-libtool], ,
    [errprint([ERROR: invalid first argument to AM_GNU_GETTEXT
])])])])])
  ifelse([$2], [], , [ifelse([$2], [need-ngettext], , [ifelse([$2], [need-formatstring-macros], ,
    [errprint([ERROR: invalid second argument to AM_GNU_GETTEXT
])])])])
  define([gt_included_intl],
    ifelse([$1], [external],
      ifdef([AM_GNU_GETTEXT_][INTL_SUBDIR], [yes], [no]),
      [yes]))
  define([gt_libtool_suffix_prefix], ifelse([$1], [use-libtool], [l], []))
  gt_NEEDS_INIT
  AM_GNU_GETTEXT_NEED([$2])

  AC_REQUIRE([AM_PO_SUBDIRS])dnl
  ifelse(gt_included_intl, yes, [
    AC_REQUIRE([AM_INTL_SUBDIR])dnl
  ])

  dnl Prerequisites of AC_LIB_LINKFLAGS_BODY.
  AC_REQUIRE([AC_LIB_PREPARE_PREFIX])
  AC_REQUIRE([AC_LIB_RPATH])

  dnl Sometimes libintl requires libiconv, so first search for libiconv.
  dnl Ideally we would do this search only after the
  dnl      if test "$USE_NLS" = "yes"; then
  dnl        if { eval "gt_val=\$$gt_func_gnugettext_libc"; test "$gt_val" != "yes"; }; then
  dnl tests. But if configure.in invokes AM_ICONV after AM_GNU_GETTEXT
  dnl the configure script would need to contain the same shell code
  dnl again, outside any 'if'. There are two solutions:
  dnl - Invoke AM_ICONV_LINKFLAGS_BODY here, outside any 'if'.
  dnl - Control the expansions in more detail using AC_PROVIDE_IFELSE.
  dnl Since AC_PROVIDE_IFELSE is only in autoconf >= 2.52 and not
  dnl documented, we avoid it.
  ifelse(gt_included_intl, yes, , [
    AC_REQUIRE([AM_ICONV_LINKFLAGS_BODY])
  ])

  dnl Sometimes, on MacOS X, libintl requires linking with CoreFoundation.
  gt_INTL_MACOSX

  dnl Set USE_NLS.
  AC_REQUIRE([AM_NLS])

  ifelse(gt_included_intl, yes, [
    BUILD_INCLUDED_LIBINTL=no
    USE_INCLUDED_LIBINTL=no
  ])
  LIBINTL=
  LTLIBINTL=
  POSUB=

  dnl Add a version number to the cache macros.
  case " $gt_needs " in
    *" need-formatstring-macros "*) gt_api_version=3 ;;
    *" need-ngettext "*) gt_api_version=2 ;;
    *) gt_api_version=1 ;;
  esac
  gt_func_gnugettext_libc="gt_cv_func_gnugettext${gt_api_version}_libc"
  gt_func_gnugettext_libintl="gt_cv_func_gnugettext${gt_api_version}_libintl"

  dnl If we use NLS figure out what method
  if test "$USE_NLS" = "yes"; then
    gt_use_preinstalled_gnugettext=no
    ifelse(gt_included_intl, yes, [
      AC_MSG_CHECKING([whether included gettext is requested])
      AC_ARG_WITH(included-gettext,
        [  --with-included-gettext use the GNU gettext library included here],
        nls_cv_force_use_gnu_gettext=$withval,
        nls_cv_force_use_gnu_gettext=no)
      AC_MSG_RESULT($nls_cv_force_use_gnu_gettext)

      nls_cv_use_gnu_gettext="$nls_cv_force_use_gnu_gettext"
      if test "$nls_cv_force_use_gnu_gettext" != "yes"; then
    ])
        dnl User does not insist on using GNU NLS library.  Figure out what
        dnl to use.  If GNU gettext is available we use this.  Else we have
        dnl to fall back to GNU NLS library.

        if test $gt_api_version -ge 3; then
          gt_revision_test_code='
#ifndef __GNU_GETTEXT_SUPPORTED_REVISION
#define __GNU_GETTEXT_SUPPORTED_REVISION(major) ((major) == 0 ? 0 : -1)
#endif
changequote(,)dnl
typedef int array [2 * (__GNU_GETTEXT_SUPPORTED_REVISION(0) >= 1) - 1];
changequote([,])dnl
'
        else
          gt_revision_test_code=
        fi
        if test $gt_api_version -ge 2; then
          gt_expression_test_code=' + * ngettext ("", "", 0)'
        else
          gt_expression_test_code=
        fi

        AC_CACHE_CHECK([for GNU gettext in libc], [$gt_func_gnugettext_libc],
         [AC_TRY_LINK([#include <libintl.h>
$gt_revision_test_code
extern int _nl_msg_cat_cntr;
extern int *_nl_domain_bindings;],
            [bindtextdomain ("", "");
return * gettext ("")$gt_expression_test_code + _nl_msg_cat_cntr + *_nl_domain_bindings],
            [eval "$gt_func_gnugettext_libc=yes"],
            [eval "$gt_func_gnugettext_libc=no"])])

        if { eval "gt_val=\$$gt_func_gnugettext_libc"; test "$gt_val" != "yes"; }; then
          dnl Sometimes libintl requires libiconv, so first search for libiconv.
          ifelse(gt_included_intl, yes, , [
            AM_ICONV_LINK
          ])
          dnl Search for libintl and define LIBINTL, LTLIBINTL and INCINTL
          dnl accordingly. Don't use AC_LIB_LINKFLAGS_BODY([intl],[iconv])
          dnl because that would add "-liconv" to LIBINTL and LTLIBINTL
          dnl even if libiconv doesn't exist.
          AC_LIB_LINKFLAGS_BODY([intl])
          AC_CACHE_CHECK([for GNU gettext in libintl],
            [$gt_func_gnugettext_libintl],
           [gt_save_CPPFLAGS="$CPPFLAGS"
            CPPFLAGS="$CPPFLAGS $INCINTL"
            gt_save_LIBS="$LIBS"
            LIBS="$LIBS $LIBINTL"
            dnl Now see whether libintl exists and does not depend on libiconv.
            AC_TRY_LINK([#include <libintl.h>
$gt_revision_test_code
extern int _nl_msg_cat_cntr;
extern
#ifdef __cplusplus
"C"
#endif
const char *_nl_expand_alias (const char *);],
              [bindtextdomain ("", "");
return * gettext ("")$gt_expression_test_code + _nl_msg_cat_cntr + *_nl_expand_alias ("")],
              [eval "$gt_func_gnugettext_libintl=yes"],
              [eval "$gt_func_gnugettext_libintl=no"])
            dnl Now see whether libintl exists and depends on libiconv.
            if { eval "gt_val=\$$gt_func_gnugettext_libintl"; test "$gt_val" != yes; } && test -n "$LIBICONV"; then
              LIBS="$LIBS $LIBICONV"
              AC_TRY_LINK([#include <libintl.h>
$gt_revision_test_code
extern int _nl_msg_cat_cntr;
extern
#ifdef __cplusplus
"C"
#endif
const char *_nl_expand_alias (const char *);],
                [bindtextdomain ("", "");
return * gettext ("")$gt_expression_test_code + _nl_msg_cat_cntr + *_nl_expand_alias ("")],
               [LIBINTL="$LIBINTL $LIBICONV"
                LTLIBINTL="$LTLIBINTL $LTLIBICONV"
                eval "$gt_func_gnugettext_libintl=yes"
               ])
            fi
            CPPFLAGS="$gt_save_CPPFLAGS"
            LIBS="$gt_save_LIBS"])
        fi

        dnl If an already present or preinstalled GNU gettext() is found,
        dnl use it.  But if this macro is used in GNU gettext, and GNU
        dnl gettext is already preinstalled in libintl, we update this
        dnl libintl.  (Cf. the install rule in intl/Makefile.in.)
        if { eval "gt_val=\$$gt_func_gnugettext_libc"; test "$gt_val" = "yes"; } \
           || { { eval "gt_val=\$$gt_func_gnugettext_libintl"; test "$gt_val" = "yes"; } \
                && test "$PACKAGE" != gettext-runtime \
                && test "$PACKAGE" != gettext-tools; }; then
          gt_use_preinstalled_gnugettext=yes
        else
          dnl Reset the values set by searching for libintl.
          LIBINTL=
          LTLIBINTL=
          INCINTL=
        fi

    ifelse(gt_included_intl, yes, [
        if test "$gt_use_preinstalled_gnugettext" != "yes"; then
          dnl GNU gettext is not found in the C library.
          dnl Fall back on included GNU gettext library.
          nls_cv_use_gnu_gettext=yes
        fi
      fi

      if test "$nls_cv_use_gnu_gettext" = "yes"; then
        dnl Mark actions used to generate GNU NLS library.
        BUILD_INCLUDED_LIBINTL=yes
        USE_INCLUDED_LIBINTL=yes
        LIBINTL="ifelse([$3],[],\${top_builddir}/intl,[$3])/libintl.[]gt_libtool_suffix_prefix[]a $LIBICONV $LIBTHREAD"
        LTLIBINTL="ifelse([$3],[],\${top_builddir}/intl,[$3])/libintl.[]gt_libtool_suffix_prefix[]a $LTLIBICONV $LTLIBTHREAD"
        LIBS=`echo " $LIBS " | sed -e 's/ -lintl / /' -e 's/^ //' -e 's/ $//'`
      fi

      CATOBJEXT=
      if test "$gt_use_preinstalled_gnugettext" = "yes" \
         || test "$nls_cv_use_gnu_gettext" = "yes"; then
        dnl Mark actions to use GNU gettext tools.
        CATOBJEXT=.gmo
      fi
    ])

    if test -n "$INTL_MACOSX_LIBS"; then
      if test "$gt_use_preinstalled_gnugettext" = "yes" \
         || test "$nls_cv_use_gnu_gettext" = "yes"; then
        dnl Some extra flags are needed during linking.
        LIBINTL="$LIBINTL $INTL_MACOSX_LIBS"
        LTLIBINTL="$LTLIBINTL $INTL_MACOSX_LIBS"
      fi
    fi

    if test "$gt_use_preinstalled_gnugettext" = "yes" \
       || test "$nls_cv_use_gnu_gettext" = "yes"; then
      AC_DEFINE(ENABLE_NLS, 1,
        [Define to 1 if translation of program messages to the user's native language
   is requested.])
    else
      USE_NLS=no
    fi
  fi

  AC_MSG_CHECKING([whether to use NLS])
  AC_MSG_RESULT([$USE_NLS])
  if test "$USE_NLS" = "yes"; then
    AC_MSG_CHECKING([where the gettext function comes from])
    if test "$gt_use_preinstalled_gnugettext" = "yes"; then
      if { eval "gt_val=\$$gt_func_gnugettext_libintl"; test "$gt_val" = "yes"; }; then
        gt_source="external libintl"
      else
        gt_source="libc"
      fi
    else
      gt_source="included intl directory"
    fi
    AC_MSG_RESULT([$gt_source])
  fi

  if test "$USE_NLS" = "yes"; then

    if test "$gt_use_preinstalled_gnugettext" = "yes"; then
      if { eval "gt_val=\$$gt_func_gnugettext_libintl"; test "$gt_val" = "yes"; }; then
        AC_MSG_CHECKING([how to link with libintl])
        AC_MSG_RESULT([$LIBINTL])
        AC_LIB_APPENDTOVAR([CPPFLAGS], [$INCINTL])
      fi

      dnl For backward compatibility. Some packages may be using this.
      AC_DEFINE(HAVE_GETTEXT, 1,
       [Define if the GNU gettext() function is already present or preinstalled.])
      AC_DEFINE(HAVE_DCGETTEXT, 1,
       [Define if the GNU dcgettext() function is already present or preinstalled.])
    fi

    dnl We need to process the po/ directory.
    POSUB=po
  fi

  ifelse(gt_included_intl, yes, [
    dnl If this is used in GNU gettext we have to set BUILD_INCLUDED_LIBINTL
    dnl to 'yes' because some of the testsuite requires it.
    if test "$PACKAGE" = gettext-runtime || test "$PACKAGE" = gettext-tools; then
      BUILD_INCLUDED_LIBINTL=yes
    fi

    dnl Make all variables we use known to autoconf.
    AC_SUBST(BUILD_INCLUDED_LIBINTL)
    AC_SUBST(USE_INCLUDED_LIBINTL)
    AC_SUBST(CATOBJEXT)

    dnl For backward compatibility. Some configure.ins may be using this.
    nls_cv_header_intl=
    nls_cv_header_libgt=

    dnl For backward compatibility. Some Makefiles may be using this.
    DATADIRNAME=share
    AC_SUBST(DATADIRNAME)

    dnl For backward compatibility. Some Makefiles may be using this.
    INSTOBJEXT=.mo
    AC_SUBST(INSTOBJEXT)

    dnl For backward compatibility. Some Makefiles may be using this.
    GENCAT=gencat
    AC_SUBST(GENCAT)

    dnl For backward compatibility. Some Makefiles may be using this.
    INTLOBJS=
    if test "$USE_INCLUDED_LIBINTL" = yes; then
      INTLOBJS="\$(GETTOBJS)"
    fi
    AC_SUBST(INTLOBJS)

    dnl Enable libtool support if the surrounding package wishes it.
    INTL_LIBTOOL_SUFFIX_PREFIX=gt_libtool_suffix_prefix
    AC_SUBST(INTL_LIBTOOL_SUFFIX_PREFIX)
  ])

  dnl For backward compatibility. Some Makefiles may be using this.
  INTLLIBS="$LIBINTL"
  AC_SUBST(INTLLIBS)

  dnl Make all documented variables known to autoconf.
  AC_SUBST(LIBINTL)
  AC_SUBST(LTLIBINTL)
  AC_SUBST(POSUB)
])


dnl Checks for special options needed on MacOS X.
dnl Defines INTL_MACOSX_LIBS.
AC_DEFUN([gt_INTL_MACOSX],
[
  dnl Check for API introduced in MacOS X 10.2.
  AC_CACHE_CHECK([for CFPreferencesCopyAppValue],
    gt_cv_func_CFPreferencesCopyAppValue,
    [gt_save_LIBS="$LIBS"
     LIBS="$LIBS -Wl,-framework -Wl,CoreFoundation"
     AC_TRY_LINK([#include <CoreFoundation/CFPreferences.h>],
       [CFPreferencesCopyAppValue(NULL, NULL)],
       [gt_cv_func_CFPreferencesCopyAppValue=yes],
       [gt_cv_func_CFPreferencesCopyAppValue=no])
     LIBS="$gt_save_LIBS"])
  if test $gt_cv_func_CFPreferencesCopyAppValue = yes; then
    AC_DEFINE([HAVE_CFPREFERENCESCOPYAPPVALUE], 1,
      [Define to 1 if you have the MacOS X function CFPreferencesCopyAppValue in the CoreFoundation framework.])
  fi
  dnl Check for API introduced in MacOS X 10.3.
  AC_CACHE_CHECK([for CFLocaleCopyCurrent], gt_cv_func_CFLocaleCopyCurrent,
    [gt_save_LIBS="$LIBS"
     LIBS="$LIBS -Wl,-framework -Wl,CoreFoundation"
     AC_TRY_LINK([#include <CoreFoundation/CFLocale.h>], [CFLocaleCopyCurrent();],
       [gt_cv_func_CFLocaleCopyCurrent=yes],
       [gt_cv_func_CFLocaleCopyCurrent=no])
     LIBS="$gt_save_LIBS"])
  if test $gt_cv_func_CFLocaleCopyCurrent = yes; then
    AC_DEFINE([HAVE_CFLOCALECOPYCURRENT], 1,
      [Define to 1 if you have the MacOS X function CFLocaleCopyCurrent in the CoreFoundation framework.])
  fi
  INTL_MACOSX_LIBS=
  if test $gt_cv_func_CFPreferencesCopyAppValue = yes || test $gt_cv_func_CFLocaleCopyCurrent = yes; then
    INTL_MACOSX_LIBS="-Wl,-framework -Wl,CoreFoundation"
  fi
  AC_SUBST([INTL_MACOSX_LIBS])
])


dnl gt_NEEDS_INIT ensures that the gt_needs variable is initialized.
m4_define([gt_NEEDS_INIT],
[
  m4_divert_text([DEFAULTS], [gt_needs=])
  m4_define([gt_NEEDS_INIT], [])
])


dnl Usage: AM_GNU_GETTEXT_NEED([NEEDSYMBOL])
AC_DEFUN([AM_GNU_GETTEXT_NEED],
[
  m4_divert_text([INIT_PREPARE], [gt_needs="$gt_needs $1"])
])


dnl Usage: AM_GNU_GETTEXT_VERSION([gettext-version])
AC_DEFUN([AM_GNU_GETTEXT_VERSION], [])

# iconv.m4 serial AM4 (gettext-0.11.3)
dnl Copyright (C) 2000-2002 Free Software Foundation, Inc.
dnl This file is free software; the Free Software Foundation
dnl gives unlimited permission to copy and/or distribute it,
dnl with or without modifications, as long as this notice is preserved.

dnl From Bruno Haible.

AC_DEFUN([AM_ICONV_LINKFLAGS_BODY],
[
  dnl Prerequisites of AC_LIB_LINKFLAGS_BODY.
  AC_REQUIRE([AC_LIB_PREPARE_PREFIX])
  AC_REQUIRE([AC_LIB_RPATH])

  dnl Search for libiconv and define LIBICONV, LTLIBICONV and INCICONV
  dnl accordingly.
  AC_LIB_LINKFLAGS_BODY([iconv])
])

AC_DEFUN([AM_ICONV_LINK],
[
  dnl Some systems have iconv in libc, some have it in libiconv (OSF/1 and
  dnl those with the standalone portable GNU libiconv installed).

  dnl Search for libiconv and define LIBICONV, LTLIBICONV and INCICONV
  dnl accordingly.
  AC_REQUIRE([AM_ICONV_LINKFLAGS_BODY])

  dnl Add $INCICONV to CPPFLAGS before performing the following checks,
  dnl because if the user has installed libiconv and not disabled its use
  dnl via --without-libiconv-prefix, he wants to use it. The first
  dnl AC_TRY_LINK will then fail, the second AC_TRY_LINK will succeed.
  am_save_CPPFLAGS="$CPPFLAGS"
  AC_LIB_APPENDTOVAR([CPPFLAGS], [$INCICONV])

  AC_CACHE_CHECK(for iconv, am_cv_func_iconv, [
    am_cv_func_iconv="no, consider installing GNU libiconv"
    am_cv_lib_iconv=no
    AC_TRY_LINK([#include <stdlib.h>
#include <iconv.h>],
      [iconv_t cd = iconv_open("","");
       iconv(cd,NULL,NULL,NULL,NULL);
       iconv_close(cd);],
      am_cv_func_iconv=yes)
    if test "$am_cv_func_iconv" != yes; then
      am_save_LIBS="$LIBS"
      LIBS="$LIBS $LIBICONV"
      AC_TRY_LINK([#include <stdlib.h>
#include <iconv.h>],
        [iconv_t cd = iconv_open("","");
         iconv(cd,NULL,NULL,NULL,NULL);
         iconv_close(cd);],
        am_cv_lib_iconv=yes
        am_cv_func_iconv=yes)
      LIBS="$am_save_LIBS"
    fi
  ])
  if test "$am_cv_func_iconv" = yes; then
    AC_DEFINE(HAVE_ICONV, 1, [Define if you have the iconv() function.])
  fi
  if test "$am_cv_lib_iconv" = yes; then
    AC_MSG_CHECKING([how to link with libiconv])
    AC_MSG_RESULT([$LIBICONV])
  else
    dnl If $LIBICONV didn't lead to a usable library, we don't need $INCICONV
    dnl either.
    CPPFLAGS="$am_save_CPPFLAGS"
    LIBICONV=
    LTLIBICONV=
  fi
  AC_SUBST(LIBICONV)
  AC_SUBST(LTLIBICONV)
])

AC_DEFUN([AM_ICONV],
[
  AM_ICONV_LINK
  if test "$am_cv_func_iconv" = yes; then
    AC_MSG_CHECKING([for iconv declaration])
    AC_CACHE_VAL(am_cv_proto_iconv, [
      AC_TRY_COMPILE([
#include <stdlib.h>
#include <iconv.h>
extern
#ifdef __cplusplus
"C"
#endif
#if defined(__STDC__) || defined(__cplusplus)
size_t iconv (iconv_t cd, char * *inbuf, size_t *inbytesleft, char * *outbuf, size_t *outbytesleft);
#else
size_t iconv();
#endif
], [], am_cv_proto_iconv_arg1="", am_cv_proto_iconv_arg1="const")
      am_cv_proto_iconv="extern size_t iconv (iconv_t cd, $am_cv_proto_iconv_arg1 char * *inbuf, size_t *inbytesleft, char * *outbuf, size_t *outbytesleft);"])
    am_cv_proto_iconv=`echo "[$]am_cv_proto_iconv" | tr -s ' ' | sed -e 's/( /(/'`
    AC_MSG_RESULT([$]{ac_t:-
         }[$]am_cv_proto_iconv)
    AC_DEFINE_UNQUOTED(ICONV_CONST, $am_cv_proto_iconv_arg1,
      [Define as const if the declaration of iconv() needs const.])
  fi
])

# lib-ld.m4 serial 3 (gettext-0.13)
dnl Copyright (C) 1996-2003 Free Software Foundation, Inc.
dnl This file is free software; the Free Software Foundation
dnl gives unlimited permission to copy and/or distribute it,
dnl with or without modifications, as long as this notice is preserved.

dnl Subroutines of libtool.m4,
dnl with replacements s/AC_/AC_LIB/ and s/lt_cv/acl_cv/ to avoid collision
dnl with libtool.m4.

dnl From libtool-1.4. Sets the variable with_gnu_ld to yes or no.
AC_DEFUN([AC_LIB_PROG_LD_GNU],
[AC_CACHE_CHECK([if the linker ($LD) is GNU ld], acl_cv_prog_gnu_ld,
[# I'd rather use --version here, but apparently some GNU ld's only accept -v.
case `$LD -v 2>&1 </dev/null` in
*GNU* | *'with BFD'*)
  acl_cv_prog_gnu_ld=yes ;;
*)
  acl_cv_prog_gnu_ld=no ;;
esac])
with_gnu_ld=$acl_cv_prog_gnu_ld
])

dnl From libtool-1.4. Sets the variable LD.
AC_DEFUN([AC_LIB_PROG_LD],
[AC_ARG_WITH(gnu-ld,
[  --with-gnu-ld           assume the C compiler uses GNU ld [default=no]],
test "$withval" = no || with_gnu_ld=yes, with_gnu_ld=no)
AC_REQUIRE([AC_PROG_CC])dnl
AC_REQUIRE([AC_CANONICAL_HOST])dnl
# Prepare PATH_SEPARATOR.
# The user is always right.
if test "${PATH_SEPARATOR+set}" != set; then
  echo "#! /bin/sh" >conf$$.sh
  echo  "exit 0"   >>conf$$.sh
  chmod +x conf$$.sh
  if (PATH="/nonexistent;."; conf$$.sh) >/dev/null 2>&1; then
    PATH_SEPARATOR=';'
  else
    PATH_SEPARATOR=:
  fi
  rm -f conf$$.sh
fi
ac_prog=ld
if test "$GCC" = yes; then
  # Check if gcc -print-prog-name=ld gives a path.
  AC_MSG_CHECKING([for ld used by GCC])
  case $host in
  *-*-mingw*)
    # gcc leaves a trailing carriage return which upsets mingw
    ac_prog=`($CC -print-prog-name=ld) 2>&5 | tr -d '\015'` ;;
  *)
    ac_prog=`($CC -print-prog-name=ld) 2>&5` ;;
  esac
  case $ac_prog in
    # Accept absolute paths.
    [[\\/]* | [A-Za-z]:[\\/]*)]
      [re_direlt='/[^/][^/]*/\.\./']
      # Canonicalize the path of ld
      ac_prog=`echo $ac_prog| sed 's%\\\\%/%g'`
      while echo $ac_prog | grep "$re_direlt" > /dev/null 2>&1; do
	ac_prog=`echo $ac_prog| sed "s%$re_direlt%/%"`
      done
      test -z "$LD" && LD="$ac_prog"
      ;;
  "")
    # If it fails, then pretend we aren't using GCC.
    ac_prog=ld
    ;;
  *)
    # If it is relative, then search for the first ld in PATH.
    with_gnu_ld=unknown
    ;;
  esac
elif test "$with_gnu_ld" = yes; then
  AC_MSG_CHECKING([for GNU ld])
else
  AC_MSG_CHECKING([for non-GNU ld])
fi
AC_CACHE_VAL(acl_cv_path_LD,
[if test -z "$LD"; then
  IFS="${IFS= 	}"; ac_save_ifs="$IFS"; IFS="${IFS}${PATH_SEPARATOR-:}"
  for ac_dir in $PATH; do
    test -z "$ac_dir" && ac_dir=.
    if test -f "$ac_dir/$ac_prog" || test -f "$ac_dir/$ac_prog$ac_exeext"; then
      acl_cv_path_LD="$ac_dir/$ac_prog"
      # Check to see if the program is GNU ld.  I'd rather use --version,
      # but apparently some GNU ld's only accept -v.
      # Break only if it was the GNU/non-GNU ld that we prefer.
      case `"$acl_cv_path_LD" -v 2>&1 < /dev/null` in
      *GNU* | *'with BFD'*)
	test "$with_gnu_ld" != no && break ;;
      *)
	test "$with_gnu_ld" != yes && break ;;
      esac
    fi
  done
  IFS="$ac_save_ifs"
else
  acl_cv_path_LD="$LD" # Let the user override the test with a path.
fi])
LD="$acl_cv_path_LD"
if test -n "$LD"; then
  AC_MSG_RESULT($LD)
else
  AC_MSG_RESULT(no)
fi
test -z "$LD" && AC_MSG_ERROR([no acceptable ld found in \$PATH])
AC_LIB_PROG_LD_GNU
])

# lib-link.m4 serial 9 (gettext-0.16)
dnl Copyright (C) 2001-2006 Free Software Foundation, Inc.
dnl This file is free software; the Free Software Foundation
dnl gives unlimited permission to copy and/or distribute it,
dnl with or without modifications, as long as this notice is preserved.

dnl From Bruno Haible.

AC_PREREQ(2.50)

dnl AC_LIB_LINKFLAGS(name [, dependencies]) searches for libname and
dnl the libraries corresponding to explicit and implicit dependencies.
dnl Sets and AC_SUBSTs the LIB${NAME} and LTLIB${NAME} variables and
dnl augments the CPPFLAGS variable.
AC_DEFUN([AC_LIB_LINKFLAGS],
[
  AC_REQUIRE([AC_LIB_PREPARE_PREFIX])
  AC_REQUIRE([AC_LIB_RPATH])
  define([Name],[translit([$1],[./-], [___])])
  define([NAME],[translit([$1],[abcdefghijklmnopqrstuvwxyz./-],
                               [ABCDEFGHIJKLMNOPQRSTUVWXYZ___])])
  AC_CACHE_CHECK([how to link with lib[]$1], [ac_cv_lib[]Name[]_libs], [
    AC_LIB_LINKFLAGS_BODY([$1], [$2])
    ac_cv_lib[]Name[]_libs="$LIB[]NAME"
    ac_cv_lib[]Name[]_ltlibs="$LTLIB[]NAME"
    ac_cv_lib[]Name[]_cppflags="$INC[]NAME"
  ])
  LIB[]NAME="$ac_cv_lib[]Name[]_libs"
  LTLIB[]NAME="$ac_cv_lib[]Name[]_ltlibs"
  INC[]NAME="$ac_cv_lib[]Name[]_cppflags"
  AC_LIB_APPENDTOVAR([CPPFLAGS], [$INC]NAME)
  AC_SUBST([LIB]NAME)
  AC_SUBST([LTLIB]NAME)
  dnl Also set HAVE_LIB[]NAME so that AC_LIB_HAVE_LINKFLAGS can reuse the
  dnl results of this search when this library appears as a dependency.
  HAVE_LIB[]NAME=yes
  undefine([Name])
  undefine([NAME])
])

dnl AC_LIB_HAVE_LINKFLAGS(name, dependencies, includes, testcode)
dnl searches for libname and the libraries corresponding to explicit and
dnl implicit dependencies, together with the specified include files and
dnl the ability to compile and link the specified testcode. If found, it
dnl sets and AC_SUBSTs HAVE_LIB${NAME}=yes and the LIB${NAME} and
dnl LTLIB${NAME} variables and augments the CPPFLAGS variable, and
dnl #defines HAVE_LIB${NAME} to 1. Otherwise, it sets and AC_SUBSTs
dnl HAVE_LIB${NAME}=no and LIB${NAME} and LTLIB${NAME} to empty.
AC_DEFUN([AC_LIB_HAVE_LINKFLAGS],
[
  AC_REQUIRE([AC_LIB_PREPARE_PREFIX])
  AC_REQUIRE([AC_LIB_RPATH])
  define([Name],[translit([$1],[./-], [___])])
  define([NAME],[translit([$1],[abcdefghijklmnopqrstuvwxyz./-],
                               [ABCDEFGHIJKLMNOPQRSTUVWXYZ___])])

  dnl Search for lib[]Name and define LIB[]NAME, LTLIB[]NAME and INC[]NAME
  dnl accordingly.
  AC_LIB_LINKFLAGS_BODY([$1], [$2])

  dnl Add $INC[]NAME to CPPFLAGS before performing the following checks,
  dnl because if the user has installed lib[]Name and not disabled its use
  dnl via --without-lib[]Name-prefix, he wants to use it.
  ac_save_CPPFLAGS="$CPPFLAGS"
  AC_LIB_APPENDTOVAR([CPPFLAGS], [$INC]NAME)

  AC_CACHE_CHECK([for lib[]$1], [ac_cv_lib[]Name], [
    ac_save_LIBS="$LIBS"
    LIBS="$LIBS $LIB[]NAME"
    AC_TRY_LINK([$3], [$4], [ac_cv_lib[]Name=yes], [ac_cv_lib[]Name=no])
    LIBS="$ac_save_LIBS"
  ])
  if test "$ac_cv_lib[]Name" = yes; then
    HAVE_LIB[]NAME=yes
    AC_DEFINE([HAVE_LIB]NAME, 1, [Define if you have the $1 library.])
    AC_MSG_CHECKING([how to link with lib[]$1])
    AC_MSG_RESULT([$LIB[]NAME])
  else
    HAVE_LIB[]NAME=no
    dnl If $LIB[]NAME didn't lead to a usable library, we don't need
    dnl $INC[]NAME either.
    CPPFLAGS="$ac_save_CPPFLAGS"
    LIB[]NAME=
    LTLIB[]NAME=
  fi
  AC_SUBST([HAVE_LIB]NAME)
  AC_SUBST([LIB]NAME)
  AC_SUBST([LTLIB]NAME)
  undefine([Name])
  undefine([NAME])
])

dnl Determine the platform dependent parameters needed to use rpath:
dnl libext, shlibext, hardcode_libdir_flag_spec, hardcode_libdir_separator,
dnl hardcode_direct, hardcode_minus_L.
AC_DEFUN([AC_LIB_RPATH],
[
  dnl Tell automake >= 1.10 to complain if config.rpath is missing.
  m4_ifdef([AC_REQUIRE_AUX_FILE], [AC_REQUIRE_AUX_FILE([config.rpath])])
  AC_REQUIRE([AC_PROG_CC])                dnl we use $CC, $GCC, $LDFLAGS
  AC_REQUIRE([AC_LIB_PROG_LD])            dnl we use $LD, $with_gnu_ld
  AC_REQUIRE([AC_CANONICAL_HOST])         dnl we use $host
  AC_REQUIRE([AC_CONFIG_AUX_DIR_DEFAULT]) dnl we use $ac_aux_dir
  AC_CACHE_CHECK([for shared library run path origin], acl_cv_rpath, [
    CC="$CC" GCC="$GCC" LDFLAGS="$LDFLAGS" LD="$LD" with_gnu_ld="$with_gnu_ld" \
    ${CONFIG_SHELL-/bin/sh} "$ac_aux_dir/config.rpath" "$host" > conftest.sh
    . ./conftest.sh
    rm -f ./conftest.sh
    acl_cv_rpath=done
  ])
  wl="$acl_cv_wl"
  libext="$acl_cv_libext"
  shlibext="$acl_cv_shlibext"
  hardcode_libdir_flag_spec="$acl_cv_hardcode_libdir_flag_spec"
  hardcode_libdir_separator="$acl_cv_hardcode_libdir_separator"
  hardcode_direct="$acl_cv_hardcode_direct"
  hardcode_minus_L="$acl_cv_hardcode_minus_L"
  dnl Determine whether the user wants rpath handling at all.
  AC_ARG_ENABLE(rpath,
    [  --disable-rpath         do not hardcode runtime library paths],
    :, enable_rpath=yes)
])

dnl AC_LIB_LINKFLAGS_BODY(name [, dependencies]) searches for libname and
dnl the libraries corresponding to explicit and implicit dependencies.
dnl Sets the LIB${NAME}, LTLIB${NAME} and INC${NAME} variables.
AC_DEFUN([AC_LIB_LINKFLAGS_BODY],
[
  AC_REQUIRE([AC_LIB_PREPARE_MULTILIB])
  define([NAME],[translit([$1],[abcdefghijklmnopqrstuvwxyz./-],
                               [ABCDEFGHIJKLMNOPQRSTUVWXYZ___])])
  dnl By default, look in $includedir and $libdir.
  use_additional=yes
  AC_LIB_WITH_FINAL_PREFIX([
    eval additional_includedir=\"$includedir\"
    eval additional_libdir=\"$libdir\"
  ])
  AC_LIB_ARG_WITH([lib$1-prefix],
[  --with-lib$1-prefix[=DIR]  search for lib$1 in DIR/include and DIR/lib
  --without-lib$1-prefix     don't search for lib$1 in includedir and libdir],
[
    if test "X$withval" = "Xno"; then
      use_additional=no
    else
      if test "X$withval" = "X"; then
        AC_LIB_WITH_FINAL_PREFIX([
          eval additional_includedir=\"$includedir\"
          eval additional_libdir=\"$libdir\"
        ])
      else
        additional_includedir="$withval/include"
        additional_libdir="$withval/$acl_libdirstem"
      fi
    fi
])
  dnl Search the library and its dependencies in $additional_libdir and
  dnl $LDFLAGS. Using breadth-first-seach.
  LIB[]NAME=
  LTLIB[]NAME=
  INC[]NAME=
  rpathdirs=
  ltrpathdirs=
  names_already_handled=
  names_next_round='$1 $2'
  while test -n "$names_next_round"; do
    names_this_round="$names_next_round"
    names_next_round=
    for name in $names_this_round; do
      already_handled=
      for n in $names_already_handled; do
        if test "$n" = "$name"; then
          already_handled=yes
          break
        fi
      done
      if test -z "$already_handled"; then
        names_already_handled="$names_already_handled $name"
        dnl See if it was already located by an earlier AC_LIB_LINKFLAGS
        dnl or AC_LIB_HAVE_LINKFLAGS call.
        uppername=`echo "$name" | sed -e 'y|abcdefghijklmnopqrstuvwxyz./-|ABCDEFGHIJKLMNOPQRSTUVWXYZ___|'`
        eval value=\"\$HAVE_LIB$uppername\"
        if test -n "$value"; then
          if test "$value" = yes; then
            eval value=\"\$LIB$uppername\"
            test -z "$value" || LIB[]NAME="${LIB[]NAME}${LIB[]NAME:+ }$value"
            eval value=\"\$LTLIB$uppername\"
            test -z "$value" || LTLIB[]NAME="${LTLIB[]NAME}${LTLIB[]NAME:+ }$value"
          else
            dnl An earlier call to AC_LIB_HAVE_LINKFLAGS has determined
            dnl that this library doesn't exist. So just drop it.
            :
          fi
        else
          dnl Search the library lib$name in $additional_libdir and $LDFLAGS
          dnl and the already constructed $LIBNAME/$LTLIBNAME.
          found_dir=
          found_la=
          found_so=
          found_a=
          if test $use_additional = yes; then
            if test -n "$shlibext" \
               && { test -f "$additional_libdir/lib$name.$shlibext" \
                    || { test "$shlibext" = dll \
                         && test -f "$additional_libdir/lib$name.dll.a"; }; }; then
              found_dir="$additional_libdir"
              if test -f "$additional_libdir/lib$name.$shlibext"; then
                found_so="$additional_libdir/lib$name.$shlibext"
              else
                found_so="$additional_libdir/lib$name.dll.a"
              fi
              if test -f "$additional_libdir/lib$name.la"; then
                found_la="$additional_libdir/lib$name.la"
              fi
            else
              if test -f "$additional_libdir/lib$name.$libext"; then
                found_dir="$additional_libdir"
                found_a="$additional_libdir/lib$name.$libext"
                if test -f "$additional_libdir/lib$name.la"; then
                  found_la="$additional_libdir/lib$name.la"
                fi
              fi
            fi
          fi
          if test "X$found_dir" = "X"; then
            for x in $LDFLAGS $LTLIB[]NAME; do
              AC_LIB_WITH_FINAL_PREFIX([eval x=\"$x\"])
              case "$x" in
                -L*)
                  dir=`echo "X$x" | sed -e 's/^X-L//'`
                  if test -n "$shlibext" \
                     && { test -f "$dir/lib$name.$shlibext" \
                          || { test "$shlibext" = dll \
                               && test -f "$dir/lib$name.dll.a"; }; }; then
                    found_dir="$dir"
                    if test -f "$dir/lib$name.$shlibext"; then
                      found_so="$dir/lib$name.$shlibext"
                    else
                      found_so="$dir/lib$name.dll.a"
                    fi
                    if test -f "$dir/lib$name.la"; then
                      found_la="$dir/lib$name.la"
                    fi
                  else
                    if test -f "$dir/lib$name.$libext"; then
                      found_dir="$dir"
                      found_a="$dir/lib$name.$libext"
                      if test -f "$dir/lib$name.la"; then
                        found_la="$dir/lib$name.la"
                      fi
                    fi
                  fi
                  ;;
              esac
              if test "X$found_dir" != "X"; then
                break
              fi
            done
          fi
          if test "X$found_dir" != "X"; then
            dnl Found the library.
            LTLIB[]NAME="${LTLIB[]NAME}${LTLIB[]NAME:+ }-L$found_dir -l$name"
            if test "X$found_so" != "X"; then
              dnl Linking with a shared library. We attempt to hardcode its
              dnl directory into the executable's runpath, unless it's the
              dnl standard /usr/lib.
              if test "$enable_rpath" = no || test "X$found_dir" = "X/usr/$acl_libdirstem"; then
                dnl No hardcoding is needed.
                LIB[]NAME="${LIB[]NAME}${LIB[]NAME:+ }$found_so"
              else
                dnl Use an explicit option to hardcode DIR into the resulting
                dnl binary.
                dnl Potentially add DIR to ltrpathdirs.
                dnl The ltrpathdirs will be appended to $LTLIBNAME at the end.
                haveit=
                for x in $ltrpathdirs; do
                  if test "X$x" = "X$found_dir"; then
                    haveit=yes
                    break
                  fi
                done
                if test -z "$haveit"; then
                  ltrpathdirs="$ltrpathdirs $found_dir"
                fi
                dnl The hardcoding into $LIBNAME is system dependent.
                if test "$hardcode_direct" = yes; then
                  dnl Using DIR/libNAME.so during linking hardcodes DIR into the
                  dnl resulting binary.
                  LIB[]NAME="${LIB[]NAME}${LIB[]NAME:+ }$found_so"
                else
                  if test -n "$hardcode_libdir_flag_spec" && test "$hardcode_minus_L" = no; then
                    dnl Use an explicit option to hardcode DIR into the resulting
                    dnl binary.
                    LIB[]NAME="${LIB[]NAME}${LIB[]NAME:+ }$found_so"
                    dnl Potentially add DIR to rpathdirs.
                    dnl The rpathdirs will be appended to $LIBNAME at the end.
                    haveit=
                    for x in $rpathdirs; do
                      if test "X$x" = "X$found_dir"; then
                        haveit=yes
                        break
                      fi
                    done
                    if test -z "$haveit"; then
                      rpathdirs="$rpathdirs $found_dir"
                    fi
                  else
                    dnl Rely on "-L$found_dir".
                    dnl But don't add it if it's already contained in the LDFLAGS
                    dnl or the already constructed $LIBNAME
                    haveit=
                    for x in $LDFLAGS $LIB[]NAME; do
                      AC_LIB_WITH_FINAL_PREFIX([eval x=\"$x\"])
                      if test "X$x" = "X-L$found_dir"; then
                        haveit=yes
                        break
                      fi
                    done
                    if test -z "$haveit"; then
                      LIB[]NAME="${LIB[]NAME}${LIB[]NAME:+ }-L$found_dir"
                    fi
                    if test "$hardcode_minus_L" != no; then
                      dnl FIXME: Not sure whether we should use
                      dnl "-L$found_dir -l$name" or "-L$found_dir $found_so"
                      dnl here.
                      LIB[]NAME="${LIB[]NAME}${LIB[]NAME:+ }$found_so"
                    else
                      dnl We cannot use $hardcode_runpath_var and LD_RUN_PATH
                      dnl here, because this doesn't fit in flags passed to the
                      dnl compiler. So give up. No hardcoding. This affects only
                      dnl very old systems.
                      dnl FIXME: Not sure whether we should use
                      dnl "-L$found_dir -l$name" or "-L$found_dir $found_so"
                      dnl here.
                      LIB[]NAME="${LIB[]NAME}${LIB[]NAME:+ }-l$name"
                    fi
                  fi
                fi
              fi
            else
              if test "X$found_a" != "X"; then
                dnl Linking with a static library.
                LIB[]NAME="${LIB[]NAME}${LIB[]NAME:+ }$found_a"
              else
                dnl We shouldn't come here, but anyway it's good to have a
                dnl fallback.
                LIB[]NAME="${LIB[]NAME}${LIB[]NAME:+ }-L$found_dir -l$name"
              fi
            fi
            dnl Assume the include files are nearby.
            additional_includedir=
            case "$found_dir" in
              */$acl_libdirstem | */$acl_libdirstem/)
                basedir=`echo "X$found_dir" | sed -e 's,^X,,' -e "s,/$acl_libdirstem/"'*$,,'`
                additional_includedir="$basedir/include"
                ;;
            esac
            if test "X$additional_includedir" != "X"; then
              dnl Potentially add $additional_includedir to $INCNAME.
              dnl But don't add it
              dnl   1. if it's the standard /usr/include,
              dnl   2. if it's /usr/local/include and we are using GCC on Linux,
              dnl   3. if it's already present in $CPPFLAGS or the already
              dnl      constructed $INCNAME,
              dnl   4. if it doesn't exist as a directory.
              if test "X$additional_includedir" != "X/usr/include"; then
                haveit=
                if test "X$additional_includedir" = "X/usr/local/include"; then
                  if test -n "$GCC"; then
                    case $host_os in
                      linux* | gnu* | k*bsd*-gnu) haveit=yes;;
                    esac
                  fi
                fi
                if test -z "$haveit"; then
                  for x in $CPPFLAGS $INC[]NAME; do
                    AC_LIB_WITH_FINAL_PREFIX([eval x=\"$x\"])
                    if test "X$x" = "X-I$additional_includedir"; then
                      haveit=yes
                      break
                    fi
                  done
                  if test -z "$haveit"; then
                    if test -d "$additional_includedir"; then
                      dnl Really add $additional_includedir to $INCNAME.
                      INC[]NAME="${INC[]NAME}${INC[]NAME:+ }-I$additional_includedir"
                    fi
                  fi
                fi
              fi
            fi
            dnl Look for dependencies.
            if test -n "$found_la"; then
              dnl Read the .la file. It defines the variables
              dnl dlname, library_names, old_library, dependency_libs, current,
              dnl age, revision, installed, dlopen, dlpreopen, libdir.
              save_libdir="$libdir"
              case "$found_la" in
                */* | *\\*) . "$found_la" ;;
                *) . "./$found_la" ;;
              esac
              libdir="$save_libdir"
              dnl We use only dependency_libs.
              for dep in $dependency_libs; do
                case "$dep" in
                  -L*)
                    additional_libdir=`echo "X$dep" | sed -e 's/^X-L//'`
                    dnl Potentially add $additional_libdir to $LIBNAME and $LTLIBNAME.
                    dnl But don't add it
                    dnl   1. if it's the standard /usr/lib,
                    dnl   2. if it's /usr/local/lib and we are using GCC on Linux,
                    dnl   3. if it's already present in $LDFLAGS or the already
                    dnl      constructed $LIBNAME,
                    dnl   4. if it doesn't exist as a directory.
                    if test "X$additional_libdir" != "X/usr/$acl_libdirstem"; then
                      haveit=
                      if test "X$additional_libdir" = "X/usr/local/$acl_libdirstem"; then
                        if test -n "$GCC"; then
                          case $host_os in
                            linux* | gnu* | k*bsd*-gnu) haveit=yes;;
                          esac
                        fi
                      fi
                      if test -z "$haveit"; then
                        haveit=
                        for x in $LDFLAGS $LIB[]NAME; do
                          AC_LIB_WITH_FINAL_PREFIX([eval x=\"$x\"])
                          if test "X$x" = "X-L$additional_libdir"; then
                            haveit=yes
                            break
                          fi
                        done
                        if test -z "$haveit"; then
                          if test -d "$additional_libdir"; then
                            dnl Really add $additional_libdir to $LIBNAME.
                            LIB[]NAME="${LIB[]NAME}${LIB[]NAME:+ }-L$additional_libdir"
                          fi
                        fi
                        haveit=
                        for x in $LDFLAGS $LTLIB[]NAME; do
                          AC_LIB_WITH_FINAL_PREFIX([eval x=\"$x\"])
                          if test "X$x" = "X-L$additional_libdir"; then
                            haveit=yes
                            break
                          fi
                        done
                        if test -z "$haveit"; then
                          if test -d "$additional_libdir"; then
                            dnl Really add $additional_libdir to $LTLIBNAME.
                            LTLIB[]NAME="${LTLIB[]NAME}${LTLIB[]NAME:+ }-L$additional_libdir"
                          fi
                        fi
                      fi
                    fi
                    ;;
                  -R*)
                    dir=`echo "X$dep" | sed -e 's/^X-R//'`
                    if test "$enable_rpath" != no; then
                      dnl Potentially add DIR to rpathdirs.
                      dnl The rpathdirs will be appended to $LIBNAME at the end.
                      haveit=
                      for x in $rpathdirs; do
                        if test "X$x" = "X$dir"; then
                          haveit=yes
                          break
                        fi
                      done
                      if test -z "$haveit"; then
                        rpathdirs="$rpathdirs $dir"
                      fi
                      dnl Potentially add DIR to ltrpathdirs.
                      dnl The ltrpathdirs will be appended to $LTLIBNAME at the end.
                      haveit=
                      for x in $ltrpathdirs; do
                        if test "X$x" = "X$dir"; then
                          haveit=yes
                          break
                        fi
                      done
                      if test -z "$haveit"; then
                        ltrpathdirs="$ltrpathdirs $dir"
                      fi
                    fi
                    ;;
                  -l*)
                    dnl Handle this in the next round.
                    names_next_round="$names_next_round "`echo "X$dep" | sed -e 's/^X-l//'`
                    ;;
                  *.la)
                    dnl Handle this in the next round. Throw away the .la's
                    dnl directory; it is already contained in a preceding -L
                    dnl option.
                    names_next_round="$names_next_round "`echo "X$dep" | sed -e 's,^X.*/,,' -e 's,^lib,,' -e 's,\.la$,,'`
                    ;;
                  *)
                    dnl Most likely an immediate library name.
                    LIB[]NAME="${LIB[]NAME}${LIB[]NAME:+ }$dep"
                    LTLIB[]NAME="${LTLIB[]NAME}${LTLIB[]NAME:+ }$dep"
                    ;;
                esac
              done
            fi
          else
            dnl Didn't find the library; assume it is in the system directories
            dnl known to the linker and runtime loader. (All the system
            dnl directories known to the linker should also be known to the
            dnl runtime loader, otherwise the system is severely misconfigured.)
            LIB[]NAME="${LIB[]NAME}${LIB[]NAME:+ }-l$name"
            LTLIB[]NAME="${LTLIB[]NAME}${LTLIB[]NAME:+ }-l$name"
          fi
        fi
      fi
    done
  done
  if test "X$rpathdirs" != "X"; then
    if test -n "$hardcode_libdir_separator"; then
      dnl Weird platform: only the last -rpath option counts, the user must
      dnl pass all path elements in one option. We can arrange that for a
      dnl single library, but not when more than one $LIBNAMEs are used.
      alldirs=
      for found_dir in $rpathdirs; do
        alldirs="${alldirs}${alldirs:+$hardcode_libdir_separator}$found_dir"
      done
      dnl Note: hardcode_libdir_flag_spec uses $libdir and $wl.
      acl_save_libdir="$libdir"
      libdir="$alldirs"
      eval flag=\"$hardcode_libdir_flag_spec\"
      libdir="$acl_save_libdir"
      LIB[]NAME="${LIB[]NAME}${LIB[]NAME:+ }$flag"
    else
      dnl The -rpath options are cumulative.
      for found_dir in $rpathdirs; do
        acl_save_libdir="$libdir"
        libdir="$found_dir"
        eval flag=\"$hardcode_libdir_flag_spec\"
        libdir="$acl_save_libdir"
        LIB[]NAME="${LIB[]NAME}${LIB[]NAME:+ }$flag"
      done
    fi
  fi
  if test "X$ltrpathdirs" != "X"; then
    dnl When using libtool, the option that works for both libraries and
    dnl executables is -R. The -R options are cumulative.
    for found_dir in $ltrpathdirs; do
      LTLIB[]NAME="${LTLIB[]NAME}${LTLIB[]NAME:+ }-R$found_dir"
    done
  fi
])

dnl AC_LIB_APPENDTOVAR(VAR, CONTENTS) appends the elements of CONTENTS to VAR,
dnl unless already present in VAR.
dnl Works only for CPPFLAGS, not for LIB* variables because that sometimes
dnl contains two or three consecutive elements that belong together.
AC_DEFUN([AC_LIB_APPENDTOVAR],
[
  for element in [$2]; do
    haveit=
    for x in $[$1]; do
      AC_LIB_WITH_FINAL_PREFIX([eval x=\"$x\"])
      if test "X$x" = "X$element"; then
        haveit=yes
        break
      fi
    done
    if test -z "$haveit"; then
      [$1]="${[$1]}${[$1]:+ }$element"
    fi
  done
])

dnl For those cases where a variable contains several -L and -l options
dnl referring to unknown libraries and directories, this macro determines the
dnl necessary additional linker options for the runtime path.
dnl AC_LIB_LINKFLAGS_FROM_LIBS([LDADDVAR], [LIBSVALUE], [USE-LIBTOOL])
dnl sets LDADDVAR to linker options needed together with LIBSVALUE.
dnl If USE-LIBTOOL evaluates to non-empty, linking with libtool is assumed,
dnl otherwise linking without libtool is assumed.
AC_DEFUN([AC_LIB_LINKFLAGS_FROM_LIBS],
[
  AC_REQUIRE([AC_LIB_RPATH])
  AC_REQUIRE([AC_LIB_PREPARE_MULTILIB])
  $1=
  if test "$enable_rpath" != no; then
    if test -n "$hardcode_libdir_flag_spec" && test "$hardcode_minus_L" = no; then
      dnl Use an explicit option to hardcode directories into the resulting
      dnl binary.
      rpathdirs=
      next=
      for opt in $2; do
        if test -n "$next"; then
          dir="$next"
          dnl No need to hardcode the standard /usr/lib.
          if test "X$dir" != "X/usr/$acl_libdirstem"; then
            rpathdirs="$rpathdirs $dir"
          fi
          next=
        else
          case $opt in
            -L) next=yes ;;
            -L*) dir=`echo "X$opt" | sed -e 's,^X-L,,'`
                 dnl No need to hardcode the standard /usr/lib.
                 if test "X$dir" != "X/usr/$acl_libdirstem"; then
                   rpathdirs="$rpathdirs $dir"
                 fi
                 next= ;;
            *) next= ;;
          esac
        fi
      done
      if test "X$rpathdirs" != "X"; then
        if test -n ""$3""; then
          dnl libtool is used for linking. Use -R options.
          for dir in $rpathdirs; do
            $1="${$1}${$1:+ }-R$dir"
          done
        else
          dnl The linker is used for linking directly.
          if test -n "$hardcode_libdir_separator"; then
            dnl Weird platform: only the last -rpath option counts, the user
            dnl must pass all path elements in one option.
            alldirs=
            for dir in $rpathdirs; do
              alldirs="${alldirs}${alldirs:+$hardcode_libdir_separator}$dir"
            done
            acl_save_libdir="$libdir"
            libdir="$alldirs"
            eval flag=\"$hardcode_libdir_flag_spec\"
            libdir="$acl_save_libdir"
            $1="$flag"
          else
            dnl The -rpath options are cumulative.
            for dir in $rpathdirs; do
              acl_save_libdir="$libdir"
              libdir="$dir"
              eval flag=\"$hardcode_libdir_flag_spec\"
              libdir="$acl_save_libdir"
              $1="${$1}${$1:+ }$flag"
            done
          fi
        fi
      fi
    fi
  fi
  AC_SUBST([$1])
])

# lib-prefix.m4 serial 5 (gettext-0.15)
dnl Copyright (C) 2001-2005 Free Software Foundation, Inc.
dnl This file is free software; the Free Software Foundation
dnl gives unlimited permission to copy and/or distribute it,
dnl with or without modifications, as long as this notice is preserved.

dnl From Bruno Haible.

dnl AC_LIB_ARG_WITH is synonymous to AC_ARG_WITH in autoconf-2.13, and
dnl similar to AC_ARG_WITH in autoconf 2.52...2.57 except that is doesn't
dnl require excessive bracketing.
ifdef([AC_HELP_STRING],
[AC_DEFUN([AC_LIB_ARG_WITH], [AC_ARG_WITH([$1],[[$2]],[$3],[$4])])],
[AC_DEFUN([AC_][LIB_ARG_WITH], [AC_ARG_WITH([$1],[$2],[$3],[$4])])])

dnl AC_LIB_PREFIX adds to the CPPFLAGS and LDFLAGS the flags that are needed
dnl to access previously installed libraries. The basic assumption is that
dnl a user will want packages to use other packages he previously installed
dnl with the same --prefix option.
dnl This macro is not needed if only AC_LIB_LINKFLAGS is used to locate
dnl libraries, but is otherwise very convenient.
AC_DEFUN([AC_LIB_PREFIX],
[
  AC_BEFORE([$0], [AC_LIB_LINKFLAGS])
  AC_REQUIRE([AC_PROG_CC])
  AC_REQUIRE([AC_CANONICAL_HOST])
  AC_REQUIRE([AC_LIB_PREPARE_MULTILIB])
  AC_REQUIRE([AC_LIB_PREPARE_PREFIX])
  dnl By default, look in $includedir and $libdir.
  use_additional=yes
  AC_LIB_WITH_FINAL_PREFIX([
    eval additional_includedir=\"$includedir\"
    eval additional_libdir=\"$libdir\"
  ])
  AC_LIB_ARG_WITH([lib-prefix],
[  --with-lib-prefix[=DIR] search for libraries in DIR/include and DIR/lib
  --without-lib-prefix    don't search for libraries in includedir and libdir],
[
    if test "X$withval" = "Xno"; then
      use_additional=no
    else
      if test "X$withval" = "X"; then
        AC_LIB_WITH_FINAL_PREFIX([
          eval additional_includedir=\"$includedir\"
          eval additional_libdir=\"$libdir\"
        ])
      else
        additional_includedir="$withval/include"
        additional_libdir="$withval/$acl_libdirstem"
      fi
    fi
])
  if test $use_additional = yes; then
    dnl Potentially add $additional_includedir to $CPPFLAGS.
    dnl But don't add it
    dnl   1. if it's the standard /usr/include,
    dnl   2. if it's already present in $CPPFLAGS,
    dnl   3. if it's /usr/local/include and we are using GCC on Linux,
    dnl   4. if it doesn't exist as a directory.
    if test "X$additional_includedir" != "X/usr/include"; then
      haveit=
      for x in $CPPFLAGS; do
        AC_LIB_WITH_FINAL_PREFIX([eval x=\"$x\"])
        if test "X$x" = "X-I$additional_includedir"; then
          haveit=yes
          break
        fi
      done
      if test -z "$haveit"; then
        if test "X$additional_includedir" = "X/usr/local/include"; then
          if test -n "$GCC"; then
            case $host_os in
              linux* | gnu* | k*bsd*-gnu) haveit=yes;;
            esac
          fi
        fi
        if test -z "$haveit"; then
          if test -d "$additional_includedir"; then
            dnl Really add $additional_includedir to $CPPFLAGS.
            CPPFLAGS="${CPPFLAGS}${CPPFLAGS:+ }-I$additional_includedir"
          fi
        fi
      fi
    fi
    dnl Potentially add $additional_libdir to $LDFLAGS.
    dnl But don't add it
    dnl   1. if it's the standard /usr/lib,
    dnl   2. if it's already present in $LDFLAGS,
    dnl   3. if it's /usr/local/lib and we are using GCC on Linux,
    dnl   4. if it doesn't exist as a directory.
    if test "X$additional_libdir" != "X/usr/$acl_libdirstem"; then
      haveit=
      for x in $LDFLAGS; do
        AC_LIB_WITH_FINAL_PREFIX([eval x=\"$x\"])
        if test "X$x" = "X-L$additional_libdir"; then
          haveit=yes
          break
        fi
      done
      if test -z "$haveit"; then
        if test "X$additional_libdir" = "X/usr/local/$acl_libdirstem"; then
          if test -n "$GCC"; then
            case $host_os in
              linux*) haveit=yes;;
            esac
          fi
        fi
        if test -z "$haveit"; then
          if test -d "$additional_libdir"; then
            dnl Really add $additional_libdir to $LDFLAGS.
            LDFLAGS="${LDFLAGS}${LDFLAGS:+ }-L$additional_libdir"
          fi
        fi
      fi
    fi
  fi
])

dnl AC_LIB_PREPARE_PREFIX creates variables acl_final_prefix,
dnl acl_final_exec_prefix, containing the values to which $prefix and
dnl $exec_prefix will expand at the end of the configure script.
AC_DEFUN([AC_LIB_PREPARE_PREFIX],
[
  dnl Unfortunately, prefix and exec_prefix get only finally determined
  dnl at the end of configure.
  if test "X$prefix" = "XNONE"; then
    acl_final_prefix="$ac_default_prefix"
  else
    acl_final_prefix="$prefix"
  fi
  if test "X$exec_prefix" = "XNONE"; then
    acl_final_exec_prefix='${prefix}'
  else
    acl_final_exec_prefix="$exec_prefix"
  fi
  acl_save_prefix="$prefix"
  prefix="$acl_final_prefix"
  eval acl_final_exec_prefix=\"$acl_final_exec_prefix\"
  prefix="$acl_save_prefix"
])

dnl AC_LIB_WITH_FINAL_PREFIX([statement]) evaluates statement, with the
dnl variables prefix and exec_prefix bound to the values they will have
dnl at the end of the configure script.
AC_DEFUN([AC_LIB_WITH_FINAL_PREFIX],
[
  acl_save_prefix="$prefix"
  prefix="$acl_final_prefix"
  acl_save_exec_prefix="$exec_prefix"
  exec_prefix="$acl_final_exec_prefix"
  $1
  exec_prefix="$acl_save_exec_prefix"
  prefix="$acl_save_prefix"
])

dnl AC_LIB_PREPARE_MULTILIB creates a variable acl_libdirstem, containing
dnl the basename of the libdir, either "lib" or "lib64".
AC_DEFUN([AC_LIB_PREPARE_MULTILIB],
[
  dnl There is no formal standard regarding lib and lib64. The current
  dnl practice is that on a system supporting 32-bit and 64-bit instruction
  dnl sets or ABIs, 64-bit libraries go under $prefix/lib64 and 32-bit
  dnl libraries go under $prefix/lib. We determine the compiler's default
  dnl mode by looking at the compiler's library search path. If at least
  dnl of its elements ends in /lib64 or points to a directory whose absolute
  dnl pathname ends in /lib64, we assume a 64-bit ABI. Otherwise we use the
  dnl default, namely "lib".
  acl_libdirstem=lib
  searchpath=`(LC_ALL=C $CC -print-search-dirs) 2>/dev/null | sed -n -e 's,^libraries: ,,p' | sed -e 's,^=,,'`
  if test -n "$searchpath"; then
    acl_save_IFS="${IFS= 	}"; IFS=":"
    for searchdir in $searchpath; do
      if test -d "$searchdir"; then
        case "$searchdir" in
          */lib64/ | */lib64 ) acl_libdirstem=lib64 ;;
          *) searchdir=`cd "$searchdir" && pwd`
             case "$searchdir" in
               */lib64 ) acl_libdirstem=lib64 ;;
             esac ;;
        esac
      fi
    done
    IFS="$acl_save_IFS"
  fi
])

# nls.m4 serial 3 (gettext-0.15)
dnl Copyright (C) 1995-2003, 2005-2006 Free Software Foundation, Inc.
dnl This file is free software; the Free Software Foundation
dnl gives unlimited permission to copy and/or distribute it,
dnl with or without modifications, as long as this notice is preserved.
dnl
dnl This file can can be used in projects which are not available under
dnl the GNU General Public License or the GNU Library General Public
dnl License but which still want to provide support for the GNU gettext
dnl functionality.
dnl Please note that the actual code of the GNU gettext library is covered
dnl by the GNU Library General Public License, and the rest of the GNU
dnl gettext package package is covered by the GNU General Public License.
dnl They are *not* in the public domain.

dnl Authors:
dnl   Ulrich Drepper <drepper@cygnus.com>, 1995-2000.
dnl   Bruno Haible <haible@clisp.cons.org>, 2000-2003.

AC_PREREQ(2.50)

AC_DEFUN([AM_NLS],
[
  AC_MSG_CHECKING([whether NLS is requested])
  dnl Default is enabled NLS
  AC_ARG_ENABLE(nls,
    [  --disable-nls           do not use Native Language Support],
    USE_NLS=$enableval, USE_NLS=yes)
  AC_MSG_RESULT($USE_NLS)
  AC_SUBST(USE_NLS)
])

# po.m4 serial 13 (gettext-0.15)
dnl Copyright (C) 1995-2006 Free Software Foundation, Inc.
dnl This file is free software; the Free Software Foundation
dnl gives unlimited permission to copy and/or distribute it,
dnl with or without modifications, as long as this notice is preserved.
dnl
dnl This file can can be used in projects which are not available under
dnl the GNU General Public License or the GNU Library General Public
dnl License but which still want to provide support for the GNU gettext
dnl functionality.
dnl Please note that the actual code of the GNU gettext library is covered
dnl by the GNU Library General Public License, and the rest of the GNU
dnl gettext package package is covered by the GNU General Public License.
dnl They are *not* in the public domain.

dnl Authors:
dnl   Ulrich Drepper <drepper@cygnus.com>, 1995-2000.
dnl   Bruno Haible <haible@clisp.cons.org>, 2000-2003.

AC_PREREQ(2.50)

dnl Checks for all prerequisites of the po subdirectory.
AC_DEFUN([AM_PO_SUBDIRS],
[
  AC_REQUIRE([AC_PROG_MAKE_SET])dnl
  AC_REQUIRE([AC_PROG_INSTALL])dnl
  AC_REQUIRE([AM_PROG_MKDIR_P])dnl defined by automake
  AC_REQUIRE([AM_NLS])dnl

  dnl Perform the following tests also if --disable-nls has been given,
  dnl because they are needed for "make dist" to work.

  dnl Search for GNU msgfmt in the PATH.
  dnl The first test excludes Solaris msgfmt and early GNU msgfmt versions.
  dnl The second test excludes FreeBSD msgfmt.
  AM_PATH_PROG_WITH_TEST(MSGFMT, msgfmt,
    [$ac_dir/$ac_word --statistics /dev/null >&]AS_MESSAGE_LOG_FD[ 2>&1 &&
     (if $ac_dir/$ac_word --statistics /dev/null 2>&1 >/dev/null | grep usage >/dev/null; then exit 1; else exit 0; fi)],
    :)
  AC_PATH_PROG(GMSGFMT, gmsgfmt, $MSGFMT)

  dnl Test whether it is GNU msgfmt >= 0.15.
changequote(,)dnl
  case `$MSGFMT --version | sed 1q | sed -e 's,^[^0-9]*,,'` in
    '' | 0.[0-9] | 0.[0-9].* | 0.1[0-4] | 0.1[0-4].*) MSGFMT_015=: ;;
    *) MSGFMT_015=$MSGFMT ;;
  esac
changequote([,])dnl
  AC_SUBST([MSGFMT_015])
changequote(,)dnl
  case `$GMSGFMT --version | sed 1q | sed -e 's,^[^0-9]*,,'` in
    '' | 0.[0-9] | 0.[0-9].* | 0.1[0-4] | 0.1[0-4].*) GMSGFMT_015=: ;;
    *) GMSGFMT_015=$GMSGFMT ;;
  esac
changequote([,])dnl
  AC_SUBST([GMSGFMT_015])

  dnl Search for GNU xgettext 0.12 or newer in the PATH.
  dnl The first test excludes Solaris xgettext and early GNU xgettext versions.
  dnl The second test excludes FreeBSD xgettext.
  AM_PATH_PROG_WITH_TEST(XGETTEXT, xgettext,
    [$ac_dir/$ac_word --omit-header --copyright-holder= --msgid-bugs-address= /dev/null >&]AS_MESSAGE_LOG_FD[ 2>&1 &&
     (if $ac_dir/$ac_word --omit-header --copyright-holder= --msgid-bugs-address= /dev/null 2>&1 >/dev/null | grep usage >/dev/null; then exit 1; else exit 0; fi)],
    :)
  dnl Remove leftover from FreeBSD xgettext call.
  rm -f messages.po

  dnl Test whether it is GNU xgettext >= 0.15.
changequote(,)dnl
  case `$XGETTEXT --version | sed 1q | sed -e 's,^[^0-9]*,,'` in
    '' | 0.[0-9] | 0.[0-9].* | 0.1[0-4] | 0.1[0-4].*) XGETTEXT_015=: ;;
    *) XGETTEXT_015=$XGETTEXT ;;
  esac
changequote([,])dnl
  AC_SUBST([XGETTEXT_015])

  dnl Search for GNU msgmerge 0.11 or newer in the PATH.
  AM_PATH_PROG_WITH_TEST(MSGMERGE, msgmerge,
    [$ac_dir/$ac_word --update -q /dev/null /dev/null >&]AS_MESSAGE_LOG_FD[ 2>&1], :)

  dnl Installation directories.
  dnl Autoconf >= 2.60 defines localedir. For older versions of autoconf, we
  dnl have to define it here, so that it can be used in po/Makefile.
  test -n "$localedir" || localedir='${datadir}/locale'
  AC_SUBST([localedir])

  AC_CONFIG_COMMANDS([po-directories], [[
    for ac_file in $CONFIG_FILES; do
      # Support "outfile[:infile[:infile...]]"
      case "$ac_file" in
        *:*) ac_file=`echo "$ac_file"|sed 's%:.*%%'` ;;
      esac
      # PO directories have a Makefile.in generated from Makefile.in.in.
      case "$ac_file" in */Makefile.in)
        # Adjust a relative srcdir.
        ac_dir=`echo "$ac_file"|sed 's%/[^/][^/]*$%%'`
        ac_dir_suffix="/`echo "$ac_dir"|sed 's%^\./%%'`"
        ac_dots=`echo "$ac_dir_suffix"|sed 's%/[^/]*%../%g'`
        # In autoconf-2.13 it is called $ac_given_srcdir.
        # In autoconf-2.50 it is called $srcdir.
        test -n "$ac_given_srcdir" || ac_given_srcdir="$srcdir"
        case "$ac_given_srcdir" in
          .)  top_srcdir=`echo $ac_dots|sed 's%/$%%'` ;;
          /*) top_srcdir="$ac_given_srcdir" ;;
          *)  top_srcdir="$ac_dots$ac_given_srcdir" ;;
        esac
        # Treat a directory as a PO directory if and only if it has a
        # POTFILES.in file. This allows packages to have multiple PO
        # directories under different names or in different locations.
        if test -f "$ac_given_srcdir/$ac_dir/POTFILES.in"; then
          rm -f "$ac_dir/POTFILES"
          test -n "$as_me" && echo "$as_me: creating $ac_dir/POTFILES" || echo "creating $ac_dir/POTFILES"
          cat "$ac_given_srcdir/$ac_dir/POTFILES.in" | sed -e "/^#/d" -e "/^[ 	]*\$/d" -e "s,.*,     $top_srcdir/& \\\\," | sed -e "\$s/\(.*\) \\\\/\1/" > "$ac_dir/POTFILES"
          POMAKEFILEDEPS="POTFILES.in"
          # ALL_LINGUAS, POFILES, UPDATEPOFILES, DUMMYPOFILES, GMOFILES depend
          # on $ac_dir but don't depend on user-specified configuration
          # parameters.
          if test -f "$ac_given_srcdir/$ac_dir/LINGUAS"; then
            # The LINGUAS file contains the set of available languages.
            if test -n "$OBSOLETE_ALL_LINGUAS"; then
              test -n "$as_me" && echo "$as_me: setting ALL_LINGUAS in configure.in is obsolete" || echo "setting ALL_LINGUAS in configure.in is obsolete"
            fi
            ALL_LINGUAS_=`sed -e "/^#/d" -e "s/#.*//" "$ac_given_srcdir/$ac_dir/LINGUAS"`
            # Hide the ALL_LINGUAS assigment from automake < 1.5.
            eval 'ALL_LINGUAS''=$ALL_LINGUAS_'
            POMAKEFILEDEPS="$POMAKEFILEDEPS LINGUAS"
          else
            # The set of available languages was given in configure.in.
            # Hide the ALL_LINGUAS assigment from automake < 1.5.
            eval 'ALL_LINGUAS''=$OBSOLETE_ALL_LINGUAS'
          fi
          # Compute POFILES
          # as      $(foreach lang, $(ALL_LINGUAS), $(srcdir)/$(lang).po)
          # Compute UPDATEPOFILES
          # as      $(foreach lang, $(ALL_LINGUAS), $(lang).po-update)
          # Compute DUMMYPOFILES
          # as      $(foreach lang, $(ALL_LINGUAS), $(lang).nop)
          # Compute GMOFILES
          # as      $(foreach lang, $(ALL_LINGUAS), $(srcdir)/$(lang).gmo)
          case "$ac_given_srcdir" in
            .) srcdirpre= ;;
            *) srcdirpre='$(srcdir)/' ;;
          esac
          POFILES=
          UPDATEPOFILES=
          DUMMYPOFILES=
          GMOFILES=
          for lang in $ALL_LINGUAS; do
            POFILES="$POFILES $srcdirpre$lang.po"
            UPDATEPOFILES="$UPDATEPOFILES $lang.po-update"
            DUMMYPOFILES="$DUMMYPOFILES $lang.nop"
            GMOFILES="$GMOFILES $srcdirpre$lang.gmo"
          done
          # CATALOGS depends on both $ac_dir and the user's LINGUAS
          # environment variable.
          INST_LINGUAS=
          if test -n "$ALL_LINGUAS"; then
            for presentlang in $ALL_LINGUAS; do
              useit=no
              if test "%UNSET%" != "$LINGUAS"; then
                desiredlanguages="$LINGUAS"
              else
                desiredlanguages="$ALL_LINGUAS"
              fi
              for desiredlang in $desiredlanguages; do
                # Use the presentlang catalog if desiredlang is
                #   a. equal to presentlang, or
                #   b. a variant of presentlang (because in this case,
                #      presentlang can be used as a fallback for messages
                #      which are not translated in the desiredlang catalog).
                case "$desiredlang" in
                  "$presentlang"*) useit=yes;;
                esac
              done
              if test $useit = yes; then
                INST_LINGUAS="$INST_LINGUAS $presentlang"
              fi
            done
          fi
          CATALOGS=
          if test -n "$INST_LINGUAS"; then
            for lang in $INST_LINGUAS; do
              CATALOGS="$CATALOGS $lang.gmo"
            done
          fi
          test -n "$as_me" && echo "$as_me: creating $ac_dir/Makefile" || echo "creating $ac_dir/Makefile"
          sed -e "/^POTFILES =/r $ac_dir/POTFILES" -e "/^# Makevars/r $ac_given_srcdir/$ac_dir/Makevars" -e "s|@POFILES@|$POFILES|g" -e "s|@UPDATEPOFILES@|$UPDATEPOFILES|g" -e "s|@DUMMYPOFILES@|$DUMMYPOFILES|g" -e "s|@GMOFILES@|$GMOFILES|g" -e "s|@CATALOGS@|$CATALOGS|g" -e "s|@POMAKEFILEDEPS@|$POMAKEFILEDEPS|g" "$ac_dir/Makefile.in" > "$ac_dir/Makefile"
          for f in "$ac_given_srcdir/$ac_dir"/Rules-*; do
            if test -f "$f"; then
              case "$f" in
                *.orig | *.bak | *~) ;;
                *) cat "$f" >> "$ac_dir/Makefile" ;;
              esac
            fi
          done
        fi
        ;;
      esac
    done]],
   [# Capture the value of obsolete ALL_LINGUAS because we need it to compute
    # POFILES, UPDATEPOFILES, DUMMYPOFILES, GMOFILES, CATALOGS. But hide it
    # from automake < 1.5.
    eval 'OBSOLETE_ALL_LINGUAS''="$ALL_LINGUAS"'
    # Capture the value of LINGUAS because we need it to compute CATALOGS.
    LINGUAS="${LINGUAS-%UNSET%}"
   ])
])

dnl Postprocesses a Makefile in a directory containing PO files.
AC_DEFUN([AM_POSTPROCESS_PO_MAKEFILE],
[
  # When this code is run, in config.status, two variables have already been
  # set:
  # - OBSOLETE_ALL_LINGUAS is the value of LINGUAS set in configure.in,
  # - LINGUAS is the value of the environment variable LINGUAS at configure
  #   time.

changequote(,)dnl
  # Adjust a relative srcdir.
  ac_dir=`echo "$ac_file"|sed 's%/[^/][^/]*$%%'`
  ac_dir_suffix="/`echo "$ac_dir"|sed 's%^\./%%'`"
  ac_dots=`echo "$ac_dir_suffix"|sed 's%/[^/]*%../%g'`
  # In autoconf-2.13 it is called $ac_given_srcdir.
  # In autoconf-2.50 it is called $srcdir.
  test -n "$ac_given_srcdir" || ac_given_srcdir="$srcdir"
  case "$ac_given_srcdir" in
    .)  top_srcdir=`echo $ac_dots|sed 's%/$%%'` ;;
    /*) top_srcdir="$ac_given_srcdir" ;;
    *)  top_srcdir="$ac_dots$ac_given_srcdir" ;;
  esac

  # Find a way to echo strings without interpreting backslash.
  if test "X`(echo '\t') 2>/dev/null`" = 'X\t'; then
    gt_echo='echo'
  else
    if test "X`(printf '%s\n' '\t') 2>/dev/null`" = 'X\t'; then
      gt_echo='printf %s\n'
    else
      echo_func () {
        cat <<EOT
$*
EOT
      }
      gt_echo='echo_func'
    fi
  fi

  # A sed script that extracts the value of VARIABLE from a Makefile.
  sed_x_variable='
# Test if the hold space is empty.
x
s/P/P/
x
ta
# Yes it was empty. Look if we have the expected variable definition.
/^[	 ]*VARIABLE[	 ]*=/{
  # Seen the first line of the variable definition.
  s/^[	 ]*VARIABLE[	 ]*=//
  ba
}
bd
:a
# Here we are processing a line from the variable definition.
# Remove comment, more precisely replace it with a space.
s/#.*$/ /
# See if the line ends in a backslash.
tb
:b
s/\\$//
# Print the line, without the trailing backslash.
p
tc
# There was no trailing backslash. The end of the variable definition is
# reached. Clear the hold space.
s/^.*$//
x
bd
:c
# A trailing backslash means that the variable definition continues in the
# next line. Put a nonempty string into the hold space to indicate this.
s/^.*$/P/
x
:d
'
changequote([,])dnl

  # Set POTFILES to the value of the Makefile variable POTFILES.
  sed_x_POTFILES=`$gt_echo "$sed_x_variable" | sed -e '/^ *#/d' -e 's/VARIABLE/POTFILES/g'`
  POTFILES=`sed -n -e "$sed_x_POTFILES" < "$ac_file"`
  # Compute POTFILES_DEPS as
  #   $(foreach file, $(POTFILES), $(top_srcdir)/$(file))
  POTFILES_DEPS=
  for file in $POTFILES; do
    POTFILES_DEPS="$POTFILES_DEPS "'$(top_srcdir)/'"$file"
  done
  POMAKEFILEDEPS=""

  if test -n "$OBSOLETE_ALL_LINGUAS"; then
    test -n "$as_me" && echo "$as_me: setting ALL_LINGUAS in configure.in is obsolete" || echo "setting ALL_LINGUAS in configure.in is obsolete"
  fi
  if test -f "$ac_given_srcdir/$ac_dir/LINGUAS"; then
    # The LINGUAS file contains the set of available languages.
    ALL_LINGUAS_=`sed -e "/^#/d" -e "s/#.*//" "$ac_given_srcdir/$ac_dir/LINGUAS"`
    POMAKEFILEDEPS="$POMAKEFILEDEPS LINGUAS"
  else
    # Set ALL_LINGUAS to the value of the Makefile variable LINGUAS.
    sed_x_LINGUAS=`$gt_echo "$sed_x_variable" | sed -e '/^ *#/d' -e 's/VARIABLE/LINGUAS/g'`
    ALL_LINGUAS_=`sed -n -e "$sed_x_LINGUAS" < "$ac_file"`
  fi
  # Hide the ALL_LINGUAS assigment from automake < 1.5.
  eval 'ALL_LINGUAS''=$ALL_LINGUAS_'
  # Compute POFILES
  # as      $(foreach lang, $(ALL_LINGUAS), $(srcdir)/$(lang).po)
  # Compute UPDATEPOFILES
  # as      $(foreach lang, $(ALL_LINGUAS), $(lang).po-update)
  # Compute DUMMYPOFILES
  # as      $(foreach lang, $(ALL_LINGUAS), $(lang).nop)
  # Compute GMOFILES
  # as      $(foreach lang, $(ALL_LINGUAS), $(srcdir)/$(lang).gmo)
  # Compute PROPERTIESFILES
  # as      $(foreach lang, $(ALL_LINGUAS), $(top_srcdir)/$(DOMAIN)_$(lang).properties)
  # Compute CLASSFILES
  # as      $(foreach lang, $(ALL_LINGUAS), $(top_srcdir)/$(DOMAIN)_$(lang).class)
  # Compute QMFILES
  # as      $(foreach lang, $(ALL_LINGUAS), $(srcdir)/$(lang).qm)
  # Compute MSGFILES
  # as      $(foreach lang, $(ALL_LINGUAS), $(srcdir)/$(frob $(lang)).msg)
  # Compute RESOURCESDLLFILES
  # as      $(foreach lang, $(ALL_LINGUAS), $(srcdir)/$(frob $(lang))/$(DOMAIN).resources.dll)
  case "$ac_given_srcdir" in
    .) srcdirpre= ;;
    *) srcdirpre='$(srcdir)/' ;;
  esac
  POFILES=
  UPDATEPOFILES=
  DUMMYPOFILES=
  GMOFILES=
  PROPERTIESFILES=
  CLASSFILES=
  QMFILES=
  MSGFILES=
  RESOURCESDLLFILES=
  for lang in $ALL_LINGUAS; do
    POFILES="$POFILES $srcdirpre$lang.po"
    UPDATEPOFILES="$UPDATEPOFILES $lang.po-update"
    DUMMYPOFILES="$DUMMYPOFILES $lang.nop"
    GMOFILES="$GMOFILES $srcdirpre$lang.gmo"
    PROPERTIESFILES="$PROPERTIESFILES \$(top_srcdir)/\$(DOMAIN)_$lang.properties"
    CLASSFILES="$CLASSFILES \$(top_srcdir)/\$(DOMAIN)_$lang.class"
    QMFILES="$QMFILES $srcdirpre$lang.qm"
    frobbedlang=`echo $lang | sed -e 's/\..*$//' -e 'y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'`
    MSGFILES="$MSGFILES $srcdirpre$frobbedlang.msg"
    frobbedlang=`echo $lang | sed -e 's/_/-/g' -e 's/^sr-CS/sr-SP/' -e 's/@latin$/-Latn/' -e 's/@cyrillic$/-Cyrl/' -e 's/^sr-SP$/sr-SP-Latn/' -e 's/^uz-UZ$/uz-UZ-Latn/'`
    RESOURCESDLLFILES="$RESOURCESDLLFILES $srcdirpre$frobbedlang/\$(DOMAIN).resources.dll"
  done
  # CATALOGS depends on both $ac_dir and the user's LINGUAS
  # environment variable.
  INST_LINGUAS=
  if test -n "$ALL_LINGUAS"; then
    for presentlang in $ALL_LINGUAS; do
      useit=no
      if test "%UNSET%" != "$LINGUAS"; then
        desiredlanguages="$LINGUAS"
      else
        desiredlanguages="$ALL_LINGUAS"
      fi
      for desiredlang in $desiredlanguages; do
        # Use the presentlang catalog if desiredlang is
        #   a. equal to presentlang, or
        #   b. a variant of presentlang (because in this case,
        #      presentlang can be used as a fallback for messages
        #      which are not translated in the desiredlang catalog).
        case "$desiredlang" in
          "$presentlang"*) useit=yes;;
        esac
      done
      if test $useit = yes; then
        INST_LINGUAS="$INST_LINGUAS $presentlang"
      fi
    done
  fi
  CATALOGS=
  JAVACATALOGS=
  QTCATALOGS=
  TCLCATALOGS=
  CSHARPCATALOGS=
  if test -n "$INST_LINGUAS"; then
    for lang in $INST_LINGUAS; do
      CATALOGS="$CATALOGS $lang.gmo"
      JAVACATALOGS="$JAVACATALOGS \$(DOMAIN)_$lang.properties"
      QTCATALOGS="$QTCATALOGS $lang.qm"
      frobbedlang=`echo $lang | sed -e 's/\..*$//' -e 'y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'`
      TCLCATALOGS="$TCLCATALOGS $frobbedlang.msg"
      frobbedlang=`echo $lang | sed -e 's/_/-/g' -e 's/^sr-CS/sr-SP/' -e 's/@latin$/-Latn/' -e 's/@cyrillic$/-Cyrl/' -e 's/^sr-SP$/sr-SP-Latn/' -e 's/^uz-UZ$/uz-UZ-Latn/'`
      CSHARPCATALOGS="$CSHARPCATALOGS $frobbedlang/\$(DOMAIN).resources.dll"
    done
  fi

  sed -e "s|@POTFILES_DEPS@|$POTFILES_DEPS|g" -e "s|@POFILES@|$POFILES|g" -e "s|@UPDATEPOFILES@|$UPDATEPOFILES|g" -e "s|@DUMMYPOFILES@|$DUMMYPOFILES|g" -e "s|@GMOFILES@|$GMOFILES|g" -e "s|@PROPERTIESFILES@|$PROPERTIESFILES|g" -e "s|@CLASSFILES@|$CLASSFILES|g" -e "s|@QMFILES@|$QMFILES|g" -e "s|@MSGFILES@|$MSGFILES|g" -e "s|@RESOURCESDLLFILES@|$RESOURCESDLLFILES|g" -e "s|@CATALOGS@|$CATALOGS|g" -e "s|@JAVACATALOGS@|$JAVACATALOGS|g" -e "s|@QTCATALOGS@|$QTCATALOGS|g" -e "s|@TCLCATALOGS@|$TCLCATALOGS|g" -e "s|@CSHARPCATALOGS@|$CSHARPCATALOGS|g" -e 's,^#distdir:,distdir:,' < "$ac_file" > "$ac_file.tmp"
  if grep -l '@TCLCATALOGS@' "$ac_file" > /dev/null; then
    # Add dependencies that cannot be formulated as a simple suffix rule.
    for lang in $ALL_LINGUAS; do
      frobbedlang=`echo $lang | sed -e 's/\..*$//' -e 'y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'`
      cat >> "$ac_file.tmp" <<EOF
$frobbedlang.msg: $lang.po
	@echo "\$(MSGFMT) -c --tcl -d \$(srcdir) -l $lang $srcdirpre$lang.po"; \
	\$(MSGFMT) -c --tcl -d "\$(srcdir)" -l $lang $srcdirpre$lang.po || { rm -f "\$(srcdir)/$frobbedlang.msg"; exit 1; }
EOF
    done
  fi
  if grep -l '@CSHARPCATALOGS@' "$ac_file" > /dev/null; then
    # Add dependencies that cannot be formulated as a simple suffix rule.
    for lang in $ALL_LINGUAS; do
      frobbedlang=`echo $lang | sed -e 's/_/-/g' -e 's/^sr-CS/sr-SP/' -e 's/@latin$/-Latn/' -e 's/@cyrillic$/-Cyrl/' -e 's/^sr-SP$/sr-SP-Latn/' -e 's/^uz-UZ$/uz-UZ-Latn/'`
      cat >> "$ac_file.tmp" <<EOF
$frobbedlang/\$(DOMAIN).resources.dll: $lang.po
	@echo "\$(MSGFMT) -c --csharp -d \$(srcdir) -l $lang $srcdirpre$lang.po -r \$(DOMAIN)"; \
	\$(MSGFMT) -c --csharp -d "\$(srcdir)" -l $lang $srcdirpre$lang.po -r "\$(DOMAIN)" || { rm -f "\$(srcdir)/$frobbedlang.msg"; exit 1; }
EOF
    done
  fi
  if test -n "$POMAKEFILEDEPS"; then
    cat >> "$ac_file.tmp" <<EOF
Makefile: $POMAKEFILEDEPS
EOF
  fi
  mv "$ac_file.tmp" "$ac_file"
])

# progtest.m4 serial 4 (gettext-0.14.2)
dnl Copyright (C) 1996-2003, 2005 Free Software Foundation, Inc.
dnl This file is free software; the Free Software Foundation
dnl gives unlimited permission to copy and/or distribute it,
dnl with or without modifications, as long as this notice is preserved.
dnl
dnl This file can can be used in projects which are not available under
dnl the GNU General Public License or the GNU Library General Public
dnl License but which still want to provide support for the GNU gettext
dnl functionality.
dnl Please note that the actual code of the GNU gettext library is covered
dnl by the GNU Library General Public License, and the rest of the GNU
dnl gettext package package is covered by the GNU General Public License.
dnl They are *not* in the public domain.

dnl Authors:
dnl   Ulrich Drepper <drepper@cygnus.com>, 1996.

AC_PREREQ(2.50)

# Search path for a program which passes the given test.

dnl AM_PATH_PROG_WITH_TEST(VARIABLE, PROG-TO-CHECK-FOR,
dnl   TEST-PERFORMED-ON-FOUND_PROGRAM [, VALUE-IF-NOT-FOUND [, PATH]])
AC_DEFUN([AM_PATH_PROG_WITH_TEST],
[
# Prepare PATH_SEPARATOR.
# The user is always right.
if test "${PATH_SEPARATOR+set}" != set; then
  echo "#! /bin/sh" >conf$$.sh
  echo  "exit 0"   >>conf$$.sh
  chmod +x conf$$.sh
  if (PATH="/nonexistent;."; conf$$.sh) >/dev/null 2>&1; then
    PATH_SEPARATOR=';'
  else
    PATH_SEPARATOR=:
  fi
  rm -f conf$$.sh
fi

# Find out how to test for executable files. Don't use a zero-byte file,
# as systems may use methods other than mode bits to determine executability.
cat >conf$$.file <<_ASEOF
#! /bin/sh
exit 0
_ASEOF
chmod +x conf$$.file
if test -x conf$$.file >/dev/null 2>&1; then
  ac_executable_p="test -x"
else
  ac_executable_p="test -f"
fi
rm -f conf$$.file

# Extract the first word of "$2", so it can be a program name with args.
set dummy $2; ac_word=[$]2
AC_MSG_CHECKING([for $ac_word])
AC_CACHE_VAL(ac_cv_path_$1,
[case "[$]$1" in
  [[\\/]]* | ?:[[\\/]]*)
    ac_cv_path_$1="[$]$1" # Let the user override the test with a path.
    ;;
  *)
    ac_save_IFS="$IFS"; IFS=$PATH_SEPARATOR
    for ac_dir in ifelse([$5], , $PATH, [$5]); do
      IFS="$ac_save_IFS"
      test -z "$ac_dir" && ac_dir=.
      for ac_exec_ext in '' $ac_executable_extensions; do
        if $ac_executable_p "$ac_dir/$ac_word$ac_exec_ext"; then
          echo "$as_me: trying $ac_dir/$ac_word..." >&AS_MESSAGE_LOG_FD
          if [$3]; then
            ac_cv_path_$1="$ac_dir/$ac_word$ac_exec_ext"
            break 2
          fi
        fi
      done
    done
    IFS="$ac_save_IFS"
dnl If no 4th arg is given, leave the cache variable unset,
dnl so AC_PATH_PROGS will keep looking.
ifelse([$4], , , [  test -z "[$]ac_cv_path_$1" && ac_cv_path_$1="$4"
])dnl
    ;;
esac])dnl
$1="$ac_cv_path_$1"
if test ifelse([$4], , [-n "[$]$1"], ["[$]$1" != "$4"]); then
  AC_MSG_RESULT([$]$1)
else
  AC_MSG_RESULT(no)
fi
AC_SUBST($1)dnl
])

# Copyright (C) 2002, 2003, 2005  Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# AM_AUTOMAKE_VERSION(VERSION)
# ----------------------------
# Automake X.Y traces this macro to ensure aclocal.m4 has been
# generated from the m4 files accompanying Automake X.Y.
AC_DEFUN([AM_AUTOMAKE_VERSION], [am__api_version="1.9"])

# AM_SET_CURRENT_AUTOMAKE_VERSION
# -------------------------------
# Call AM_AUTOMAKE_VERSION so it can be traced.
# This function is AC_REQUIREd by AC_INIT_AUTOMAKE.
AC_DEFUN([AM_SET_CURRENT_AUTOMAKE_VERSION],
	 [AM_AUTOMAKE_VERSION([1.9.6])])

# AM_AUX_DIR_EXPAND                                         -*- Autoconf -*-

# Copyright (C) 2001, 2003, 2005  Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# For projects using AC_CONFIG_AUX_DIR([foo]), Autoconf sets
# $ac_aux_dir to `$srcdir/foo'.  In other projects, it is set to
# `$srcdir', `$srcdir/..', or `$srcdir/../..'.
#
# Of course, Automake must honor this variable whenever it calls a
# tool from the auxiliary directory.  The problem is that $srcdir (and
# therefore $ac_aux_dir as well) can be either absolute or relative,
# depending on how configure is run.  This is pretty annoying, since
# it makes $ac_aux_dir quite unusable in subdirectories: in the top
# source directory, any form will work fine, but in subdirectories a
# relative path needs to be adjusted first.
#
# $ac_aux_dir/missing
#    fails when called from a subdirectory if $ac_aux_dir is relative
# $top_srcdir/$ac_aux_dir/missing
#    fails if $ac_aux_dir is absolute,
#    fails when called from a subdirectory in a VPATH build with
#          a relative $ac_aux_dir
#
# The reason of the latter failure is that $top_srcdir and $ac_aux_dir
# are both prefixed by $srcdir.  In an in-source build this is usually
# harmless because $srcdir is `.', but things will broke when you
# start a VPATH build or use an absolute $srcdir.
#
# So we could use something similar to $top_srcdir/$ac_aux_dir/missing,
# iff we strip the leading $srcdir from $ac_aux_dir.  That would be:
#   am_aux_dir='\$(top_srcdir)/'`expr "$ac_aux_dir" : "$srcdir//*\(.*\)"`
# and then we would define $MISSING as
#   MISSING="\${SHELL} $am_aux_dir/missing"
# This will work as long as MISSING is not called from configure, because
# unfortunately $(top_srcdir) has no meaning in configure.
# However there are other variables, like CC, which are often used in
# configure, and could therefore not use this "fixed" $ac_aux_dir.
#
# Another solution, used here, is to always expand $ac_aux_dir to an
# absolute PATH.  The drawback is that using absolute paths prevent a
# configured tree to be moved without reconfiguration.

AC_DEFUN([AM_AUX_DIR_EXPAND],
[dnl Rely on autoconf to set up CDPATH properly.
AC_PREREQ([2.50])dnl
# expand $ac_aux_dir to an absolute path
am_aux_dir=`cd $ac_aux_dir && pwd`
])

# AM_CONDITIONAL                                            -*- Autoconf -*-

# Copyright (C) 1997, 2000, 2001, 2003, 2004, 2005
# Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# serial 7

# AM_CONDITIONAL(NAME, SHELL-CONDITION)
# -------------------------------------
# Define a conditional.
AC_DEFUN([AM_CONDITIONAL],
[AC_PREREQ(2.52)dnl
 ifelse([$1], [TRUE],  [AC_FATAL([$0: invalid condition: $1])],
	[$1], [FALSE], [AC_FATAL([$0: invalid condition: $1])])dnl
AC_SUBST([$1_TRUE])
AC_SUBST([$1_FALSE])
if $2; then
  $1_TRUE=
  $1_FALSE='#'
else
  $1_TRUE='#'
  $1_FALSE=
fi
AC_CONFIG_COMMANDS_PRE(
[if test -z "${$1_TRUE}" && test -z "${$1_FALSE}"; then
  AC_MSG_ERROR([[conditional "$1" was never defined.
Usually this means the macro was only invoked conditionally.]])
fi])])


# Copyright (C) 1999, 2000, 2001, 2002, 2003, 2004, 2005
# Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# serial 8

# There are a few dirty hacks below to avoid letting `AC_PROG_CC' be
# written in clear, in which case automake, when reading aclocal.m4,
# will think it sees a *use*, and therefore will trigger all it's
# C support machinery.  Also note that it means that autoscan, seeing
# CC etc. in the Makefile, will ask for an AC_PROG_CC use...


# _AM_DEPENDENCIES(NAME)
# ----------------------
# See how the compiler implements dependency checking.
# NAME is "CC", "CXX", "GCJ", or "OBJC".
# We try a few techniques and use that to set a single cache variable.
#
# We don't AC_REQUIRE the corresponding AC_PROG_CC since the latter was
# modified to invoke _AM_DEPENDENCIES(CC); we would have a circular
# dependency, and given that the user is not expected to run this macro,
# just rely on AC_PROG_CC.
AC_DEFUN([_AM_DEPENDENCIES],
[AC_REQUIRE([AM_SET_DEPDIR])dnl
AC_REQUIRE([AM_OUTPUT_DEPENDENCY_COMMANDS])dnl
AC_REQUIRE([AM_MAKE_INCLUDE])dnl
AC_REQUIRE([AM_DEP_TRACK])dnl

ifelse([$1], CC,   [depcc="$CC"   am_compiler_list=],
       [$1], CXX,  [depcc="$CXX"  am_compiler_list=],
       [$1], OBJC, [depcc="$OBJC" am_compiler_list='gcc3 gcc'],
       [$1], GCJ,  [depcc="$GCJ"  am_compiler_list='gcc3 gcc'],
                   [depcc="$$1"   am_compiler_list=])

AC_CACHE_CHECK([dependency style of $depcc],
               [am_cv_$1_dependencies_compiler_type],
[if test -z "$AMDEP_TRUE" && test -f "$am_depcomp"; then
  # We make a subdir and do the tests there.  Otherwise we can end up
  # making bogus files that we don't know about and never remove.  For
  # instance it was reported that on HP-UX the gcc test will end up
  # making a dummy file named `D' -- because `-MD' means `put the output
  # in D'.
  mkdir conftest.dir
  # Copy depcomp to subdir because otherwise we won't find it if we're
  # using a relative directory.
  cp "$am_depcomp" conftest.dir
  cd conftest.dir
  # We will build objects and dependencies in a subdirectory because
  # it helps to detect inapplicable dependency modes.  For instance
  # both Tru64's cc and ICC support -MD to output dependencies as a
  # side effect of compilation, but ICC will put the dependencies in
  # the current directory while Tru64 will put them in the object
  # directory.
  mkdir sub

  am_cv_$1_dependencies_compiler_type=none
  if test "$am_compiler_list" = ""; then
     am_compiler_list=`sed -n ['s/^#*\([a-zA-Z0-9]*\))$/\1/p'] < ./depcomp`
  fi
  for depmode in $am_compiler_list; do
    # Setup a source with many dependencies, because some compilers
    # like to wrap large dependency lists on column 80 (with \), and
    # we should not choose a depcomp mode which is confused by this.
    #
    # We need to recreate these files for each test, as the compiler may
    # overwrite some of them when testing with obscure command lines.
    # This happens at least with the AIX C compiler.
    : > sub/conftest.c
    for i in 1 2 3 4 5 6; do
      echo '#include "conftst'$i'.h"' >> sub/conftest.c
      # Using `: > sub/conftst$i.h' creates only sub/conftst1.h with
      # Solaris 8's {/usr,}/bin/sh.
      touch sub/conftst$i.h
    done
    echo "${am__include} ${am__quote}sub/conftest.Po${am__quote}" > confmf

    case $depmode in
    nosideeffect)
      # after this tag, mechanisms are not by side-effect, so they'll
      # only be used when explicitly requested
      if test "x$enable_dependency_tracking" = xyes; then
	continue
      else
	break
      fi
      ;;
    none) break ;;
    esac
    # We check with `-c' and `-o' for the sake of the "dashmstdout"
    # mode.  It turns out that the SunPro C++ compiler does not properly
    # handle `-M -o', and we need to detect this.
    if depmode=$depmode \
       source=sub/conftest.c object=sub/conftest.${OBJEXT-o} \
       depfile=sub/conftest.Po tmpdepfile=sub/conftest.TPo \
       $SHELL ./depcomp $depcc -c -o sub/conftest.${OBJEXT-o} sub/conftest.c \
         >/dev/null 2>conftest.err &&
       grep sub/conftst6.h sub/conftest.Po > /dev/null 2>&1 &&
       grep sub/conftest.${OBJEXT-o} sub/conftest.Po > /dev/null 2>&1 &&
       ${MAKE-make} -s -f confmf > /dev/null 2>&1; then
      # icc doesn't choke on unknown options, it will just issue warnings
      # or remarks (even with -Werror).  So we grep stderr for any message
      # that says an option was ignored or not supported.
      # When given -MP, icc 7.0 and 7.1 complain thusly:
      #   icc: Command line warning: ignoring option '-M'; no argument required
      # The diagnosis changed in icc 8.0:
      #   icc: Command line remark: option '-MP' not supported
      if (grep 'ignoring option' conftest.err ||
          grep 'not supported' conftest.err) >/dev/null 2>&1; then :; else
        am_cv_$1_dependencies_compiler_type=$depmode
        break
      fi
    fi
  done

  cd ..
  rm -rf conftest.dir
else
  am_cv_$1_dependencies_compiler_type=none
fi
])
AC_SUBST([$1DEPMODE], [depmode=$am_cv_$1_dependencies_compiler_type])
AM_CONDITIONAL([am__fastdep$1], [
  test "x$enable_dependency_tracking" != xno \
  && test "$am_cv_$1_dependencies_compiler_type" = gcc3])
])


# AM_SET_DEPDIR
# -------------
# Choose a directory name for dependency files.
# This macro is AC_REQUIREd in _AM_DEPENDENCIES
AC_DEFUN([AM_SET_DEPDIR],
[AC_REQUIRE([AM_SET_LEADING_DOT])dnl
AC_SUBST([DEPDIR], ["${am__leading_dot}deps"])dnl
])


# AM_DEP_TRACK
# ------------
AC_DEFUN([AM_DEP_TRACK],
[AC_ARG_ENABLE(dependency-tracking,
[  --disable-dependency-tracking  speeds up one-time build
  --enable-dependency-tracking   do not reject slow dependency extractors])
if test "x$enable_dependency_tracking" != xno; then
  am_depcomp="$ac_aux_dir/depcomp"
  AMDEPBACKSLASH='\'
fi
AM_CONDITIONAL([AMDEP], [test "x$enable_dependency_tracking" != xno])
AC_SUBST([AMDEPBACKSLASH])
])

# Generate code to set up dependency tracking.              -*- Autoconf -*-

# Copyright (C) 1999, 2000, 2001, 2002, 2003, 2004, 2005
# Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

#serial 3

# _AM_OUTPUT_DEPENDENCY_COMMANDS
# ------------------------------
AC_DEFUN([_AM_OUTPUT_DEPENDENCY_COMMANDS],
[for mf in $CONFIG_FILES; do
  # Strip MF so we end up with the name of the file.
  mf=`echo "$mf" | sed -e 's/:.*$//'`
  # Check whether this is an Automake generated Makefile or not.
  # We used to match only the files named `Makefile.in', but
  # some people rename them; so instead we look at the file content.
  # Grep'ing the first line is not enough: some people post-process
  # each Makefile.in and add a new line on top of each file to say so.
  # So let's grep whole file.
  if grep '^#.*generated by automake' $mf > /dev/null 2>&1; then
    dirpart=`AS_DIRNAME("$mf")`
  else
    continue
  fi
  # Extract the definition of DEPDIR, am__include, and am__quote
  # from the Makefile without running `make'.
  DEPDIR=`sed -n 's/^DEPDIR = //p' < "$mf"`
  test -z "$DEPDIR" && continue
  am__include=`sed -n 's/^am__include = //p' < "$mf"`
  test -z "am__include" && continue
  am__quote=`sed -n 's/^am__quote = //p' < "$mf"`
  # When using ansi2knr, U may be empty or an underscore; expand it
  U=`sed -n 's/^U = //p' < "$mf"`
  # Find all dependency output files, they are included files with
  # $(DEPDIR) in their names.  We invoke sed twice because it is the
  # simplest approach to changing $(DEPDIR) to its actual value in the
  # expansion.
  for file in `sed -n "
    s/^$am__include $am__quote\(.*(DEPDIR).*\)$am__quote"'$/\1/p' <"$mf" | \
       sed -e 's/\$(DEPDIR)/'"$DEPDIR"'/g' -e 's/\$U/'"$U"'/g'`; do
    # Make sure the directory exists.
    test -f "$dirpart/$file" && continue
    fdir=`AS_DIRNAME(["$file"])`
    AS_MKDIR_P([$dirpart/$fdir])
    # echo "creating $dirpart/$file"
    echo '# dummy' > "$dirpart/$file"
  done
done
])# _AM_OUTPUT_DEPENDENCY_COMMANDS


# AM_OUTPUT_DEPENDENCY_COMMANDS
# -----------------------------
# This macro should only be invoked once -- use via AC_REQUIRE.
#
# This code is only required when automatic dependency tracking
# is enabled.  FIXME.  This creates each `.P' file that we will
# need in order to bootstrap the dependency handling code.
AC_DEFUN([AM_OUTPUT_DEPENDENCY_COMMANDS],
[AC_CONFIG_COMMANDS([depfiles],
     [test x"$AMDEP_TRUE" != x"" || _AM_OUTPUT_DEPENDENCY_COMMANDS],
     [AMDEP_TRUE="$AMDEP_TRUE" ac_aux_dir="$ac_aux_dir"])
])

# Copyright (C) 1996, 1997, 2000, 2001, 2003, 2005
# Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# serial 8

# AM_CONFIG_HEADER is obsolete.  It has been replaced by AC_CONFIG_HEADERS.
AU_DEFUN([AM_CONFIG_HEADER], [AC_CONFIG_HEADERS($@)])

# Do all the work for Automake.                             -*- Autoconf -*-

# Copyright (C) 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005
# Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# serial 12

# This macro actually does too much.  Some checks are only needed if
# your package does certain things.  But this isn't really a big deal.

# AM_INIT_AUTOMAKE(PACKAGE, VERSION, [NO-DEFINE])
# AM_INIT_AUTOMAKE([OPTIONS])
# -----------------------------------------------
# The call with PACKAGE and VERSION arguments is the old style
# call (pre autoconf-2.50), which is being phased out.  PACKAGE
# and VERSION should now be passed to AC_INIT and removed from
# the call to AM_INIT_AUTOMAKE.
# We support both call styles for the transition.  After
# the next Automake release, Autoconf can make the AC_INIT
# arguments mandatory, and then we can depend on a new Autoconf
# release and drop the old call support.
AC_DEFUN([AM_INIT_AUTOMAKE],
[AC_PREREQ([2.58])dnl
dnl Autoconf wants to disallow AM_ names.  We explicitly allow
dnl the ones we care about.
m4_pattern_allow([^AM_[A-Z]+FLAGS$])dnl
AC_REQUIRE([AM_SET_CURRENT_AUTOMAKE_VERSION])dnl
AC_REQUIRE([AC_PROG_INSTALL])dnl
# test to see if srcdir already configured
if test "`cd $srcdir && pwd`" != "`pwd`" &&
   test -f $srcdir/config.status; then
  AC_MSG_ERROR([source directory already configured; run "make distclean" there first])
fi

# test whether we have cygpath
if test -z "$CYGPATH_W"; then
  if (cygpath --version) >/dev/null 2>/dev/null; then
    CYGPATH_W='cygpath -w'
  else
    CYGPATH_W=echo
  fi
fi
AC_SUBST([CYGPATH_W])

# Define the identity of the package.
dnl Distinguish between old-style and new-style calls.
m4_ifval([$2],
[m4_ifval([$3], [_AM_SET_OPTION([no-define])])dnl
 AC_SUBST([PACKAGE], [$1])dnl
 AC_SUBST([VERSION], [$2])],
[_AM_SET_OPTIONS([$1])dnl
 AC_SUBST([PACKAGE], ['AC_PACKAGE_TARNAME'])dnl
 AC_SUBST([VERSION], ['AC_PACKAGE_VERSION'])])dnl

_AM_IF_OPTION([no-define],,
[AC_DEFINE_UNQUOTED(PACKAGE, "$PACKAGE", [Name of package])
 AC_DEFINE_UNQUOTED(VERSION, "$VERSION", [Version number of package])])dnl

# Some tools Automake needs.
AC_REQUIRE([AM_SANITY_CHECK])dnl
AC_REQUIRE([AC_ARG_PROGRAM])dnl
AM_MISSING_PROG(ACLOCAL, aclocal-${am__api_version})
AM_MISSING_PROG(AUTOCONF, autoconf)
AM_MISSING_PROG(AUTOMAKE, automake-${am__api_version})
AM_MISSING_PROG(AUTOHEADER, autoheader)
AM_MISSING_PROG(MAKEINFO, makeinfo)
AM_PROG_INSTALL_SH
AM_PROG_INSTALL_STRIP
AC_REQUIRE([AM_PROG_MKDIR_P])dnl
# We need awk for the "check" target.  The system "awk" is bad on
# some platforms.
AC_REQUIRE([AC_PROG_AWK])dnl
AC_REQUIRE([AC_PROG_MAKE_SET])dnl
AC_REQUIRE([AM_SET_LEADING_DOT])dnl
_AM_IF_OPTION([tar-ustar], [_AM_PROG_TAR([ustar])],
              [_AM_IF_OPTION([tar-pax], [_AM_PROG_TAR([pax])],
	      		     [_AM_PROG_TAR([v7])])])
_AM_IF_OPTION([no-dependencies],,
[AC_PROVIDE_IFELSE([AC_PROG_CC],
                  [_AM_DEPENDENCIES(CC)],
                  [define([AC_PROG_CC],
                          defn([AC_PROG_CC])[_AM_DEPENDENCIES(CC)])])dnl
AC_PROVIDE_IFELSE([AC_PROG_CXX],
                  [_AM_DEPENDENCIES(CXX)],
                  [define([AC_PROG_CXX],
                          defn([AC_PROG_CXX])[_AM_DEPENDENCIES(CXX)])])dnl
])
])


# When config.status generates a header, we must update the stamp-h file.
# This file resides in the same directory as the config header
# that is generated.  The stamp files are numbered to have different names.

# Autoconf calls _AC_AM_CONFIG_HEADER_HOOK (when defined) in the
# loop where config.status creates the headers, so we can generate
# our stamp files there.
AC_DEFUN([_AC_AM_CONFIG_HEADER_HOOK],
[# Compute $1's index in $config_headers.
_am_stamp_count=1
for _am_header in $config_headers :; do
  case $_am_header in
    $1 | $1:* )
      break ;;
    * )
      _am_stamp_count=`expr $_am_stamp_count + 1` ;;
  esac
done
echo "timestamp for $1" >`AS_DIRNAME([$1])`/stamp-h[]$_am_stamp_count])

# Copyright (C) 2001, 2003, 2005  Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# AM_PROG_INSTALL_SH
# ------------------
# Define $install_sh.
AC_DEFUN([AM_PROG_INSTALL_SH],
[AC_REQUIRE([AM_AUX_DIR_EXPAND])dnl
install_sh=${install_sh-"$am_aux_dir/install-sh"}
AC_SUBST(install_sh)])

# Copyright (C) 2003, 2005  Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# serial 2

# Check whether the underlying file-system supports filenames
# with a leading dot.  For instance MS-DOS doesn't.
AC_DEFUN([AM_SET_LEADING_DOT],
[rm -rf .tst 2>/dev/null
mkdir .tst 2>/dev/null
if test -d .tst; then
  am__leading_dot=.
else
  am__leading_dot=_
fi
rmdir .tst 2>/dev/null
AC_SUBST([am__leading_dot])])

# Check to see how 'make' treats includes.	            -*- Autoconf -*-

# Copyright (C) 2001, 2002, 2003, 2005  Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# serial 3

# AM_MAKE_INCLUDE()
# -----------------
# Check to see how make treats includes.
AC_DEFUN([AM_MAKE_INCLUDE],
[am_make=${MAKE-make}
cat > confinc << 'END'
am__doit:
	@echo done
.PHONY: am__doit
END
# If we don't find an include directive, just comment out the code.
AC_MSG_CHECKING([for style of include used by $am_make])
am__include="#"
am__quote=
_am_result=none
# First try GNU make style include.
echo "include confinc" > confmf
# We grep out `Entering directory' and `Leaving directory'
# messages which can occur if `w' ends up in MAKEFLAGS.
# In particular we don't look at `^make:' because GNU make might
# be invoked under some other name (usually "gmake"), in which
# case it prints its new name instead of `make'.
if test "`$am_make -s -f confmf 2> /dev/null | grep -v 'ing directory'`" = "done"; then
   am__include=include
   am__quote=
   _am_result=GNU
fi
# Now try BSD make style include.
if test "$am__include" = "#"; then
   echo '.include "confinc"' > confmf
   if test "`$am_make -s -f confmf 2> /dev/null`" = "done"; then
      am__include=.include
      am__quote="\""
      _am_result=BSD
   fi
fi
AC_SUBST([am__include])
AC_SUBST([am__quote])
AC_MSG_RESULT([$_am_result])
rm -f confinc confmf
])

# Fake the existence of programs that GNU maintainers use.  -*- Autoconf -*-

# Copyright (C) 1997, 1999, 2000, 2001, 2003, 2005
# Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# serial 4

# AM_MISSING_PROG(NAME, PROGRAM)
# ------------------------------
AC_DEFUN([AM_MISSING_PROG],
[AC_REQUIRE([AM_MISSING_HAS_RUN])
$1=${$1-"${am_missing_run}$2"}
AC_SUBST($1)])


# AM_MISSING_HAS_RUN
# ------------------
# Define MISSING if not defined so far and test if it supports --run.
# If it does, set am_missing_run to use it, otherwise, to nothing.
AC_DEFUN([AM_MISSING_HAS_RUN],
[AC_REQUIRE([AM_AUX_DIR_EXPAND])dnl
test x"${MISSING+set}" = xset || MISSING="\${SHELL} $am_aux_dir/missing"
# Use eval to expand $SHELL
if eval "$MISSING --run true"; then
  am_missing_run="$MISSING --run "
else
  am_missing_run=
  AC_MSG_WARN([`missing' script is too old or missing])
fi
])

# Copyright (C) 2003, 2004, 2005  Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# AM_PROG_MKDIR_P
# ---------------
# Check whether `mkdir -p' is supported, fallback to mkinstalldirs otherwise.
#
# Automake 1.8 used `mkdir -m 0755 -p --' to ensure that directories
# created by `make install' are always world readable, even if the
# installer happens to have an overly restrictive umask (e.g. 077).
# This was a mistake.  There are at least two reasons why we must not
# use `-m 0755':
#   - it causes special bits like SGID to be ignored,
#   - it may be too restrictive (some setups expect 775 directories).
#
# Do not use -m 0755 and let people choose whatever they expect by
# setting umask.
#
# We cannot accept any implementation of `mkdir' that recognizes `-p'.
# Some implementations (such as Solaris 8's) are not thread-safe: if a
# parallel make tries to run `mkdir -p a/b' and `mkdir -p a/c'
# concurrently, both version can detect that a/ is missing, but only
# one can create it and the other will error out.  Consequently we
# restrict ourselves to GNU make (using the --version option ensures
# this.)
AC_DEFUN([AM_PROG_MKDIR_P],
[if mkdir -p --version . >/dev/null 2>&1 && test ! -d ./--version; then
  # We used to keeping the `.' as first argument, in order to
  # allow $(mkdir_p) to be used without argument.  As in
  #   $(mkdir_p) $(somedir)
  # where $(somedir) is conditionally defined.  However this is wrong
  # for two reasons:
  #  1. if the package is installed by a user who cannot write `.'
  #     make install will fail,
  #  2. the above comment should most certainly read
  #     $(mkdir_p) $(DESTDIR)$(somedir)
  #     so it does not work when $(somedir) is undefined and
  #     $(DESTDIR) is not.
  #  To support the latter case, we have to write
  #     test -z "$(somedir)" || $(mkdir_p) $(DESTDIR)$(somedir),
  #  so the `.' trick is pointless.
  mkdir_p='mkdir -p --'
else
  # On NextStep and OpenStep, the `mkdir' command does not
  # recognize any option.  It will interpret all options as
  # directories to create, and then abort because `.' already
  # exists.
  for d in ./-p ./--version;
  do
    test -d $d && rmdir $d
  done
  # $(mkinstalldirs) is defined by Automake if mkinstalldirs exists.
  if test -f "$ac_aux_dir/mkinstalldirs"; then
    mkdir_p='$(mkinstalldirs)'
  else
    mkdir_p='$(install_sh) -d'
  fi
fi
AC_SUBST([mkdir_p])])

# Helper functions for option handling.                     -*- Autoconf -*-

# Copyright (C) 2001, 2002, 2003, 2005  Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# serial 3

# _AM_MANGLE_OPTION(NAME)
# -----------------------
AC_DEFUN([_AM_MANGLE_OPTION],
[[_AM_OPTION_]m4_bpatsubst($1, [[^a-zA-Z0-9_]], [_])])

# _AM_SET_OPTION(NAME)
# ------------------------------
# Set option NAME.  Presently that only means defining a flag for this option.
AC_DEFUN([_AM_SET_OPTION],
[m4_define(_AM_MANGLE_OPTION([$1]), 1)])

# _AM_SET_OPTIONS(OPTIONS)
# ----------------------------------
# OPTIONS is a space-separated list of Automake options.
AC_DEFUN([_AM_SET_OPTIONS],
[AC_FOREACH([_AM_Option], [$1], [_AM_SET_OPTION(_AM_Option)])])

# _AM_IF_OPTION(OPTION, IF-SET, [IF-NOT-SET])
# -------------------------------------------
# Execute IF-SET if OPTION is set, IF-NOT-SET otherwise.
AC_DEFUN([_AM_IF_OPTION],
[m4_ifset(_AM_MANGLE_OPTION([$1]), [$2], [$3])])

# Check to make sure that the build environment is sane.    -*- Autoconf -*-

# Copyright (C) 1996, 1997, 2000, 2001, 2003, 2005
# Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# serial 4

# AM_SANITY_CHECK
# ---------------
AC_DEFUN([AM_SANITY_CHECK],
[AC_MSG_CHECKING([whether build environment is sane])
# Just in case
sleep 1
echo timestamp > conftest.file
# Do `set' in a subshell so we don't clobber the current shell's
# arguments.  Must try -L first in case configure is actually a
# symlink; some systems play weird games with the mod time of symlinks
# (eg FreeBSD returns the mod time of the symlink's containing
# directory).
if (
   set X `ls -Lt $srcdir/configure conftest.file 2> /dev/null`
   if test "$[*]" = "X"; then
      # -L didn't work.
      set X `ls -t $srcdir/configure conftest.file`
   fi
   rm -f conftest.file
   if test "$[*]" != "X $srcdir/configure conftest.file" \
      && test "$[*]" != "X conftest.file $srcdir/configure"; then

      # If neither matched, then we have a broken ls.  This can happen
      # if, for instance, CONFIG_SHELL is bash and it inherits a
      # broken ls alias from the environment.  This has actually
      # happened.  Such a system could not be considered "sane".
      AC_MSG_ERROR([ls -t appears to fail.  Make sure there is not a broken
alias in your environment])
   fi

   test "$[2]" = conftest.file
   )
then
   # Ok.
   :
else
   AC_MSG_ERROR([newly created file is older than distributed files!
Check your system clock])
fi
AC_MSG_RESULT(yes)])

# Copyright (C) 2001, 2003, 2005  Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# AM_PROG_INSTALL_STRIP
# ---------------------
# One issue with vendor `install' (even GNU) is that you can't
# specify the program used to strip binaries.  This is especially
# annoying in cross-compiling environments, where the build's strip
# is unlikely to handle the host's binaries.
# Fortunately install-sh will honor a STRIPPROG variable, so we
# always use install-sh in `make install-strip', and initialize
# STRIPPROG with the value of the STRIP variable (set by the user).
AC_DEFUN([AM_PROG_INSTALL_STRIP],
[AC_REQUIRE([AM_PROG_INSTALL_SH])dnl
# Installed binaries are usually stripped using `strip' when the user
# run `make install-strip'.  However `strip' might not be the right
# tool to use in cross-compilation environments, therefore Automake
# will honor the `STRIP' environment variable to overrule this program.
dnl Don't test for $cross_compiling = yes, because it might be `maybe'.
if test "$cross_compiling" != no; then
  AC_CHECK_TOOL([STRIP], [strip], :)
fi
INSTALL_STRIP_PROGRAM="\${SHELL} \$(install_sh) -c -s"
AC_SUBST([INSTALL_STRIP_PROGRAM])])

# Check how to create a tarball.                            -*- Autoconf -*-

# Copyright (C) 2004, 2005  Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# serial 2

# _AM_PROG_TAR(FORMAT)
# --------------------
# Check how to create a tarball in format FORMAT.
# FORMAT should be one of `v7', `ustar', or `pax'.
#
# Substitute a variable $(am__tar) that is a command
# writing to stdout a FORMAT-tarball containing the directory
# $tardir.
#     tardir=directory && $(am__tar) > result.tar
#
# Substitute a variable $(am__untar) that extract such
# a tarball read from stdin.
#     $(am__untar) < result.tar
AC_DEFUN([_AM_PROG_TAR],
[# Always define AMTAR for backward compatibility.
AM_MISSING_PROG([AMTAR], [tar])
m4_if([$1], [v7],
     [am__tar='${AMTAR} chof - "$$tardir"'; am__untar='${AMTAR} xf -'],
     [m4_case([$1], [ustar],, [pax],,
              [m4_fatal([Unknown tar format])])
AC_MSG_CHECKING([how to create a $1 tar archive])
# Loop over all known methods to create a tar archive until one works.
_am_tools='gnutar m4_if([$1], [ustar], [plaintar]) pax cpio none'
_am_tools=${am_cv_prog_tar_$1-$_am_tools}
# Do not fold the above two line into one, because Tru64 sh and
# Solaris sh will not grok spaces in the rhs of `-'.
for _am_tool in $_am_tools
do
  case $_am_tool in
  gnutar)
    for _am_tar in tar gnutar gtar;
    do
      AM_RUN_LOG([$_am_tar --version]) && break
    done
    am__tar="$_am_tar --format=m4_if([$1], [pax], [posix], [$1]) -chf - "'"$$tardir"'
    am__tar_="$_am_tar --format=m4_if([$1], [pax], [posix], [$1]) -chf - "'"$tardir"'
    am__untar="$_am_tar -xf -"
    ;;
  plaintar)
    # Must skip GNU tar: if it does not support --format= it doesn't create
    # ustar tarball either.
    (tar --version) >/dev/null 2>&1 && continue
    am__tar='tar chf - "$$tardir"'
    am__tar_='tar chf - "$tardir"'
    am__untar='tar xf -'
    ;;
  pax)
    am__tar='pax -L -x $1 -w "$$tardir"'
    am__tar_='pax -L -x $1 -w "$tardir"'
    am__untar='pax -r'
    ;;
  cpio)
    am__tar='find "$$tardir" -print | cpio -o -H $1 -L'
    am__tar_='find "$tardir" -print | cpio -o -H $1 -L'
    am__untar='cpio -i -H $1 -d'
    ;;
  none)
    am__tar=false
    am__tar_=false
    am__untar=false
    ;;
  esac

  # If the value was cached, stop now.  We just wanted to have am__tar
  # and am__untar set.
  test -n "${am_cv_prog_tar_$1}" && break

  # tar/untar a dummy directory, and stop if the command works
  rm -rf conftest.dir
  mkdir conftest.dir
  echo GrepMe > conftest.dir/file
  AM_RUN_LOG([tardir=conftest.dir && eval $am__tar_ >conftest.tar])
  rm -rf conftest.dir
  if test -s conftest.tar; then
    AM_RUN_LOG([$am__untar <conftest.tar])
    grep GrepMe conftest.dir/file >/dev/null 2>&1 && break
  fi
done
rm -rf conftest.dir

AC_CACHE_VAL([am_cv_prog_tar_$1], [am_cv_prog_tar_$1=$_am_tool])
AC_MSG_RESULT([$am_cv_prog_tar_$1])])
AC_SUBST([am__tar])
AC_SUBST([am__untar])
]) # _AM_PROG_TAR

m4_include([gl/m4/absolute-header.m4])
m4_include([gl/m4/alloca.m4])
m4_include([gl/m4/eoverflow.m4])
m4_include([gl/m4/gnulib-comp.m4])
m4_include([gl/m4/intmax_t.m4])
m4_include([gl/m4/inttypes_h.m4])
m4_include([gl/m4/longdouble.m4])
m4_include([gl/m4/longlong.m4])
m4_include([gl/m4/onceonly_2_57.m4])
m4_include([gl/m4/size_max.m4])
m4_include([gl/m4/snprintf.m4])
m4_include([gl/m4/stdint_h.m4])
m4_include([gl/m4/stdio_h.m4])
m4_include([gl/m4/vasnprintf.m4])
m4_include([gl/m4/wchar_t.m4])
m4_include([gl/m4/wint_t.m4])
m4_include([gl/m4/xsize.m4])
