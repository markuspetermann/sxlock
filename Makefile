# sxlock - simple X screen locker

NAME = sxlock
VERSION = 20240912-mp

CC := $(CC) -std=c99

base_CFLAGS = -Wall -Wextra -pedantic -O2 -g
base_LIBS = -lpam

pkgs = x11 xext xrandr xft
pkgs_CFLAGS = $(shell pkg-config --cflags $(pkgs))
pkgs_LIBS = $(shell pkg-config --libs $(pkgs))

CPPFLAGS += -DPROGNAME=\"${NAME}\" -DVERSION=\"${VERSION}\" -D_XOPEN_SOURCE=500
CFLAGS := $(base_CFLAGS) $(pkgs_CFLAGS) $(CFLAGS)
LDLIBS := $(base_LIBS) $(pkgs_LIBS)

all: sxlock

sxlock: sxlock.c

clean:
	$(RM) sxlock

install: sxlock
	install -Dm4755 sxlock $(DESTDIR)/usr/bin/sxlock
	install -Dm644 sxlock.pam $(DESTDIR)/etc/pam.d/sxlock
	install -Dm644 'lock@.service' $(DESTDIR)//usr/lib/systemd/system/'lock@.service'
