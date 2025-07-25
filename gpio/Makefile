#
# Makefile:
#	The gpio command:
#	  A swiss-army knige of GPIO shenanigans.
#	https://github.com/wiringPi/wiringPi
#
#	Copyright (c) 2012-2024 Gordon Henderson and contributors
#################################################################################
# This file is part of wiringPi:
#	A "wiring" library for the Raspberry Pi
#
#    wiringPi is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Lesser General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    wiringPi is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Lesser General Public License for more details.
#
#    You should have received a copy of the GNU Lesser General Public License
#    along with wiringPi.  If not, see <http://www.gnu.org/licenses/>.
#################################################################################

DESTDIR?=/

ifneq ($V,1)
Q ?= @
endif

#DEBUG	= -g -O0
DEBUG	= -O2
CC	?= gcc
INCLUDE	= -I$(DESTDIR)/usr/include
CFLAGS	= $(DEBUG) -Wall -Wextra $(INCLUDE) -Winline -pipe $(EXTRA_CFLAGS)

LDFLAGS	= -L$(DESTDIR)/usr/lib
LIBS    = -lwiringPi -lwiringPiDev -lpthread -lrt -lm -lcrypt

# May not need to  alter anything below this line
###############################################################################

SRC	=	gpio.c readall.c

OBJ	=	$(SRC:.c=.o)

all:		gpio

version.h:	../VERSION
	$Q echo Need to run newVersion above.

gpio:	$(OBJ)
	$Q echo [Link]
	$Q $(CC) -o $@ $(OBJ) $(LDFLAGS) $(LIBS)

.c.o:
	$Q echo [Compile] $<
	$Q $(CC) -c $(CFLAGS) $< -o $@

.PHONY:	clean
clean:
	$Q echo "[Clean]"
	$Q rm -f $(OBJ) gpio *~ core tags *.bak

.PHONY:	tags
tags:	$(SRC)
	$Q echo [ctags]
	$Q ctags $(SRC)

.PHONY:	install
install: gpio
	$Q echo "[Install]"
	$Q mkdir -p $(DESTDIR)/usr/bin
	$Q mkdir -p $(DESTDIR)/usr/share/man/man1
	$Q mkdir -p		$(DESTDIR)/usr/bin
	$Q cp gpio		$(DESTDIR)/usr/bin
ifneq ($(WIRINGPI_SUID),0)
	$Q chown root:root	$(DESTDIR)/usr/bin/gpio
	$Q chmod 4755		$(DESTDIR)/usr/bin/gpio
endif
	$Q mkdir -p		$(DESTDIR)/usr/share/man/man1
	$Q cp gpio.1		$(DESTDIR)/usr/share/man/man1

.PHONY: check-deb-destdir
check-deb-destdir:
ifndef DEB_DESTDIR
	$(error DEB_DESTDIR is undefined)
endif

.PHONY:	install-deb
install-deb:	gpio check-deb-destdir
	$Q echo "[Install: deb]"
	$Q install -m 0755 -d							$(DEB_DESTDIR)/usr/bin
	$Q install -m 0755 gpio							$(DEB_DESTDIR)/usr/bin
	$Q install -m 0755 -d							$(DEB_DESTDIR)/usr/share/man/man1
	$Q install -m 0644 gpio.1						$(DEB_DESTDIR)/usr/share/man/man1

.PHONY:	uninstall
uninstall:
	$Q echo "[UnInstall]"
	$Q mkdir -p $(DESTDIR)/usr/bin
	$Q mkdir -p $(DESTDIR)/usr/share/man/man1
	$Q rm -f $(DESTDIR)/usr/bin/gpio
	$Q rm -f $(DESTDIR)/usr/share/man/man1/gpio.1

.PHONY:	depend
depend:
	makedepend -Y $(SRC)

# DO NOT DELETE

gpio.o: ../version.h
