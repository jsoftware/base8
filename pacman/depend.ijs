NB. depend

NB. =========================================================
NB. getdepend
NB. add dependencies to gui install
getdepend=: 3 : 0
if. 0 = #y do. y return. end.
dep=. <;._1 ; ',' ,each 6{"1 y
ids=. 1{"1 PKGDATA
y, PKGDATA #~ ids e. dep -. 1{"1 y
)

NB. =========================================================
NB. getdepend_console
NB. add dependencies to console install
getdepend_console=: 3 : 0
if. 0 = #y do. y return. end.
ids=. 1{"1 PKGDATA
dep=. <;._1 ; ',' ,each (ids e. y) # 6{"1 PKGDATA
~. y, dep
)
