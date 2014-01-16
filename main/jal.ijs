NB. jal definitions
NB.%jal.ijs - jal utilities
NB.-This script defines jal utilities and is included in the J standard library.
NB.-Definitions are loaded into the z locale.

cocurrent 'z'

NB. =========================================================
NB.*install v install from jal
NB.-Install from jal.
NB.-
NB.-y is either 'qtide' to install the Qt IDE, or 'all' to install all jal packages.
install=: 3 : 0
if. IFIOS+.'Android'-:UNAME do. return. end.
require 'pacman'
if. -. checkaccess_jpacman_ '' do. return. end.
'update' jpkg ''
select. y
case. 'qtide' do.
  'install' jpkg 'base library ide/qt'
  getqtbin 0
  smoutput 'exit and restart J using ',IFWIN pick 'bin/jqt';(fexist jpath '~install/jqt.cmd'){::'bin/jqt.exe';'jqt.cmd'
case. 'all' do.
  'install' jpkg 'all'
  getqtbin 0
end.
)

NB. =========================================================
NB.*getqtbin v get Qt binaries
NB.-Get Qt binaries.
NB.-
NB.-Always downloads the jqt binary.
NB.-
NB.-For the qt library (required for mac and win):
NB.- y is 0 - download if not present
NB.-      1 - always download
getqtbin=: 3 : 0
if. IFIOS+.'Android'-:UNAME do. return. end.
if. (<UNAME) -.@e. 'Linux';'Darwin';'Win' do. return. end.

require 'pacman'
IFPPC=. 0
if. 'Darwin'-:UNAME do. IFPPC=. 1. e. 'powerpc' E. 2!:0 'uname -p' end.

NB. ---------------------------------------------------------
smoutput 'Installing JQt binaries...'
if. 'Linux'-:UNAME do.
  if. IFRASPI do.
    z=. 'jqt-raspi-32.tar.gz'
  else.
    z=. 'jqt-linux-',(IF64 pick 'x86';'x64'),'.tar.gz'
  end.
  z1=. 'libjqt.so'
elseif. IFWIN do.
  z=. 'jqt-win-',(IF64 pick 'x86';'x64'),'.zip'
  z1=. 'jqt.dll'
elseif. do.
  z=. 'jqt-mac-',(IFPPC pick (IF64 pick 'x86';'x64');'ppc'),'.zip'
  z1=. 'libjqt.dylib'
end.
'rc p'=. httpget_jpacman_ 'http://www.jsoftware.com/download/jqt/',z
if. rc do.
  smoutput 'unable to download: ',z return.
end.
d=. jpath '~bin'
if. IFWIN do.
  unzip_jpacman_ p;d
else.
  if. 'Linux'-:UNAME do.
    hostcmd_jpacman_ 'cd ',(dquote d),' && tar xzf ',(dquote p)
  else.
    hostcmd_jpacman_ 'unzip -o ',(dquote p),' -d ',dquote d
  end.
  f=. 4 : 'if. #1!:0 y do. x dirss y end.'
  ('INSTALLPATH';jpath '~install') f jpath '~bin'
end.
if. #1!:0 jpath '~bin/',z1 do.
  m=. 'Finished install of jqt binaries.'
else.
  m=. 'Unable to install jqt binaries.',LF
  m=. m,'check that you have write permission for: ',LF,jpath '~bin'
end.
smoutput m

NB. ---------------------------------------------------------
NB. install Qt library:
if. 'Linux'-:UNAME do. return. end.
if. ('Darwin'-:UNAME) *. 1=#1!:0 jpath '/Library/Frameworks/QtCore.framework' do. return. end.

tgt=. jpath '~install/',(IFWIN{'Qq'),'t'
if. (0={.y,0) *. 1=#1!:0 tgt do. return. end.

smoutput 'Installing Qt library...'
if. IFWIN do.
  z=. 'qt48-win-',(IF64 pick 'x86';'x64'),'.zip'
else.
  z=. 'qt48-mac-',(IFPPC pick (IF64 pick 'x86';'x64');'ppc'),'.zip'
end.
'rc p'=. httpget_jpacman_ 'http://www.jsoftware.com/download/qtlib/',z
if. rc do.
  smoutput 'unable to download: ',z return.
end.
d=. jpath '~install'
if. IFWIN do.
  unzip_jpacman_ p;d
  if. -.fexist jpath '~install/jqt.cmd' do.
    smoutput 'move Qt library to bin'
    spawn_jtask_ 'cmd /k rmdir /s /q "',('/\' charsub jpath '~install/plugins'),'" > nul'
    (jpath '~install/plugins') frename (jpath '~install/qt/plugins')
    for_fn. {."(1) 1!:0 jpath '~install/qt/*' do.
      1!:55 ::0: <jpath '~bin/',>fn
      (jpath '~bin/',>fn) frename (jpath '~install/qt/',>fn)
    end.
    'Do not delete this folder' 1!:2 <jpath '~install/qt/dummy.txt'
  end.
else.
  hostcmd_jpacman_ 'unzip -o ',(dquote p),' -d ',dquote d
end.
if. #1!:0 tgt do.
  m=. 'Finished install of Qt binaries.'
else.
  m=. 'Unable to install Qt binaries.',LF
  m=. m,'check that you have write permission for: ',LF,tgt
end.
smoutput m

)
