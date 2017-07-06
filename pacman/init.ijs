NB. =========================================================
NB. Package Manager for JAL - GUI & jconsole interfaces

NB. =========================================================
NB. init

cocurrent 'jpacman'
coinsert 'j'

BASELIB=: 'base library'
DATAMASK=: 0
HWNDP=: ''
ISGUI=: 0
ONLINE=: 0
PKGDATA=: 0 7$a:
SECTION=: ,<'All'
SYSNAME=: 'Package Manager'
TIMEOUT=: 60
WWWREV=: REV=: _1

IgnoreIOS=: 0 : 0
api/jni
data/dbman
data/ddmysql
data/odbc
demos/isigraph
demos/wd
demos/wdplot
games/minesweeper
games/nurikabe
games/pousse
games/solitaire
general/pcall
general/sfl
graphics/d3
graphics/fvj3
graphics/fvj4
graphics/gnuplot
graphics/graph
graphics/graphviz
graphics/grid
graphics/jturtle
graphics/print
graphics/tgsj
graphics/treemap
gui/monthview
gui/util
ide/qt
ide/ja
ide/jnet
math/tabula
media/animate
media/gdiplus
media/image3
media/imagekit
media/ming
media/paint
media/wav
)

Ignore=: 3 : 0''
if. IFIOS do.
  <;._2 IgnoreIOS
else.
  <'ide/ios'
end.
)

NB. =========================================================
3 : 0''
nc=. '--no-cache'
if. IFUNIX do.
  if. UNAME-:'Darwin' do.
    HTTPCMD=: 'curl -o %O --stderr %L -f -s -S %U'
  elseif. do.
    if. 'Android'-:UNAME do. nc=. ''
    else. try. nc=. nc #~ 1 e. nc E. shell 'wget --help' catch. nc=. '' end. end.
    HTTPCMD=: 'wget ',nc,' -O %O -o %L -t %t %U'
  end.
else.
  if. fexist exe=. jpath '~tools/ftp/wget.exe' do. exe=. '"',exe,'"' else. exe=. 'wget.exe' end.
  try. nc=. nc #~ 1 e. nc E. shell exe,' --help' catch. nc=. '' end.
  HTTPCMD=: exe,' ',nc,' -O %O -o %L -t %t -T %T %U'
  if. fexist UNZIP=: jpath '~tools/zip/unzip.exe' do. UNZIP=: '"',UNZIP,'" -o -C ' else. UNZIP=: 'unzip.exe -o -C ' end.
end.
)

NB. =========================================================
NB. setfiles
NB.
NB. form: setfiles 'current'
setfiles=: 3 : 0
ADDCFG=: jpath '~addons/config/'
makedir ADDCFG
ADDCFGIJS=: ADDCFG,'config.ijs'
JRELEASE=: 'j806'
LIBTREE=: readtree''
if. IFIOS do.
  WWW=: '/jal/',JRELEASE,'/'
else.
  WWW=: 'http://www.jsoftware.com/jal/',JRELEASE,'/'
end.
LIBVER=: jpath '~system/config/version.txt'
)

NB. =========================================================
destroy=: codestroy
