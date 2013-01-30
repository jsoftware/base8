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
Ignore=: 0$<''

NB. =========================================================
3 : 0''
nc=. '--no-cache'
if. IFUNIX do.
  if. UNAME-:'Android' do.
    exe=. '"',(jpath '~tools/ftp/wget'),'"'
    try. nc=. nc #~ 1 e. nc E. shell exe,' --help' catch. nc=. '' end.
    HTTPCMD=: exe,' ',nc,' -O %O -o %L -t %t %U'
    UNZIP=: '"',(jpath '~tools/zip/7za'),'" x -y '
  elseif. UNAME-:'Darwin' do.
    HTTPCMD=: 'curl -o %O --stderr %L -f -s -S %U'
  elseif. do.
    try. nc=. nc #~ 1 e. nc E. shell 'wget --help' catch. nc=. '' end.
    HTTPCMD=: 'wget ',nc,' -O %O -o %L -t %t %U'
  end.
else.
  exe=. '"',(jpath '~tools/ftp/wget.exe'),'"'
  try. nc=. nc #~ 1 e. nc E. shell exe,' --help' catch. nc=. '' end.
  HTTPCMD=: exe,' ',nc,' -O %O -o %L -t %t -T %T %U'
  UNZIP=: '"',(jpath '~tools/zip/unzip.exe'),'" -o -C '
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
JRELEASE=: ({.~i.&'/') 9!:14''
NB. !!! 801
JRELEASE=: 'j801'
LIBTREE=: readtree''
WWW=: 'http://www.jsoftware.com/jal/',JRELEASE,'/'
LIBVER=: jpath '~system/config/version.txt'
)

NB. =========================================================
destroy=: codestroy
