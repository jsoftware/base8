NB. unxlib
NB.%unxlib.ijs - common shared library for UNIX
NB.-This script defines the common shared library for UNIX and is included in the J standard library.
NB.-Definitions are loaded into the z locale.

18!:4 <'z'

NB. =========================================================
NB.*UNXLIB n table of common shared libraries
NB. pre-built libxml2.so not available in android
UNXLIB=: ([: <;._1 ' ',]);._2 (0 : 0)
libc.so.6 libc.so libc.dylib libc.dylib
libz.so.1 libz.so libz.dylib libz.dylib
libsqlite3.so.0 libsqlite.so libsqlite3.dylib libsqlite3.dylib
libxml2.so.2 libxml2.so libxml2.dylib libxml2.dylib
)

NB. =========================================================
NB.*unxlib v return the name of a shared library.
NB.-example:
NB.+unxlib 'c'
unxlib=: 3 : 0
r=. (;: 'c z sqlite3') i. <,y
c=. IFIOS + (;: 'Linux Android Darwin') i. <UNAME_z_
(<r,c) {:: UNXLIB_z_
)
