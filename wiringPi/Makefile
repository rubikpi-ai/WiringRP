#
# Makefile:
#	wiringPi - Wiring Compatable library for the Raspberry Pi
#
#	Copyright (c) 2012-2015 Gordon Henderson
#################################################################################
# This file is part of wiringPi:
#	https://github.com/wiringPi/wiringPi
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

VERSION=$(shell cat ../VERSION)
DESTDIR?=/

LDCONFIG?=ldconfig

ifneq ($V,1)
Q ?= @
endif

STATIC=libwiringPi.a
DYNAMIC=libwiringPi.so.$(VERSION)

#DEBUG	= -g -O0
DEBUG	= -O2
CC	?= gcc
INCLUDE	= -I.
DEFS	= -D_GNU_SOURCE
CFLAGS	= $(DEBUG) $(DEFS) -Wformat=2 -Wall -Wextra -Winline $(INCLUDE) -pipe -fPIC $(EXTRA_CFLAGS)
#CFLAGS	= $(DEBUG) $(DEFS) -Wformat=2 -Wall -Wextra -Wconversion -Winline $(INCLUDE) -pipe -fPIC

LIBS    = -lm -lpthread -lrt -lcrypt

###############################################################################

SRC	=	wiringPi.c						\
		wiringSerial.c wiringShift.c				\
		piHiPri.c piThread.c					\
		wiringPiSPI.c wiringPiI2C.c				\
		softPwm.c softTone.c					\
		mcp23008.c mcp23016.c mcp23017.c			\
		mcp23s08.c mcp23s17.c					\
		sr595.c							\
		pcf8574.c pcf8591.c					\
		mcp3002.c mcp3004.c mcp4802.c mcp3422.c			\
		max31855.c max5322.c ads1115.c				\
		sn3218.c						\
		bmp180.c htu21d.c ds18b20.c rht03.c			\
		drcSerial.c drcNet.c					\
		pseudoPins.c						\
		wpiExtensions.c						\
		wiringPiLegacy.c

HEADERS =	$(shell ls *.h)

OBJ	=	$(SRC:.c=.o)

all:		$(DYNAMIC)

.PHONY:	static
static:	
		$Q cat noMoreStatic

$(DYNAMIC):	$(OBJ)
	$Q echo "[Link (Dynamic)]"
	$Q $(CC) -shared -Wl,-soname,libwiringPi.so$(WIRINGPI_SONAME_SUFFIX) -o libwiringPi.so.$(VERSION) $(OBJ) $(LIBS)

.c.o:
	$Q echo [Compile] $<
	$Q $(CC) -c $(CFLAGS) $< -o $@


.PHONY:	clean
clean:
	$Q echo "[Clean]"
	$Q rm -f $(OBJ) $(OBJ_I2C) *~ core tags Makefile.bak libwiringPi.*

.PHONY:	tags
tags:	$(SRC)
	$Q echo [ctags]
	$Q ctags $(SRC)


.PHONY:	install
install:	$(DYNAMIC)
	$Q echo "[Install Headers]"
	$Q mkdir -p $(DESTDIR)/usr/include
	$Q mkdir -p $(DESTDIR)/usr/lib
	$Q mkdir -p $(DESTDIR)/lib
	$Q install -m 0755 -d						$(DESTDIR)/usr/include
	$Q install -m 0644 $(HEADERS)					$(DESTDIR)/usr/include
	$Q echo "[Install Dynamic Lib]"
	$Q install -m 0755 -d						$(DESTDIR)/usr/lib
	$Q install -m 0755 libwiringPi.so.$(VERSION)			$(DESTDIR)/usr/lib/libwiringPi.so.$(VERSION)
	$Q cd $(DESTDIR)/usr/lib && ln -sf libwiringPi.so.$(VERSION) libwiringPi.so
	$Q cd -
	$Q $(LDCONFIG)

.PHONY: check-deb-destdir
check-deb-destdir:
ifndef DEB_DESTDIR
	$(error DEB_DESTDIR is undefined)
endif

