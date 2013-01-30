NB. repos library

RELIBMSG=: 0 : 0
You are now using the XX base library, and can switch to the YY base library.

This will download the YY version of the base library and overwrite existing files. Addons are not affected.

OK to switch to the YY library?
)

NB. =========================================================
prelib=: 3 : 0
old=. LIBTREE
new=. (('stable';'current') i. <old) pick 'current';'beta'
msg=. RELIBMSG rplc ('XX';'YY'),.old;new
if. 0 = query SYSNAME;msg do.
  info 'Not done.' return.
end.
switchlibrary 1 pick new
)

NB. =========================================================
switchlibrary=: 3 : 0
ferase LIBVER
writetree LIBTREE=: y
refreshjal''
readlocal''
pmview_setpn''
)
