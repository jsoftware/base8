NB. class/object utilities

NB. cofind         find objects containing name in object
NB. cofindv        find objects and values of name in object
NB. coinfo         return info on co classes
NB. conouns        nouns referencing object
NB. conounsx       object references with locales
NB. copathnl       path name list
NB. copathnlx      formatted path name list with defining classes
NB. coselect       select current locale
NB. costate        state of class objects

cocurrent 'z'

NB. =========================================================
NB.*cofind v find locales containing global name y
cofind=: 3 : 0
r=. (<,>y) (4 : 'try. x e. nl__y $0 catch. 0 end.'"0 # ]) 18!:1]0 1
if. 0=#r do. i.0 2 end.
)

NB. =========================================================
NB.*cofindv v find locales and values for global name y
cofindv=: 3 : 0
lcs=. cofind y
if. #lcs do.
  lcs ,. ". each (<y,'_') ,each lcs ,each '_'
end.
)

NB. =========================================================
NB.*coinfo v return info on co classes
NB. returns noun refs;object;creator;path
coinfo=: 3 : 0
ref=. boxxopen y
if. 0 e. $ref do. i.0 4 return. end.
if. 0=4!:0 <'COCREATOR__ref'
do. c=. COCREATOR__ref else. c=. a: end.
(conouns ref),ref,c,< ;:inverse copath ref
)

NB. =========================================================
NB.*conouns v nouns referencing object
conouns=: 3 : 0 "0
n=. nl 0
t=. n#~ (<y)-:&> ".each n
< ;: inverse t
)

NB. =========================================================
NB.*conounsx v object references with locales
NB. returns: object;references;locales
conounsx=: 3 : 0
r=. ''
if. #y do.
  s=. #y=. boxxopen y
  loc=. conl 0
  for_i. loc do. r=. r,conouns__i y end.
  r=. (r~:a:) # (y$~#r),.r,.s#loc
end.
/:~~.r
)

NB. =========================================================
NB.*copathnl v path name list
NB. path name list
copathnl=: 3 : 0
'' copathnl y
:
r=. ''
t=. (coname''),copath coname''
for_i. t -. <,'z' do.
  r=. r,x nl__i y
end.
/:~~.r
)

NB. =========================================================
NB.*copathnlx v formatted path name list with defining classes
copathnlx=: 3 : 0
'' copathnlx y
:
r=. ''
t=. (coname''),copath coname''
for_i. t=. t -. <,'z' do.
  r=. r,<x nl__i y
end.
n=. ~.;r
n,.|:( n&e. &> r) #each t
)

NB. =========================================================
NB.*coselect v select current locale
NB.
coselect_result=: 3 : 0
'r x s'=. y
if. r do.
  runimmx0_jijs_ '18!:4 <''',s,''''
end.
empty''
)

NB. =========================================================
NB.*costate v state of class objects
costate=: 3 : 0
r=. ,: ;:'refs id creator path'
if. #n=. conl 1 do. r,coinfo &> n /: 0 ".&> n end.
)
