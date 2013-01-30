NB. unxlib
NB.
NB. common shared library (for UNIX)

NB. nouns:
NB. UNXLIB        table of common shared libraries
NB.
NB. verbs:
NB. unxlib        return the name of a shared library.

18!:4 <'z'

NB. =========================================================
NB. *UNXLIB      n table of common shared libraries
UNXLIB=: ([: <;._1 ' ',]);._2 (0 : 0)
libc.so.6 libc.so libc.dylib libc.dylib
libz.so.1 libz.so libz.dylib libz.dylib
libsqlite3.so.0 libsqlite.so libsqlite3.dylib libsqlite3.dylib
)

NB. =========================================================
NB. *unxlib      v return the name of a shared library.
NB. e.g.   unxlib 'c'
unxlib=: 3 : 0
r=. (;: 'c z sqlite3') i. <,y
c=. IFIOS + (;: 'Linux Android Darwin') i. <UNAME_z_
(<r,c) {:: UNXLIB_z_
)
