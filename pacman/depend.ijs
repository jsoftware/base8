NB. depend

NB. =========================================================
NB. getdepend
NB. add dependencies to gui install
getdepend=: 3 : 0
if. 0 = #y do. y return. end.
dep=. getdepend_console 1{"1 y
y, PKGDATA #~ (1{"1 PKGDATA) e. dep
)

NB. =========================================================
NB. getdepend_console
NB. add dependencies to console install
getdepend_console=: 3 : 0
if. 0 = #y do. y return. end.
old=. ''
ids=. 1{"1 PKGDATA
dep=. 6{"1 PKGDATA
res=. ~. <;._1 ; ',' ,each (ids e. y) # dep
whilst. -. res-:old do.
  old=. res
  res=. ~. res, <;._1 ; ',' ,each (ids e. res) # dep
end.
res -. a:, y, {."1 ADDINS
)
