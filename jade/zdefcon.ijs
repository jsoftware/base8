NB. z definitions for jade for console

cocurrent 'z'

NB. =========================================================
NB.*jpath v convert path
NB.*scripts v view script names
jpath=: jpath_j_

NB. =========================================================
NB. load    - load scripts
NB. loadd    - load scripts with display
NB. example:
NB.      load 'files'   - load files script
load=: 3 : 0
0 load y
:
fls=. getscripts_j_ y
fn=. ('script',x#'d')~
for_fl. fls do.
  if. Displayload_j_ do. smoutput > fl end.
  if. -. fexist fl do.
    smoutput 'not found: ',>fl
  end.
  fn fl
  Loaded_j_=: ~. Loaded_j_,fl
end.
empty''
)

loadd=: 1&load

NB. =========================================================
NB. require    - load scripts if not already loaded
require=: 3 : 0
fls=. Loaded_j_ -.~ getscripts_j_ y
if. # fls do. load fls else. empty'' end.
)

NB. =========================================================
NB. scripts    - list scripts in Public
scripts=: scripts_j_

NB. =========================================================
NB.*show v show names using a linear representation
NB. show names using a linear representation to screen width
NB. syntax:
NB.   show namelist  (e.g. show 'deb edit list')
NB.   show numbers   (from 0 1 2 3=nouns, adverbs etc)
NB.   show ''        (equivalent to show 0 1 2 3)
NB. useful for a quick summary of object definitions
show=: 3 : 0
y=. y,(0=#y)#0 1 2 3
if. (3!:0 y) e. 2 32 do. y=. cutopen y
else. y=. (4!:1 y) -. (,'y');,'y.' end.
wid=. {.wcsize''
sub=. '.'&(I. @(e.&(9 10 12 13 127 254 255{a.))@]})
j=. '((1<#$t)#(":$t),''$''),":,t'
j=. 'if. L. t=. ".y do. 5!:5 <y return. end.';j
j=. 'if. 0~:4!:0 <y do. 5!:5 <y return. end.';j
a=. (,&'=: ',sub @ (3 : j)) each y
; ((wid <. #&> a) {.each a) ,each LF
)

NB. =========================================================
NB. xedit    - list xedit in Public
NB.*xedit v load file in external editor
NB. syntax:
NB.   xedit file [ ; row ]   (row is optional and is 0-based)
xedit=: xedit_j_

NB. =========================================================
NB. *wcsize v return columns and rows of console
NB. syntax:
NB.   wcsize ''   (argument is ignored)
wcsize=: 3 : 0
if. (-.IFQT+.IFJHS+.IFIOS) *. UNAME-:'Linux' do.
  |.@".@(-.&LF)@(2!:0) :: (Cwh_j_"_) '/bin/stty size 2>/dev/null'
else.
  Cwh_j_
end.
)
