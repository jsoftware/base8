NB. jal definitions

cocurrent 'z'

NB. =========================================================
install=: 3 : 0
if. 'Android'-:UNAME do. return. end.
require 'pacman'
if. -. checkaccess_jpacman_ '' do. return. end.
'update' jpkg ''
select. y
case. 'qtide' do.
  'install' jpkg 'base library ide/qt'
  getqtbin 0
  smoutput 'exit and restart J using bin/jqt',IFWIN#'.exe'
case. 'all' do.
  'install' jpkg 'all'
  getqtbin 0
end.
)

NB. =========================================================
NB. get Qt linux or mac or win binaries
NB. y is 0 - download if not present
NB.      1 - always download
getqtbin=: 3 : 0
if. (<UNAME) -.@e. 'Linux';'Darwin';'Win' do. return. end.
if. (0={.y,0) *. 0 < #1!:0 jpath '~bin/jqt',IFWIN#'.exe' do. return. end.
require 'pacman'
smoutput 'Installing jqt binaries...'
if. 'Linux'-:UNAME do.
  z=. 'jqt-','linux-',(IF64 pick 'x86';'x64'),'.tar.gz'
  z1=. 'libjqt.so'
else.
  z=. 'jqt-',(IFWIN pick 'mac-';'win-'),(IF64 pick 'x86';'x64'),'.zip'
  z1=. IFWIN pick 'libjqt.dylib';'jqt.dll'
end.
z=. 'http://www.jsoftware.com/download/jqt/',z
'rc p'=. httpget_jpacman_ z
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
    hostcmd_jpacman_ 'unzip ',(dquote p),' -d ',dquote d
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
if. 'Linux'-:UNAME do. return. end.
smoutput 'Installing Qt binaries...'
z=. 'qt48-',(IFWIN pick 'mac-';'win-'),(IF64 pick 'x86';'x64'),IFWIN pick '.dmg';'.zip'
z=. 'http://www.jsoftware.com/download/qtlib/',z
'rc p'=. httpget_jpacman_ z
if. rc do.
  smoutput 'unable to download: ',z return.
end.
d=. jpath '~install'
if. IFWIN do.
  unzip_jpacman_ p;d
  if. #1!:0 jpath '~install/qt' do.
    m=. 'Finished install of Qt binaries.'
  else.
    m=. 'Unable to install Qt binaries.',LF
    m=. m,'check that you have write permission for: ',LF,jpath '~install/qt'
  end.
else.
  m=. 'in Finder, open ',p,LF
  m=. m,' and do a standard install of both packages'
NB.   hostcmd_jpacman_ 'unzip ',(dquote p),' -d ',dquote d
NB.   f=. 4 : 'if. #1!:0 y do. x dirss y end.'
NB.   ('INSTALLPATH';jpath '~install') f jpath '~install/qt'
end.
smoutput m
)
