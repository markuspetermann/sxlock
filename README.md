sxlock - simple X screen locker
===============================

Simple screen locker utility for X, fork of sflock, which is based on slock.
Main difference is that sxlock uses PAM authentication.


Features
--------

 - provides basic user feedback
 - uses PAM
 - sets DPMS timeout to 10 seconds, before exit restores original settings
 - basic RandR support (drawing centered on the primary output)
 - Locks all virtual terminals, needs SUID bit
 - Corrected PAM file to work with debian


Requirements
------------

 - libX11 (Xlib headers)
 - libXext (X11 extensions library, for DPMS)
 - libXrandr (RandR support)
 - libXft
 - PAM


Installation
------------

For manual installation just install dependencies, checkout and make:

```
$ git clone git://github.com/markuspetermann/sxlock.git
$ cd ./sxlock
$ make
$ sudo make install
```


Hooking into systemd events
---------------------------

When using [systemd](http://freedesktop.org/wiki/Software/systemd/), you can use
the following service (create `/lib/systemd/system/lock@.service`) to let the
system lock your X session on hibernation or suspend:

```ini
[Unit]
Description=Lock X session using sxlock
Before=sleep.target

[Service]
User=<username>
Environment=DISPLAY=:0
ExecStart=/usr/bin/sxlock

[Install]
WantedBy=sleep.target
```

This service then needs to be enabled for each user, for user `foo` use
```
$ sudo systemctl enable lock@foo.service
```


Use with openbox
----------------

To use Win + L to lock the screen add the following to rc.xml

```xml
<keybind key="W-l">
  <action name="Execute"><command>sxlock</command></action>
</keybind>
```
