NB. jengine
NB.
NB. usage:
NB. 'jengine' install y   calls  jengine_install_jpacman y
NB.
NB. y is:
NB.   ''            lists current and available engines
NB.   engine_name   installs new engine

NB. NB. usage:
NB. NB.    jengine_set_jpacman_'j805-release' or 'j806-beta'
NB. NB.    jengine_install_jpacman_''    NB. install from jengine_set folder
NB. NB.
NB. NB.    jengine_status_jpacman_''     NB. 9!:14 from current and latest  - prepare for update
NB. NB.    jengine_update_jpacman_''     NB. update to JE prepared by status
NB. NB.
NB. NB.    jengine_report_jpacman_''     NB. report 9!:14 engines in jengine_set folder
NB. NB.    jengine_version_jpacman_ file NB. 9!:14 from file

cocurrent 'jpacman'

jengine_set=: 3 : 0
erase ;:'JENGINE_TYPE AVX'
if. y-:'j805-release' do.
 JENGINE_TYPE=: y
 AVX=: ''
elseif. y-:'j806-beta' do.
 JENGINE_TYPE=: y
 AVX=: 'AVX' NB. hardwire avx for now
elseif. 1 do.
 'folder not supported'assert 0
end.
)

jengine_install=: 3 : 0
jengine_set 'j805-release'  NB. !!! hardwired for now
jengine_status''
if. 0=#y do. return. end.
if. _1=nc<'JENEW' do. return. end.
if. UNAME-:'Android' do. return. end.
jengine_update y
)

seebox=: 3 : ';((1+>./>#each y){.each "1 y),.<LF'

jengine_status=: 3 : 0
NB. 'jengine_set must be run first'assert 0=nc<'JENGINE_TYPE'
'only valid for j8xx'assert'8'=1{9!:14''
'plat name bname'=. jengine_sub''
'update not supported for this type of install'assert 1=ftype bname
path=. 'http://www.jsoftware.com/download/jengine/',JENGINE_TYPE,'/'
erase'JENEW'
jeold=. fread bname
tname=. '~temp/',name
ferase tname
httpget path,'P/jX/N' rplc 'P';plat;'N';name;'X';AVX,~;IF64{'32';'64'
jenew=. fread tname
t=. <;._1 '/now/',9!:14''
if. 3=#t do. t=. (2{.t),(5#a:),{:t end.
echo seebox t,:<;._1 '/new/',jengine_version tname
if. jenew-:jeold do. echo'already installed' return. end.
JENEW=: jenew
i.0 0
)

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

jengine_update=: 3 : 0
'plat name bname'=. jengine_sub''
NB. access test previously included: (0=ftype '~bin/',name)+.
'access error - protected folder - must run as admin/sudo'assert testaccessfile bname,'.temp'
'must first run jengine_status'assert 0=nc<'JENEW'
jeold=. fread bname
oname=. bname,'.original'
renamed=. bname,'.',((isotimestamp 6!:0'')rplc' ';'-';':';'-';'.';'-'),'.renamed'
if. -.fexist oname do.
 echo oname,' : copy of orginal created'
 jeold fwrite oname
else.
 echo oname,' : copy of originial already exists'
end.
renamed frename bname
echo bname,' renamed as ',renamed
JENEW fwrite bname
if. (UNAME-:'Linux') *. '/usr/lib/'-:9{.bname do.
 shellcmd ' chmod 644 ',bname
end.
erase'JENEW'
echo'new JE installed'
echo'this J instance continues to use the old image'
echo'!!! shutdown J, restart, and check 9!:14'''' !!!'
i.0 0
)

jengine_sub=: 3 : 0
i=. ('Win';'Darwin')i.<UNAME
plat=. ;i{'windows';'darwin';'linux'
name=. ;i{'j.dll';'libj.dylib';'libj.so'
bname=. '~bin/',name
if. 1~:ftype bname do.
  if. UNAME-:'Linux' do.
    v=. ({.~i.&'/')}.9!:14''
    sub=. '' [ '.',({.v),'.',}.v    NB. x j805 -> libj.so.8.05
    sub=. '.8.05' NB. hardwired
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

NB. get 9!:14'' result from JE file
jengine_version=: 3 : 0
d=. fread y
'not a file'assert _1~:d
'not a JE' assert (1 i.~'non-unique sparse elements' E. d)<#d
i=. 1 i.~'je9!:14' E. d
if. i=#d do. 'unknown' return. end.
d=. d}.~8+i
s=. d{.~d i. {.a.
s=. s-.LF,12{a. NB. some early ones had Lf and FF chars
dt=. _20{.s
date=. 11{.dt
m=. 2":>:(;:'Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec')i.<3{.date
date=. ((_4{.date),'-',m,'-',4 5{date)rplc' ';'0'
(_20}.s),date,11}.dt
)

engines=: <;._2 [ 0 : 0
windows/j64/j.dll
windows/j64avx/j.dll
windows/j32/j.dll
linux/j64/libj.so
linux/j64avx/libj.so
linux/j32/libj.so
darwin/j64/libj.dylib
darwin/j64avx/libj.dylib
raspberry/j32/libj.so
)

NB. y is j805-release or j805-beta
jengine_report=: 3 : 0
e=.  engines,~each <JENGINE_TYPE,'/'
e,.jengine_version_from_web each e
)

jengine_version_from_web=: 3 : 0
try.
 name=. (y i:'/')}.y
 path=. 'www.jsoftware.com/download/jengine/',y
 tname=. '~temp/',(>:y i:'/')}.y
 ferase tname
 httpget path
 jengine_version tname
catch.
 'httpget failed'
end.
)
