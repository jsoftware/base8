NB. break
NB. setbreak 'default' is done by profile
NB. setbreak creates file ~break/Pid.Class
NB.  and writes 0 to the first byte
NB.  Pid is the process id and Class is normally default
NB. setbreak does 9!:47 with this file
NB. 9!:47 maps first byte of file
NB. JE tests this byte for break requests
NB. another task writes 1 or 2 to the file for attention/break
NB. 9!:46 returns filename
NB. break y sets break for JEs with class y
NB. JEs with the same class all get the break
NB. non-default class protects JE from default break
NB. new setbreak replaces old

NB. y is class to signal - '' treated as 'default'
break=: 3 : 0
class=. >(0=#y){y;'default'
p=. 9!:46''
q=. (>:p i: '/'){.p
fs=. (<q),each {."1[1!:0<q,'*.',class
fs=. fs-.<p NB. don't break us
for_f. fs do.
  v=. 2<.>:a.i.1!:11 f,<0 1
  (v{a.) 1!:12 f,<0 NB. 12 not 2
end.
i.0 0
)

NB. y is class
NB. create unique file ~break/Pid.Class
setbreak=: 3 : 0
try.
  p=. jpath '~break/'
  1!:5 ::] <p
  f=. p,(":2!:6''),'.',y
  ({.a.) 1!:12 f;0 NB. 12 not 2
  9!:47 f
  f
catch. '' end.
)
