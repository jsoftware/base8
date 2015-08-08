NB. stdlib definitions
NB.-This definitions are called from the standard library

NB. =========================================================
NB. do_install v install from jal
NB. y is one of:
NB. 'all'    install all (including jqt binaries)
NB. 'qtide'  just qtide and jqt binaries
NB. other    usual call to 'install' jpkg other
do_install=: 3 : 0
if. -. checkaccess_jpacman_ '' do. return. end.
'update' jpkg ''
if. -. (<y) e. 'all';'qtide' do.
  'install' jpkg y return.
end.
if. IFQT+.IFIOS+.'Android'-:UNAME do.
  smoutput 'Must run from jconsole' return.
end.
'install' jpkg (y-:'all') pick 'base library ide/qt';'all'
getqtbin 0
msg=. (+/ 2 1 * IFWIN,'Darwin'-:UNAME) pick 'jqt.sh';'the jqt icon';'jqt.cmd'
smoutput 'Exit and restart J using ',msg
)

NB. =========================================================
NB. do_getqtbin v get Qt binaries
do_getqtbin=: 3 : 0

NB. ---------------------------------------------------------
smoutput 'Installing JQt binaries...'
if. 'Linux'-:UNAME do.
  if. IFRASPI do.
    z=. 'jqt-raspi-32.tar.gz'
  else.
    z=. 'jqt-',((y-:'slim') pick 'linux';'slim'),'-',(IF64 pick 'x86';'x64'),'.tar.gz'
  end.
  z1=. 'libjqt.so'
elseif. IFWIN do.
  z=. 'jqt-win',((y-:'slim')#'slim'),'-',(IF64 pick 'x86';'x64'),'.zip'
  z1=. 'jqt.dll'
elseif. do.
  z=. 'jqt-mac',((y-:'slim')#'slim'),'-',(IF64 pick 'x86';'x64'),'.zip'
  z1=. 'libjqt.dylib'
end.
'rc p'=. httpget_jpacman_ 'http://www.jsoftware.com/download/j804/qtide/',z
if. rc do.
  smoutput 'unable to download: ',z return.
end.
d=. jpath '~bin'
if. IFWIN do.
  unzip_jpacman_ p;d
else.
  if. 'Linux'-:UNAME do.
    if. (0~:FHS) do.
      if. IFRASPI do.
        d1=. '/usr/lib/arm-linux-gnueabihf/.'
      elseif. IF64 do.
        d1=. '/usr/lib/x86_64-linux-gnu/.'
      elseif. do.
        d1=. '/usr/lib/i386-linux-gnu/.'
      end.
      hostcmd_jpacman_ 'cd /usr/bin && tar --no-same-owner --no-same-permissions -xzf ',(dquote p), ' && chmod 755 jqt && chmod 644 libjqt.so && mv libjqt.so ',d1
    else.
      hostcmd_jpacman_ 'cd ',(dquote d),' && tar xzf ',(dquote p)
    end.
  else.
    hostcmd_jpacman_ 'unzip -o ',(dquote p),' -d ',dquote d
  end.
end.
ferase p
if. #1!:0 ((0~:FHS)*.'Linux'-:UNAME){::(jpath '~bin/',z1);'/usr/bin/jqt' do.
  m=. 'Finished install of JQt binaries.'
else.
  m=. 'Unable to install JQt binaries.',LF
  m=. m,'check that you have write permission for: ',LF,((0~:FHS)*.'Linux'-:UNAME){::(jpath '~bin');'/usr/bin'
end.
smoutput m

NB. ---------------------------------------------------------
NB. install Qt library:
if. 'Linux'-:UNAME do. return. end.

tgt=. jpath IFWIN{::'~install/Qt';'~bin/Qt5Core.dll'
y=. (*#y){::0;y
NB. if. (0-:y) *. 1=#1!:0 tgt do. return. end.

smoutput 'Installing Qt library...'
if. IFWIN do.
  z=. 'qt54-win-',((y-:'slim')#'slim-'),(IF64 pick 'x86';'x64'),'.zip'
else.
  z=. 'qt54-mac-',((y-:'slim')#'slim-'),(IF64 pick 'x86';'x64'),'.zip'
end.
'rc p'=. httpget_jpacman_ 'http://www.jsoftware.com/download/j804/qtlib/',z
if. rc do.
  smoutput 'unable to download: ',z return.
end.
d=. jpath IFWIN{::'~install';'~bin'
if. IFWIN do.
  unzip_jpacman_ p;d
else.
  hostcmd_jpacman_ 'unzip -o ',(dquote p),' -d ',dquote d
end.
ferase p
if. #1!:0 tgt do.
  m=. 'Finished install of Qt binaries.'
else.
  m=. 'Unable to install Qt binaries.',LF
  m=. m,'check that you have write permission for: ',LF,IFWIN{::tgt;jpath'~bin'
end.
smoutput m

)
