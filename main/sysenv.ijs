NB. sysenv - System Environment
NB.
NB. ---------------------------------------------------------
NB. Main definitions are in z:

NB. ---------------------------------------------------------
NB. verbs:
NB.*hostpathsep v  converts path name to use host path separator
NB.*jpathsep v     converts path name to use / separator
NB.*winpathsep v   converts path name to use \ separator
NB.*jcwdpath v     adds path to J current working directory
NB.*jsystemdefs v  loads appropriate netdefs or hostdefs
NB.*IFDEF v        if DEFxxx exists

NB. ---------------------------------------------------------
NB. nouns:
NB.*   IF64          if a 64 bit J system
NB.*   IFIOS         if iOS (iPhone/iPad)
NB.*   IFJCDROID     if JConsole for Android
NB.*   IFJHS         if jhs libraries loaded
NB.*   IFQT          if Qt libraries loaded
NB.*   IFRASPI       if Raspberry Pi
NB.*   IFUNIX        if UNIX
NB.*   IFWIN         if Windows (2000 and up)
NB.*   IFWINCE       if Windows CE
NB.*   IFWINE        if Wine (Wine Is Not an Emulator)
NB.*   IFWOW64       if running J32 on a 64 bit o/s
NB.*   UNAME         name of UNIX o/s

18!:4 <'z'

NB. =========================================================
3 : 0 ''

notdef=. 0: ~: 4!:0 @ <
hostpathsep=: ('/\'{~6=9!:12'')&(I. @ (e.&'/\')@] })
jpathsep=: '/'&(('\' I.@:= ])})
winpathsep=: '\'&(('/' I.@:= ])})
PATHJSEP_j_=: '/'                 NB. should not used in new codes
IFDEF=: 3 : '0=4!:0<''DEF'',y,''_z_'''

NB. ---------------------------------------------------------
IF64=: 16={:$3!:3[2
'IFUNIX IFWIN IFWINCE'=: 5 6 7 = 9!:12''
IFJHS=: 0
IFWINE=: IFWIN > 0-:2!:5'_'   NB. not an 100% reliable test

NB. ---------------------------------------------------------
if. notdef 'IFIOS' do.
  IFIOS=: 0
end.

NB. ---------------------------------------------------------
if. notdef 'IFQT' do.
  IFQT=: 0
  libjqt=: 'libjqt'  NB. avoid name undefined error
end.

NB. ---------------------------------------------------------
if. notdef 'IFJCDROID' do.
  IFJCDROID=: 0
end.

assert. IFQT *: IFJCDROID

NB. ---------------------------------------------------------
if. notdef 'UNAME' do.
  if. IFUNIX do.
    if. -.IFIOS do.
      UNAME=: (2!:0 'uname')-.10{a.
    else.
      UNAME=: 'Darwin'
    end.
  elseif. do.
    UNAME=: 'Win'
  end.
end.

NB. ---------------------------------------------------------
if. notdef 'IFRASPI' do.
  if. UNAME -: 'Linux' do.
    IFRASPI=: 'arm' -: 3{. 2!:0 'uname -m'
  else.
    IFRASPI=: 0
  end.
end.

NB. ---------------------------------------------------------
if. IF64 +. IFIOS +. UNAME-:'Android' do.
  IFWOW64=: 0
else.
  if. IFUNIX do.
    IFWOW64=: '64'-:_2{.(2!:0 'uname -m')-.10{a.
  else.
    IFWOW64=: 'AMD64'-:2!:5'PROCESSOR_ARCHITEW6432'
  end.
end.
)

NB. =========================================================
jcwdpath=: (1!:43@(0&$),])@jpathsep@((*@# # '/'"_),])

NB. =========================================================
jsystemdefs=: 3 : 0
xuname=. UNAME
0!:0 <jpath '~system/defs/',y,'_',(tolower xuname),(IF64#'_64'),'.ijs'
)
