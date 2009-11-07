Portmidi-Mapper
===============

This is a small, incomplete wrapper around the portmidi library.

Requirements
============

portmidi (who woulda thought) built as a dynamic library.
ffi gem.


Installing Portmidi on OS X Snow leopard
========================================

This is a major pita, because currently portmidi doesn't officially build for 64 bit, which 
makes it impossible to use with the default Snow Leopard Ruby.

You can try to enable 64 bit support, but I don't have a frekkin clue what this means. It works 
for me and my application, but YMMV and I am not responsible for any damage this does
to you or your system.

To enable 64 bit compilation (you will see quite a few warnings while compiling), open
CMakeLists.txt in the trunk folder and find the following line (around line 39 in my version)

set(CMAKE_OSX_ARCHITECTURES i386 ppc CACHE STRING "do not build for 64-bit" FORCE)

and change it to: (yes, the comment is a bit silly)

set(CMAKE_OSX_ARCHITECTURES i386 ppc x86_64 CACHE STRING "do build for 64-bit" FORCE)

Now you can call

make -f pm_mac/Makefile.osx

if it builds, you can try to install the library. Currently the process seems to be a bit broken, 
so you actually need to type:

sudo env PF=/usr make -f pm_mac/Makefile.osx install

yes, this sucks - I'm currently trying to find out with the portmidi authors what it would take to fix all this.