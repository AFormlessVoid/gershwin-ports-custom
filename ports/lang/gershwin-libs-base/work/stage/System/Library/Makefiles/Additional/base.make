#
#   base.make
#
#   Makefile flags and configs to build with the base library.
#
#   Copyright (C) 2001 Free Software Foundation, Inc.
#
#   Author:  Nicola Pero <n.pero@mi.flashnet.it>
#   Based on code originally in the gnustep make package
#
#   This file is part of the GNUstep Base Library.
#
#   This library is free software; you can redistribute it and/or
#   modify it under the terms of the GNU General Public License
#   as published by the Free Software Foundation; either
#   version 2 of the License, or (at your option) any later version.
#   
#   You should have received a copy of the GNU General Public
#   License along with this library; see the file COPYING.LIB.
#   If not, write to the Free Software Foundation,
#   31 Milk Street #960789 Boston, MA 02196 USA.

ifeq ($(BASE_MAKE_LOADED),)
  BASE_MAKE_LOADED=yes

  ifeq ($(FOUNDATION_LIB),gnu)
    #
    # FIXME - macro names
    #
    AUXILIARY_OBJCFLAGS += -fconstant-string-class=NSConstantString

    ifeq ($(shared),no)
      CONFIG_SYSTEM_LIBS += -lgmp -lavahi-common -lavahi-client  -L/usr/local/lib -lgnutls -L/usr/local/lib -lxslt -lxml2 -L/usr/local/lib -lxml2 -liconv -L/usr/local/lib -lffi -lbfd -lz -lzstd -lrt -ldl  -lpthread -lz -L/usr/local/lib -licui18n -L/usr/local/lib -lcurl
      CONFIG_SYSTEM_LIB_DIR += -fuse-ld= -L/Local/Library/Libraries -L/Network/Library/Libraries -L/System/Library/Libraries
      CONFIG_SYSTEM_INCL +=  -I/Local/Library/Headers -I/Network/Library/Headers -I/System/Library/Headers -I/usr/local/include -O2 -pipe  -fstack-protector-strong -fno-strict-aliasing  -Wno-import -I/usr/local/include -x objective-c -I/usr/local/include -I/usr/local/include/libxml2 -I/usr/local/include -I/usr/local/include/libxml2 -I/usr/local/include -I/usr/local/include/p11-kit-1
    endif

    GNUSTEP_BASE_VERSION = 1.31.1
    GNUSTEP_BASE_MAJOR_VERSION = 1
    GNUSTEP_BASE_MINOR_VERSION = 31
    GNUSTEP_BASE_SUBMINOR_VERSION = 1

    FND_LDFLAGS =
    FND_LIBS = -lgnustep-base
    FND_DEFINE = -DGNUSTEP_BASE_LIBRARY=1
    GNUSTEP_DEFINE = -DGNUSTEP
  else
    #
    # Not using the GNUstep foundation ... must be Apple's
    # So we need to use the base additions library.
    #
    FND_LIBS = -lgnustep-baseadd -framework Foundation
  endif

  # Is the ObjC2 runtime real or emulated?
  # If it's not real, we need to use the emulation ObjectiveC2 headers.
  OBJC2RUNTIME=1
  ifeq ($(OBJC2RUNTIME),0)
    AUXILIARY_OBJCFLAGS += -I$(GNUSTEP_HEADERS)/ObjectiveC2
    AUXILIARY_CFLAGS += -I$(GNUSTEP_HEADERS)/ObjectiveC2
  endif

  # Now we have definitions to show whether important dependencies have
  # been met ... if thse are 0 then some core functionality is missing.

  # Has GNUTLS been found (for TLS/SSL support throughout)?
  GNUSTEP_BASE_HAVE_GNUTLS=1

  # Has libxml2 been found (for NSXMLNode and related classes)?
  GNUSTEP_BASE_HAVE_LIBXML=1

  # Has ICU been found (for NSCalendar, NSLocale, and other locale related)?
  GNUSTEP_BASE_HAVE_ICU=1

  # Has the new KVO implementation been selected.
  GNUSTEP_BASE_HAVE_NEWKVO=1


  # The next two are a special case ... we should have either one defined
  # for netservices.  FIXME ... shouldn't these be combined?

  # Has MDNS been found (one of two options for NSNetServices)?
  GNUSTEP_BASE_HAVE_MDNS=0

  # Has Avahi been found (one of two options for NSNetServices)?
  GNUSTEP_BASE_HAVE_AVAHI=1

  # If we determined that the Objective-C runtime does not support
  # native Objective-C exceptions, turn them off.  This overrides
  # the USE_OBJC_EXCEPTIONS setting in gnustep-make's config.make.
  ifeq (1, 0)
    USE_OBJC_EXCEPTIONS = no
  endif

endif # BASE_MAKE_LOADED
