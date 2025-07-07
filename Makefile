# Makefile for WiringRP

.DEFAULT_GOAL := build

PKG_NAME := wiringrp
VERSION := 1.0.1
DEB_VERSION := $(VERSION)-1

DESTDIR ?=

.PHONY: install uninstall clean deb source binary build

export $(dpkg-architecture -aarm64)

install:
	./build

uninstall:
	./build uninstall

deb:
	@fakeroot dh binary

source:
	@tar -cJf ../$(PKG_NAME)_$(VERSION).orig.tar.xz --exclude=debian ./

binary: deb
build: install

clean:
	./build clean
	@dh_clean

