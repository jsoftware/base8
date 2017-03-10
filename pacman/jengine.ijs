NB. jengine
NB.
NB. 'jengine' install y   calls  jengine_install_jpacman_ y
NB.
NB. where y is:
NB.  '' or 'status'     lists current and available engines
NB.   engine_name       installs new engine

cocurrent 'jpacman'

JEpath=: 'http://www.jsoftware.com/download/jengine'

NB. =========================================================
NB. called by 'jengine' install ...
jengine_install=: 3 : 0
y=. y,(0=#y)#'status'
'only valid for j8xx'assert'8'=1{9!:14''
'plat name bname'=. jengine_sub''
'update not supported for this type of install'assert 1=ftype bname
jens=. jengine_version_from_web''
if. jens -: 0 do. return. end.
if. y -: 'status' do.
  jengine_status jens
else.
  jengine_update jens;y
end.
)

NB. =========================================================
jengine_status=: 3 : 0
t=. 'Current engine: ',(9!:14''),LF2
if. 0=#y do.
  t=. t,'No new engines are available for this platform.'
else.
  t=. t,'Available engines:',,LF,.":('name';'version'),y
  t=. t,LF2,'To install a new engine, call ''jengine'' install with the engine name, e.g.',LF2
  t=. t,'   ''jengine'' install ''',(0 0{::y),''''
end.
echo t
)

NB. =========================================================
testaccessfile=: 3 : 0
f=. <jpath y
try.
  '' 1!:2 f
  1!:55 f
  1
catch.
  0
end.
)

NB. =========================================================
NB. argument is engine name
jengine_update=: 3 : 0
'jens id'=. y
if. jens-:0 do. return. end.
if. 0=#jens do.
  echo 'No new engines are available for this platform.' return.
end.
if. -. (<id) e. {."1 jens do.
  echo 'There is no new engine with this name: ',id return.
end.
'plat name bname'=. jengine_sub''
'access error - protected folder - must run as admin/sudo'assert testaccessfile bname,'.temp'
'rc p'=. httpget JEpath,'/',id,'/',name
if. rc do.
  echo 'httpget failed when downloading the engine' return.
end.
jenew=. fread p
jeold=. fread bname
oname=. bname,'.original'
renamed=. bname,'.',((isotimestamp 6!:0'')rplc' ';'-';':';'-';'.';'-'),'.renamed'
if. -.fexist oname do.
  echo oname,' : copy of original created'
  jeold fwrite oname
else.
  echo oname,' : copy of original already exists'
end.
renamed frename bname
echo bname,' renamed as ',renamed
jenew fwrite bname
if. (UNAME-:'Linux') *. 1~:ftype '~bin/',name do.
  hostcmd_j_ ' chmod 644 ',bname
end.
echo'new JE installed'
echo'this J instance continues to use the old image'
echo'shutdown J, restart, and check 9!:14'''''
i.0 0
)

NB. =========================================================
jengine_sub=: 3 : 0
i=. ('Win';'Darwin')i.<UNAME
plat=. ;i{'windows';'darwin';'linux'
name=. ;i{'j.dll';'libj.dylib';'libj.so'
bname=. '~bin/',name
if. 1~:ftype bname do.
  if. UNAME-:'Linux' do.
    v=. ({.~i.&'/')}.9!:14''
    sub=. '' [ '.',({.v),'.',}.v    NB. x j806 -> libj.so.8.06
    sub=. '.8.06' NB. hardwired
    if. IFRASPI do.
      bname=. '/usr/lib/arm-linux-gnueabihf/',name,sub
    elseif. IF64 do.
      bname=. '/usr/lib/x86_64-linux-gnu/',name,sub
    elseif. do.
      bname=. '/usr/lib/i386-linux-gnu/',name,sub
    end.
  end.
end.
plat;name;bname
)

NB. =========================================================
NB. read new engine versions from web
jengine_version_from_web=: 3 : 0
'rc p'=. httpget JEpath,'/jengine.txt'
if. rc do.
  echo 'Could not read jengine directory from J website'
  0 return.
end.
plat=. 0 pick jengine_sub''
r=. 'b' fread p
r=. r #~ (1 e. (>IF64{'j32';'j64') E.]) &> r
r=. r #~ (1 e. plat E. ]) &> r
r=. ((i.&' ') ({.;}.@}.) ]) &> r
r #~ (<9!:14'') ~: {:"1 r
)
