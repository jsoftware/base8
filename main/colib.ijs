NB. class/object library

NB. defines:
NB.
NB. coclass        set co class
NB. cocreate       create object
NB. cocurrent      set current locale
NB. codestroy      destroy current object
NB. coerase        erase object
NB. cofullname     return name with locale qualifier
NB. coinsert       insert into path (before z)
NB. coname         return current co name
NB. conames        formatted co name list
NB. conew          create object
NB. conl           return co name list
NB. copath         set/get co path
NB. coreset        destroy all object locales

18!:4 <'z'

coclass=: 18!:4 @ boxxopen

NB. =========================================================
NB.*cocreate v create object
cocreate=: 18!:3

NB. =========================================================
NB.*cocurrent v set current locale
cocurrent=: 18!:4 @ boxxopen

NB. =========================================================
NB.*codestroy v destroy current object
codestroy=: coerase @ coname

NB. =========================================================
NB.*coerase v erase object
NB. example: coerase <'jzplot'
coerase=: 18!:55

NB. =========================================================
NB.*cofullname v return name with locale qualifier
cofullname=: 3 : 0
y=. ,> y
if. #y do.
  if. ('_' = {: y) +: 1 e. '__' E. y do.
    y,'_',(>18!:5''),'_'
  end.
end.
)

NB. =========================================================
NB.*coinsert v insert into path (before z)
NB.
NB. adds argument and copath of argument to current path.
NB.
NB. paths are in order of argument, except that z is at the end.
NB.   coinsert 'cdir'
NB.   coinsert 'cdir pobj'
NB.   coinsert 'cdir';'pobj'
coinsert=: 3 : 0
n=. ;: :: ] y
p=. ; (, 18!:2) @ < each n
p=. ~. (18!:2 coname''), p
(p /: p = <,'z') 18!:2 coname''
)

NB. =========================================================
NB.*coname v return current co name
coname=: 18!:5

NB. =========================================================
NB.*conames v formatted co name list
conames=: list_z_ @ conl

NB. =========================================================
NB.*conew v create object
conew=: 3 : 0
c=. <y
obj=. cocreate''
coinsert__obj c
COCREATOR__obj=: coname''
obj
:
w=. conew y
create__w x
w
)

NB. =========================================================
NB.*conl v return co name list
NB. form: conl n
NB.   0 e. n  = return named locales
NB.   1 e. n  = return numbered locales
NB.   conl '' = return both, same as conl 0 1
conl=: 18!:1 @ (, 0 1"_ #~ # = 0:)

NB. =========================================================
NB.*copath v set/get co path
copath=: 18!:2 & boxxopen

NB. =========================================================
NB.*coreset v destroy object locales,
coreset=: 3 : 0
0 0$coerase conl 1
)