.PHONY:	install-deb
install-deb:	$(DYNAMIC) check-deb-destdir
	$Q echo "[Install Headers: deb]"
	$Q install -m 0755 -d							$(DEB_DESTDIR)/usr/include
	$Q install -m 0644 $(HEADERS)						$(DEB_DESTDIR)/usr/include
	$Q echo "[Install Dynamic Lib: deb]"
	install -m 0755 -d							$(DEB_DESTDIR)/usr/lib
	install -m 0755 libwiringPi.so.$(VERSION)				$(DEB_DESTDIR)/usr/lib/libwiringPi.so.$(VERSION)
	ln -sf $(DEB_DESTDIR)/usr/lib/libwiringPi.so.$(VERSION)	$(DEB_DESTDIR)/usr/lib/libwiringPi.so

.PHONY:	uninstall
uninstall:
	$Q echo "[UnInstall]"
	$Q mkdir -p $(DESTDIR)/usr/include
	$Q mkdir -p $(DESTDIR)/usr/lib
	$Q cd $(DESTDIR)/usr/include/ && rm -f $(HEADERS)
	$Q cd $(DESTDIR)/usr/lib/     && rm -f libwiringPi.*
	$Q $(LDCONFIG)


.PHONY:	depend
depend:
	makedepend -Y $(SRC) $(SRC_I2C)

# DO NOT DELETE

wiringPi.o: softPwm.h softTone.h wiringPi.h ../version.h
wiringSerial.o: wiringSerial.h
wiringShift.o: wiringPi.h wiringShift.h
piHiPri.o: wiringPi.h
piThread.o: wiringPi.h
wiringPiSPI.o: wiringPi.h wiringPiSPI.h
wiringPiI2C.o: wiringPi.h wiringPiI2C.h
softPwm.o: wiringPi.h softPwm.h
softTone.o: wiringPi.h softTone.h
mcp23008.o: wiringPi.h wiringPiI2C.h mcp23x0817.h mcp23008.h
mcp23016.o: wiringPi.h wiringPiI2C.h mcp23016.h mcp23016reg.h
mcp23017.o: wiringPi.h wiringPiI2C.h mcp23x0817.h mcp23017.h
mcp23s08.o: wiringPi.h wiringPiSPI.h mcp23x0817.h mcp23s08.h
mcp23s17.o: wiringPi.h wiringPiSPI.h mcp23x0817.h mcp23s17.h
sr595.o: wiringPi.h sr595.h
pcf8574.o: wiringPi.h wiringPiI2C.h pcf8574.h
pcf8591.o: wiringPi.h wiringPiI2C.h pcf8591.h
mcp3002.o: wiringPi.h wiringPiSPI.h mcp3002.h
mcp3004.o: wiringPi.h wiringPiSPI.h mcp3004.h
mcp4802.o: wiringPi.h wiringPiSPI.h mcp4802.h
mcp3422.o: wiringPi.h wiringPiI2C.h mcp3422.h
max31855.o: wiringPi.h wiringPiSPI.h max31855.h
max5322.o: wiringPi.h wiringPiSPI.h max5322.h
ads1115.o: wiringPi.h wiringPiI2C.h ads1115.h
sn3218.o: wiringPi.h wiringPiI2C.h sn3218.h
bmp180.o: wiringPi.h wiringPiI2C.h bmp180.h
htu21d.o: wiringPi.h wiringPiI2C.h htu21d.h
ds18b20.o: wiringPi.h ds18b20.h
drcSerial.o: wiringPi.h wiringSerial.h drcSerial.h
pseudoPins.o: wiringPi.h pseudoPins.h
wpiExtensions.o: wiringPi.h mcp23008.h mcp23016.h mcp23017.h mcp23s08.h
wpiExtensions.o: mcp23s17.h sr595.h pcf8574.h pcf8591.h mcp3002.h mcp3004.h
wpiExtensions.o: mcp4802.h mcp3422.h max31855.h max5322.h ads1115.h sn3218.h
wpiExtensions.o: drcSerial.h pseudoPins.h bmp180.h htu21d.h ds18b20.h
wpiExtensions.o: wpiExtensions.h
