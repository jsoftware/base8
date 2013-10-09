NB. load

Loaded=: ''
Public=: i. 0 2
UserFolders=: i. 0 2
Ignore=: ;: 'colib convert coutil dates debug dir dll files libpath strings text'

NB. =========================================================
buildpublic=: 3 : 0
dat=. deb toJ y
dat=. a: -.~ <;._2 dat, LF
ndx=. dat i. &> ' '
short=. ndx {.each dat
long=. ndx }. each dat
long=. extsrc@jpathsep@deb each long
msk=. (<'system','/') = 7 {. each long
long=. (msk{'';'~') ,each long
Public=: sort ~. Public,~ short,.long
empty''
)

NB. =========================================================
NB. cut names on blanks, except in double quotes
NB. if LF given, cut on LF instead
cutnames=: 3 : 0
if. LF e. y do.
  txt=. y, LF
  nms=. (txt = LF) <;._2 txt
else.
  txt=. y, ' '
  msk=. txt = '"'
  com=. (txt = ' ') > ~: /\ msk
  msk=. (msk *. ~:/\msk) < msk <: 1 |. msk
  nms=. (msk # com) <;._2 msk # txt
end.
nms -. a:
)

NB. =========================================================
NB. exist
3 : 0''
if. 0=9!:24'' do.
  exist=: fexist
else.
  exist=: 0:
end.
1
)

NB. =========================================================
NB. convert file/directory name into full fpathname:
fullname=: 3 : 0
p=. '/'
d=. jpath y
NB. do nothing if : occurs before '/'
if. </ d i. ':',p do.
NB. do nothing if // or \\ start
elseif. (2{.d) -: 2#p do.
NB. add dirpath if not starting with '/'
elseif. p ~: 1{.d do.
  jcwdpath d
NB. add drive if WIN32
elseif. IFWIN do.
  (2{.jcwdpath''),d
end.
)

NB. =========================================================
NB. getscripts        - getscripts namelist
NB. converts any short names to full names
NB. converts ~path names
NB. converts path separator
NB. converts paths of form abc/def/etc with no extension to
NB. ~addons/abc/def/etc.ijs
getscripts=: 3 : 0
if. 0=#y do. '' return. end.
if. 0=L.y do.
  if. fexist y do.
    y=. <y
  else.
    y=. cutnames y
  end.
end.
y=. y -. Ignore, IFIOS#<;._1 ' jview qtide ide/qt'
y=. y -. (-.IFIOS)#<;._1 ' ide/ios'
y=. y -. (IFIOS+.IFJHS)#<;._1 ' wdclass gui/wdclass viewmat gl2 graphics/gl2'
y=. y -. (UNAME-:'Android')#<;._1 ' jview'
y=. y -. (UNAME-.@-:'Android')#<;._1 ' droidwd gui/droidwd android gui/android'
y=. y -. IFQT#<;._1 ' droidwd gui/droidwd'
if. 0=#y do. '' return. end.
ndx=. ({."1 Public) i. y
ind=. I. ndx < # Public
y=. ((ind { ndx) { 1 {"1 Public) ind } y
ind=. (i.#y) -. ind
if. #ind do.
  sel=. ind { y
  msk=. -. '.' e. &> sel
  cnt=. +/ &> sel e. each <'/\'
  ndx=. ind #~ msk *. cnt=1
  y=. (addfname each ndx { y) ndx } y
  ndx=. ind #~ msk *. cnt > 0
  sel=. (<'~addons/') ,each (ndx{y) ,each <'.ijs'
  smsk=. (1:@(1!:4) ::0:)@<@jpath &> sel
  y=. (smsk#sel) (smsk#ndx) } y
end.
fullname each jpath each y
)

NB. =========================================================
getpath=: ([: +./\. =&'/') # ]
